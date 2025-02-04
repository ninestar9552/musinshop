//
//  ProductListViewModel.swift
//  musinshop
//
//  Created by cha on 2/3/25.
//

import Combine

class ProductListViewModel: BaseViewModel {
    
    @Published private(set) var productList: [ProductResponse] = []
    @Published private(set) var productDetail: ProductResponse?
    
    
    private let getProductListUseCase: GetProductListUseCase
    private let getProductDetailUseCase: GetProductDetailUseCase
    
    init(
        getProductListUseCase: GetProductListUseCase = GetProductListUseCaseImpl(),
        getProductDetailUseCase: GetProductDetailUseCase = GetProductDetailUseCaseImpl()
    ) {
        self.getProductListUseCase = getProductListUseCase
        self.getProductDetailUseCase = getProductDetailUseCase
    }
    
    
    @MainActor
    func getProductList(_ categoryId: Int) async {
        if let productList = await withLoading({
            try await self.getProductListUseCase.execute(categoryId)
        }) {
            self.productList = productList
        } else {
            self.productList = []
        }
    }
    
    @MainActor
    func getProductDetail(_ id: Int) async {
        if let productDetail = await withLoading({
            try await self.getProductDetailUseCase.execute(id)
        }) {
            self.productDetail = productDetail
        } else {
            self.productDetail = nil
        }
    }
}
