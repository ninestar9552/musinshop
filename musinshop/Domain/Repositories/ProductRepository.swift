//
//  AuthRepository.swift
//  musinshop
//
//  Created by cha on 11/15/24.
//

protocol ProductRepository {
    func getCategoryList() async throws -> CommonResponse<[Category]>
    func getProductList(_ categoryId: Int) async throws -> CommonResponse<[ProductResponse]>
    func getProductDetail(_ id: Int) async throws -> CommonResponse<ProductResponse>
}

final class ProductRepositoryImpl: ProductRepository {
    
    func getCategoryList() async throws -> CommonResponse<[Category]> {
        let request = APIEndPoint.Product.getCategoryList()
        return try await API.request(request)
    }
    
    func getProductList(_ categoryId: Int) async throws -> CommonResponse<[ProductResponse]> {
        let request = APIEndPoint.Product.getProductList(categoryId)
        return try await API.request(request)
    }
    
    func getProductDetail(_ id: Int) async throws -> CommonResponse<ProductResponse> {
        let request = APIEndPoint.Product.getProductDetail(id)
        return try await API.request(request)
    }
}
