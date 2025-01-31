//
//  TokenManagable.swift
//  BaeknyeonSamgyetang
//
//  Created by cha on 11/4/24.
//

import Foundation

public protocol TokenManagable {
    
    // MARK: Methods
    
    /// 토큰을 저장합니다.
    func setToken(_ token:TokenResponse?)
    
    /// 저장된 토큰을 가져옵니다.
    func getToken() -> TokenResponse?
    
    /// 저장된 토큰을 삭제합니다.
    func deleteToken()
}
