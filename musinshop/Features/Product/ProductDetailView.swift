//
//  ProductDetailView.swift
//  musinshop
//
//  Created by cha on 2/4/25.
//

import SwiftUI

struct ProductDetailView: View {
    
    var productId: Int
    
    @StateObject var viewModel: ProductListViewModel = ProductListViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                // 썸네일 이미지
                ThumbnailTabView(urls: viewModel.productDetail?.imageUrls)
                    .frame(maxWidth: .infinity)
                    .aspectRatio(1/1.2, contentMode: .fit)
                
                // 상품 요약정보
                VStack(alignment: .leading, spacing: 0) {
                    // 브랜드
                    HStack(alignment: .center, spacing: 8) {
                        ZStack {
                            AsyncImage(url: URL(string: "https://image.msscdn.net/mfile_s01/_brand/free_medium/musinsastandard.png?20200608153142")) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 26, height: 26)
                            } placeholder: {
                                Circle()
                                    .fill(Color.white)
                                    .frame(width: 32, height: 32)
                            }
                            .frame(width: 32, height: 32) // 32*32 사이즈 기준 원형 클립
                            .clipShape(Circle())
                            
                            Circle()
                                .fill(.clear)
                                .stroke(Color.lightGray, lineWidth: 1)
                                .frame(width: 32, height: 32)
                        }
                        
                        Text(viewModel.productDetail?.manufacturerName ?? "")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.black)
                        
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    
                    Rectangle()
                        .fill(Color.lightGray)
                        .frame(height: 1)
                    
                    // 카테고리
                    Text("\(viewModel.productDetail?.parentCategoryName ?? "")\(viewModel.productDetail?.categoryName != nil ? " > " : "")\(viewModel.productDetail?.categoryName ?? "")")
                        .font(.system(size: 13, weight: .regular))
                        .foregroundColor(Color(hex: "666666"))
                        .padding(.top, 16)
                    
                    // 상품명
                    Text(viewModel.productDetail?.name ?? "")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.black)
                        .padding(.top, 4)
                        .multilineTextAlignment(.leading)
                    
                    // 가격
                    VStack(alignment: .leading, spacing: 2) {
                        // 할인 전 가격
                        if viewModel.productDetail?.discountRate != 0 {
                            Text("\((viewModel.productDetail?.price ?? 0).stringWithComma)원")
                                .font(.system(size: 13, weight: .regular))
                                .foregroundColor(Color(hex: "8A8A8A"))
                                .strikethrough()
                        }
                        
                        // 할인 후 가격
                        DiscountLabelView(
                            price: viewModel.productDetail?.price ?? 0,
                            discountRate: viewModel.productDetail?.discountRate,
                            textSize: 18
                        )
                    }
                    .padding(.top, 16)
                    
                    
                }
                .padding(.horizontal, 16)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.white)
            
            VStack(alignment: .center, spacing: 0) {
                Rectangle()
                    .fill(Color.lightGray) // 회색, 0.5 투명도
                    .frame(height: 1) // 높이 0.5px
                
                HStack(alignment: .center) {
                    Button(action: {
                        
                    }) {
                        Text("구매하기")
                    }
                    .buttonStyle(PriamaryButtonStyle())
                    .frame(maxWidth: .infinity, maxHeight: 44)
                    .padding(.vertical, 12)
                    .padding(.horizontal, 16)
                }
                .frame(maxWidth: .infinity)
                .background(.white)
            }
        }
        .task {
            await viewModel.getProductDetail(productId)
        }
    }
}

#Preview {
    ProductDetailView(productId: 2)
}
