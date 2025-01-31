//
//  BsError.swift
//  musinshop
//
//  Created by cha on 11/5/24.
//

import Foundation


public enum BsError : Error, LocalizedError {
    /// 클라이언트 에러
    case ClientError(message: String)
    
    /// `LocalizedError` 프로토콜 구현
    public var errorDescription: String? {
        switch self {
        case .ClientError(let message):
            return message
        }
    }
}
