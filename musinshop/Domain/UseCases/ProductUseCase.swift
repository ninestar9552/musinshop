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
