//
//  AuthRepository.swift
//  musinshop
//
//  Created by cha on 11/15/24.
//

protocol ProductRepository {
    func getCategoryList() async throws -> CommonResponse<[Category]>
}

final class ProductRepositoryImpl: ProductRepository {
    
    func getCategoryList() async throws -> CommonResponse<[Category]> {
        let request = APIEndPoint.Product.getCategoryList()
        return try await API.request(request)
    }
}
