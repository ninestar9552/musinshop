//
//  TokenManager.swift
//  musinshop
//
//  Created by cha on 11/5/24.
//

import Foundation

/// 토큰 관리자입니다.
///
/// 로그인 기반 API를 호출할 때 이 곳에 저장된 토큰을 사용합니다. 토큰은 UserDefaults에 저장되며 기기 고유값을 이용해 암호화하여 저장됩니다.
///
/// - seealso: `TokenManagable`
final public class TokenManager : TokenManagable {
    
    // MARK: Fields
    
    /// 간편한 사용을 위한 싱글톤 객체입니다.
    static public let manager = TokenManager()
    
    let TokenKey = "com.musinshop.orderapp.token"
    
    var token : TokenResponse?
    
    /// :nodoc: 토큰 관리자를 초기화합니다. UserDefaults에 저장되어 있는 토큰을 읽어옵니다.
    public init() {
        self.token = Properties.loadCodable(key:TokenKey)
    }
    
    
    // MARK: TokenManagable Methods
    
    /// UserDefaults에 토큰을 저장합니다.
    public func setToken(_ token: TokenResponse?) {
        Properties.saveCodable(key:TokenKey, data:token)
        self.token = token
    }
    
    /// 현재 토큰을 가져옵니다.
    public func getToken() -> TokenResponse? {
        return self.token
    }
    
    /// UserDefaults에 저장된 토큰을 삭제합니다.
    public func deleteToken() {
        Properties.delete(TokenKey)
        self.token = nil
    }
}
