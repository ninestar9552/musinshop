//
//  SnsLoginRequest.swift
//  musinshop
//
//  Created by cha on 11/4/24.
//

public struct TokenResponse: Codable, Equatable {
    let tokenType: String
    let accessToken: String
    let refreshToken: String
    let expiresIn: Int
    let username: String?
    
    public static func == (lhs: TokenResponse, rhs: TokenResponse) -> Bool {
        lhs.accessToken == rhs.accessToken && lhs.refreshToken == rhs.refreshToken
    }
}
