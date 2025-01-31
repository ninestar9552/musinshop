//
//  API.swift
//  BaeknyeonSamgyetang
//
//  Created by cha on 11/4/24.
//

import Foundation
import Alamofire

public let API = Api.shared

public enum SessionType {
    case BasicApi   //Basic
    case BearerApi    //Bearer
}

// MARK: - Network Error
enum NetworkError: Error {
    case invalidURL
    case invalidToken(String)
    case noData
    case decodingError
    case unauthorized
    case serverError(String)
    case unknown(Error)
}

public class Api {
    public static let shared = Api()
    
    public let encoding : ParameterEncoding
    
    public var sessions : [SessionType:Session] = [SessionType:Session]()
    
    public init() {
        self.encoding = JSONEncoding(options: .prettyPrinted)
        initSession()
    }
}

extension Api {
    private func initSession() {
        let interceptor = Interceptor(adapter: AuthRequestAdapter(), retrier: AuthRequestRetrier())
        let authApiSessionConfiguration : URLSessionConfiguration = URLSessionConfiguration.default
        authApiSessionConfiguration.tlsMinimumSupportedProtocol = .tlsProtocol12
        addSession(type: .BearerApi, session:Session(configuration: authApiSessionConfiguration, interceptor: interceptor))
        
        let basicSessionConfiguration : URLSessionConfiguration = URLSessionConfiguration.default
        basicSessionConfiguration.tlsMinimumSupportedProtocol = .tlsProtocol12
        addSession(type: .BasicApi, session:Session(configuration: basicSessionConfiguration))
    }
    
    public func addSession(type:SessionType, session:Session) {
        if self.sessions[type] == nil {
            self.sessions[type] = session
        }
    }
    
    public func session(_ sessionType: SessionType) -> Session {
        return sessions[sessionType] ?? sessions[.BasicApi]!
    }
}

extension Api {
    
    func request<T: Decodable>(session: Session, url: String, method: HTTPMethod, parameters: Parameters?, headers: HTTPHeaders) async throws -> T {
        return try await self.request(
            session.request(
                url,
                method: method,
                parameters: parameters,
                encoding: method == .get ? URLEncoding.default : JSONEncoding.default,
                headers: headers
            )
        )
    }
    
    func request<T: Decodable>(_ request: DataRequest) async throws -> T {
        let afRequest = request
            .validate()
        
        // Request 로그 기록
        BsLog.d("==== API Request ====")
        let urlString = request.request?.url?.absoluteString ?? ""
        BsLog.d("URL: \(urlString)")
        BsLog.d("Method: \(request.request?.method?.rawValue ?? "")")
        BsLog.d("Headers: \(request.request?.headers.description ?? "")")
        BsLog.d("Parameters: \(String(data: request.request?.httpBody ?? Data(), encoding: .utf8))")
        
        do {
            let dataResponse = try await afRequest.serializingData().value
            
            BsLog.d("==== API Response ====")
            if let responseString = String(data: dataResponse, encoding: .utf8) {
                // Raw Response 로그 기록
                BsLog.d("Raw Response Data: \(responseString)")
            }
            
            // Decodable 객체로 변환
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(DateFormatterManager.shared.formatter(withFormat: DateFormatterManager.shared.serverFormat))
            let response = try decoder.decode(T.self, from: dataResponse)
            
            // 성공 Response 로그 기록
            BsLog.d("URL: \(afRequest.description)")
            BsLog.d("Status Code: \(afRequest.response?.statusCode ?? -1)")
            BsLog.d("Response Data: \(response)")
            return response
        } catch {
            // 실패 시 Response 로그 기록
            if let afError = error as? AFError {
                BsLog.d("==== API Error ====")
                BsLog.d("URL: \(afRequest.description)")
                BsLog.d("Status Code: \(afRequest.response?.statusCode ?? -1)")
                BsLog.d("AFError: \(afError)")
            } else {
                BsLog.d("==== API Unknown Error ====")
                BsLog.d("URL: \(urlString)")
                BsLog.d("Error: \(error)")
            }
            throw error
        }
    }
}
