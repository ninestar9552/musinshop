//
//  Product.swift
//  musinshop
//
//  Created by cha on 2/3/25.
//

public struct ProductResponse: Codable, Equatable, Identifiable {
    public let id: Int
    public let name: String
    public let price: Int
    public let discountRate: Double
    public let stockQuantity: Int
    public let thumbnailImageUrl: String?
    public let manufacturerName: String
    public let manufacturerLogo: String?
    public let itemNumber: String?
    public let gender: String?
    public let shortDescription: String?
    public let imageUrls: [String]?
    public let color: String?
    public let parentCategoryName: String?
    public let categoryName: String?
}


public struct ProductOptionResponse: Codable {
    public let type: Int // 1: color&size, 2: color, 3: size, 4: other
    public let colorOptions: [ProductColorOption]?
    public let sizeOptions: [ProductOtherOption]?
    public let otherOptions: [ProductOtherOption]?
}

public struct ProductColorOption: Codable {
    public let id: Int
    public let image: String?
    public let name: String
}

public struct ProductOtherOption: Codable {
    public let id: Int
    public let name: String
}

public struct ProductOptionRequest: Codable {
    public let type: Int // 1: color&size, 2: color, 3: size, 4: other
    public let count: Int // 구매수량
    public let colorOptionId: Int?
    public let sizeOptionId: Int?
    public let otherOptionId: Int?
}

public struct ProductOrderRequest: Codable {
    public let productId: Int
    public let orderOptions: [ProductOptionRequest]
}
