//
//  ProductListView.swift
//  musinshop
//
//  Created by cha on 2/3/25.
//

import SwiftUI

struct ProductListView: View {
    
    var category: Category
    
    @StateObject var viewModel: ProductListViewModel = ProductListViewModel()
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [
                GridItem(.flexible(), spacing: 0, alignment: .top),
                GridItem(.flexible(), spacing: 0, alignment: .top),
                GridItem(.flexible(), spacing: 0, alignment: .top)
            ], spacing: 0) {
                ForEach(viewModel.productList) { product in
                    NavigationLink(destination: ProductDetailView(productId: product.id)) {
                        ProductCell(product: product)
                    }
                }
            }
        }
        .background(.white)
        .navigationTitle(category.name)
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.getProductList(category.id)
        }
    }
}


struct ProductCell: View {
    
    var product: ProductResponse
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // 상단 이미지
            ThumbnailImageView(url: product.thumbnailImageUrl)
            
            VStack(alignment: .leading, spacing: 4) {
                
                // 제조사명
                Text(product.manufacturerName)
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundColor(.black)
                
                // 상품명
                Text(product.name)
                    .font(.system(size: 13, weight: .regular))
                    .foregroundColor(.black)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading) // 2줄일 때 첫째줄이 중앙정렬 됨
                
                // 가격
                HStack(alignment: .top, spacing: 0) {
                    // 할인률
                    if (product.discountRate != 0) {
                        Text("\(product.discountRate.toPercentageString())")
                            .font(.system(size: 13, weight: .bold))
                            .foregroundColor(Color(hex: "F31110"))
                            .padding(.trailing, 2)
                    }
                    
                    Text(
                        "\(((product.discountRate == 0) ? product.price : Int(Double(product.price)*(1-product.discountRate))).stringWithComma)원"
                    )
                    .font(.system(size: 13, weight: .bold))
                    .foregroundColor(.black)
                }
            }
            .padding(.top, 12)
            .padding(.bottom, 24)
            .padding(.leading, 12)
            .padding(.trailing, 8)
        }
        .frame(maxWidth: .infinity)
        .background(.white)
    }
}

#Preview {
    NavigationView {
        ProductListView(
            category: Category(
                id: 2,
                name: "아우터",
                parentId: 1,
                children: nil
            )
        )
    }
}
