//
//  AuthApi.swift
//  BaeknyeonSamgyetang
//
//  Created by cha on 11/6/24.
//

import Foundation
import Alamofire

protocol APIRequest {
    associatedtype RequestBody: Encodable
    associatedtype ResponseType: Decodable
    
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var requiresAuth: Bool { get }
    var headers: [String: String]? { get }
    var body: RequestBody? { get }
}

// 기본 구현 제공
extension APIRequest {
    var baseURL: String { Urls.baseUrl }
    var requiresAuth: Bool { true }
    var headers: [String: String]? { nil }
}

// MARK: - Request Implementation
struct Request<Body: Encodable, Response: Decodable>: APIRequest {
    typealias RequestBody = Body
    typealias ResponseType = Response
    
    let path: String
    let method: HTTPMethod
    let requiresAuth: Bool
    let body: Body?
    
    init(
        path: String,
        method: HTTPMethod,
        requiresAuth: Bool = true,
        body: Body? = nil
    ) {
        self.path = path
        self.method = method
        self.requiresAuth = requiresAuth
        self.body = body
    }
}

extension Api {
    
    // API 통신코드 작성
    func request<R: APIRequest>(_ request: R) async throws -> R.ResponseType {
        let session = request.requiresAuth ? sessions[.BearerApi]! : sessions[.BasicApi]!
        var headers = request.headers ?? [:]
        
        let parameters: [String: Any]?
        if let body = request.body,
           let data = try? JSONEncoder().encode(body),
           let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
            parameters = json
        } else {
            parameters = nil
        }
        
        // Request 구성
        let urlString = request.baseURL + request.path
        
        return try await self.request(
            session: session,
            url: urlString,
            method: request.method,
            parameters: parameters,
            headers: HTTPHeaders(headers)
        )
    }
}


enum APIEndPoint {
    
    struct Product {
        static func getCategoryList() -> Request<EmptyBody, CommonResponse<[Category]>> {
            Request(
                path: Urls.getCategoryList,
                method: .get
            )
        }
    }
}
