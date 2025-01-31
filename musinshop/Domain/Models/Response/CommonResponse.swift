//
//  CommonResponse.swift
//  musinshop
//
//  Created by cha on 11/11/24.
//

public struct CommonResponse<T: Codable>: Codable {
    let status: Int
    let message: String?
    let data: T?
}
