//
//  UserApiService.swift
//  musinshop
//
//  Created by cha on 11/6/24.
//

protocol ProductService {
    func getCategoryList() async throws -> [Category]
    func getProductList(_ categoryId: Int) async throws -> [ProductResponse]
    func getProductDetail(_ id: Int) async throws -> ProductResponse
}

final public class ProductServiceImpl: ProductService {
    
    private let repository: ProductRepository
    
    init(repository: ProductRepository = ProductRepositoryImpl()) {
        self.repository = repository
    }
    
    func getCategoryList() async throws -> [Category] {
        let response = try await repository.getCategoryList()
        if let data = response.data {
            return data
        }
        throw NetworkError.noData
    }
    
    func getProductList(_ categoryId: Int) async throws -> [ProductResponse] {
        let response = try await repository.getProductList(categoryId)
        if let data = response.data {
            return data
        }
        throw NetworkError.noData
    }
    
    func getProductDetail(_ id: Int) async throws -> ProductResponse {
        let response = try await repository.getProductDetail(id)
        if let data = response.data {
            return data
        }
        throw NetworkError.noData
    }
}
