//
//  ProductListViewModel.swift
//  musinshop
//
//  Created by cha on 2/3/25.
//

import Combine

class ProductListViewModel: BaseViewModel {
    
    @Published private(set) var productList: [ProductResponse] = [
        ProductResponse(
            id: 1,
            name: "개 멋있는 롱패딩",
            price: 239100,
            discountRate: 0.2,
            stockQuantity: 100,
            thumbnailImageUrl: "https://image.msscdn.net/thumbnails/images/goods_img/20241011/4506246/4506246_17289759096590_big.jpg?w=780",
            manufacturerName: "무신사 스탠다드",
            manufacturerLogo: "",
            itemNumber: "",
            gender: "MALE",
            shortDescription: "간단한 상품설명 랄랄랄라",
            imageUrls: [
                "https://image.msscdn.net/thumbnails/images/goods_img/20240926/4469019/4469019_17273438310338_big.jpg?w=1200",
                "https://image.msscdn.net/thumbnails/images/prd_img/20240926/4469019/detail_4469019_17282940722304_big.jpg?w=1200",
                "https://image.msscdn.net/thumbnails/images/prd_img/20240926/4469019/detail_4469019_17282940765252_big.jpg?w=1200",
                "https://image.msscdn.net/thumbnails/images/prd_img/20240926/4469019/detail_4469019_17282940807604_big.jpg?w=1200",
                "https://image.msscdn.net/thumbnails/images/prd_img/20240926/4469019/detail_4469019_17282940854218_big.jpg?w=1200",
                "https://image.msscdn.net/thumbnails/images/prd_img/20240926/4469019/detail_4469019_17282940913738_big.jpg?w=1200",
                "https://image.msscdn.net/thumbnails/images/prd_img/20240926/4469019/detail_4469019_17282940986250_big.jpg?w=1200"
              ],
            color: "BLACK",
            parentCategoryName: "아우터",
            categoryName: "패딩"
        ),
        ProductResponse(
            id: 2,
            name: "개 멋있는 롱패딩",
            price: 239100,
            discountRate: 0.2,
            stockQuantity: 100,
            thumbnailImageUrl: "https://image.msscdn.net/thumbnails/images/goods_img/20241011/4506246/4506246_17289759096590_big.jpg?w=780",
            manufacturerName: "무신사 스탠다드",
            manufacturerLogo: "",
            itemNumber: "",
            gender: "MALE",
            shortDescription: "간단한 상품설명 랄랄랄라",
            imageUrls: [
                "https://image.msscdn.net/thumbnails/images/goods_img/20240926/4469019/4469019_17273438310338_big.jpg?w=1200",
                "https://image.msscdn.net/thumbnails/images/prd_img/20240926/4469019/detail_4469019_17282940722304_big.jpg?w=1200",
                "https://image.msscdn.net/thumbnails/images/prd_img/20240926/4469019/detail_4469019_17282940765252_big.jpg?w=1200",
                "https://image.msscdn.net/thumbnails/images/prd_img/20240926/4469019/detail_4469019_17282940807604_big.jpg?w=1200",
                "https://image.msscdn.net/thumbnails/images/prd_img/20240926/4469019/detail_4469019_17282940854218_big.jpg?w=1200",
                "https://image.msscdn.net/thumbnails/images/prd_img/20240926/4469019/detail_4469019_17282940913738_big.jpg?w=1200",
                "https://image.msscdn.net/thumbnails/images/prd_img/20240926/4469019/detail_4469019_17282940986250_big.jpg?w=1200"
              ],
            color: "BLACK",
            parentCategoryName: "아우터",
            categoryName: "패딩"
        ),
        ProductResponse(
            id: 3,
            name: "개 멋있는 롱패딩",
            price: 239100,
            discountRate: 0.2,
            stockQuantity: 100,
            thumbnailImageUrl: "https://image.msscdn.net/thumbnails/images/goods_img/20241011/4506246/4506246_17289759096590_big.jpg?w=780",
            manufacturerName: "무신사 스탠다드",
            manufacturerLogo: "",
            itemNumber: "",
            gender: "MALE",
            shortDescription: "간단한 상품설명 랄랄랄라",
            imageUrls: [
                "https://image.msscdn.net/thumbnails/images/goods_img/20240926/4469019/4469019_17273438310338_big.jpg?w=1200",
                "https://image.msscdn.net/thumbnails/images/prd_img/20240926/4469019/detail_4469019_17282940722304_big.jpg?w=1200",
                "https://image.msscdn.net/thumbnails/images/prd_img/20240926/4469019/detail_4469019_17282940765252_big.jpg?w=1200",
                "https://image.msscdn.net/thumbnails/images/prd_img/20240926/4469019/detail_4469019_17282940807604_big.jpg?w=1200",
                "https://image.msscdn.net/thumbnails/images/prd_img/20240926/4469019/detail_4469019_17282940854218_big.jpg?w=1200",
                "https://image.msscdn.net/thumbnails/images/prd_img/20240926/4469019/detail_4469019_17282940913738_big.jpg?w=1200",
                "https://image.msscdn.net/thumbnails/images/prd_img/20240926/4469019/detail_4469019_17282940986250_big.jpg?w=1200"
              ],
            color: "BLACK",
            parentCategoryName: "아우터",
            categoryName: "패딩"
        ),
        ProductResponse(
            id: 4,
            name: "개 멋있는 롱패딩",
            price: 239100,
            discountRate: 0.2,
            stockQuantity: 100,
            thumbnailImageUrl: "https://image.msscdn.net/thumbnails/images/goods_img/20241011/4506246/4506246_17289759096590_big.jpg?w=780",
            manufacturerName: "무신사 스탠다드",
            manufacturerLogo: "",
            itemNumber: "",
            gender: "MALE",
            shortDescription: "간단한 상품설명 랄랄랄라",
            imageUrls: [
                "https://image.msscdn.net/thumbnails/images/goods_img/20240926/4469019/4469019_17273438310338_big.jpg?w=1200",
                "https://image.msscdn.net/thumbnails/images/prd_img/20240926/4469019/detail_4469019_17282940722304_big.jpg?w=1200",
                "https://image.msscdn.net/thumbnails/images/prd_img/20240926/4469019/detail_4469019_17282940765252_big.jpg?w=1200",
                "https://image.msscdn.net/thumbnails/images/prd_img/20240926/4469019/detail_4469019_17282940807604_big.jpg?w=1200",
                "https://image.msscdn.net/thumbnails/images/prd_img/20240926/4469019/detail_4469019_17282940854218_big.jpg?w=1200",
                "https://image.msscdn.net/thumbnails/images/prd_img/20240926/4469019/detail_4469019_17282940913738_big.jpg?w=1200",
                "https://image.msscdn.net/thumbnails/images/prd_img/20240926/4469019/detail_4469019_17282940986250_big.jpg?w=1200"
              ],
            color: "BLACK",
            parentCategoryName: "아우터",
            categoryName: "패딩"
        )
    ]
    
    
    private let getProductListUseCase: GetProductListUseCase
    
    init(
        getProductListUseCase: GetProductListUseCase = GetProductListUseCaseImpl()
    ) {
        self.getProductListUseCase = getProductListUseCase
    }
    
    
    @MainActor
    func getProductList(_ categoryId: Int) async {
        if let productList = await withLoading({
            try await self.getProductListUseCase.execute(categoryId)
        }) {
            self.productList = productList
        } else {
//            self.productList = []
        }
    }
}
