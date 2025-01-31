//
//  BsAuth.swift
//  BaeknyeonSamgyetang
//
//  Created by cha on 11/4/24.
//

import Foundation

public let MSAUTH = MSAuth.shared

public class MSAuth {
    static public let shared = MSAuth()
    
    public var tokenManager: TokenManagable
    
    public init(tokenManager : TokenManagable = TokenManager.manager) {
        self.tokenManager = tokenManager
    }
    
    /// ## 커스텀 토큰 관리자
    /// TokenManagable 프로토콜을 구현하여 직접 토큰 관리자를 구현할 수 있습니다.
    public func setTokenManager(_ tokenManager: TokenManagable = TokenManager.manager) {
        self.tokenManager = tokenManager
    }
}
