//
//  AuthRequestAdapter.swift
//  BaeknyeonSamgyetang
//
//  Created by cha on 11/4/24.
//

import Foundation
import Alamofire

public class AuthRequestAdapter : RequestInterceptor {
    public init() {}
    
    public func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var urlRequest = urlRequest
                
        if let accessToken = MSAUTH.tokenManager.getToken()?.accessToken {
            urlRequest.headers.add(.authorization(bearerToken: accessToken))
        }
        return completion(.success(urlRequest))
    }
}
