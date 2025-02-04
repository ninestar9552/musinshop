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
                    ProductCell(product: product)
                }
            }
        }
        .background(.white)
        .navigationTitle(category.name)
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
            if let imageUrl = product.thumbnailImageUrl, let url = URL(string: imageUrl) {
                ZStack {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .clipped() // 비율에 맞게 잘라냄
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity) // 너비를 최대로 설정
                }
                .frame(maxWidth: .infinity) // 너비를 최대로 설정
                .aspectRatio(1/1.2, contentMode: .fit) // 가로:세로 비율 1:1.2
            } else {
                // 이미지가 없는 경우 기본 이미지
                Color.gray.opacity(0.3)
                    .frame(maxWidth: .infinity)
                    .aspectRatio(1/1.2, contentMode: .fit) // 가로:세로 비율 1:1.2
                
            }
//        }
            
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
                
                // 가격
                HStack(alignment: .top, spacing: 0) {
                    if (product.discountRate != 0) {
                        Text("\(product.discountRate.toPercentageString())")
                            .font(.system(size: 13, weight: .bold))
                            .foregroundColor(Color(hex: "F31110"))
                            .padding(.trailing, 2)
                    }
                    
                    Text(
                        "\((product.discountRate == 0) ? product.price : Int(Double(product.price)*(1-product.discountRate)))원"
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
                name: "바지",
                parentId: nil,
                children: nil
            )
        )
    }
    .navigationBarTitleDisplayMode(.inline)
}
