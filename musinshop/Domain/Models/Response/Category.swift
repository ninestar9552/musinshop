//
//  FoodMenuResponse.swift
//  BaeknyeonSamgyetang
//
//  Created by cha on 1/15/25.
//

public struct Category: Codable, Equatable, Identifiable {
    public let id: Int
    public let name: String
    public let parentId: Int?
    public let children: Int?
}
