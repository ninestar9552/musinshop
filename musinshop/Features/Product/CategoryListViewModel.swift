//
//  CategoryListViewModel.swift
//  musinshop
//
//  Created by cha on 1/24/25.
//

import Combine

class CategoryListViewModel: BaseViewModel {
    
//    let sampleCategories: [Category] = [
//        Category(id: 1, name: "의류", parentId: nil, children: nil),
//        Category(id: 2, name: "상의", parentId: 1, children: nil),
//        Category(id: 3, name: "하의", parentId: 1, children: nil),
//        Category(id: 4, name: "샹샹상하의sdasd", parentId: 1, children: nil),
//        Category(id: 5, name: "로맨스", parentId: 1, children: nil),
//        Category(id: 6, name: "신발", parentId: nil, children: nil),
//        Category(id: 7, name: "운동화", parentId: 6, children: nil),
//        Category(id: 8, name: "구두", parentId: 6, children: nil),
//        Category(id: 9, name: "디지털/라이프", parentId: nil, children: nil),
//        Category(id: 10, name: "운동화", parentId: 9, children: nil),
//        Category(id: 11, name: "구두", parentId: 9, children: nil)
//    ]
    
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
