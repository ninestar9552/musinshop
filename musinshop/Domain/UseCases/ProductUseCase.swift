//
//  AuthUseCase.swift
//  musinshop
//
//  Created by cha on 11/18/24.
//

protocol GetCategoryListUseCase {
    func execute() async throws -> [Category]
}

final class GetCategoryListUseCaseImpl: GetCategoryListUseCase {
    private let service: ProductService
    
    init(service: ProductService = ProductServiceImpl()) {
        self.service = service
    }
    
    func execute() async throws -> [Category] {
        try await service.getCategoryList()
    }
}

protocol GetProductListUseCase {
    func execute(_ categoryId: Int) async throws -> [ProductResponse]
}

final class GetProductListUseCaseImpl: GetProductListUseCase {
    
    private let service: ProductService
    
    init(service: ProductService = ProductServiceImpl()) {
        self.service = service
    }
    
    func execute(_ categoryId: Int) async throws -> [ProductResponse] {
        try await service.getProductList(categoryId)
    }
}

protocol GetProductDetailUseCase {
    func execute(_ id: Int) async throws -> ProductResponse
}

final class GetProductDetailUseCaseImpl: GetProductDetailUseCase {
    
    private let service: ProductService
    
    init(service: ProductService = ProductServiceImpl()) {
        self.service = service
    }
    
    func execute(_ id: Int) async throws -> ProductResponse {
        try await service.getProductDetail(id)
    }
}
