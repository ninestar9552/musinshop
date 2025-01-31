//
//  CategoryListViewModel.swift
//  musinshop
//
//  Created by cha on 1/24/25.
//

import Combine

class CategoryListViewModel: BaseViewModel {
    
    @Published private(set) var categoryList: [Category] = []
    
    private let getCategoryListUseCase: GetCategoryListUseCase
    
    init(
        getCategoryListUseCase: GetCategoryListUseCase = GetCategoryListUseCaseImpl()
    ) {
        self.getCategoryListUseCase = getCategoryListUseCase
    }
    
    
    @MainActor
    func getCategoryList() async {
        if let categoryList = await withLoading({
            try await self.getCategoryListUseCase.execute()
        }) {
            self.categoryList = categoryList
        } else {
            self.categoryList = []
        }
    }
}
