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
