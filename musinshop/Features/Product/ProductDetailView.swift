//
//  ProductDetailView.swift
//  musinshop
//
//  Created by cha on 2/4/25.
//

import SwiftUI

struct ProductDetailView: View {
    
    var productId: Int
    
    @StateObject var viewModel: ProductDetailViewModel = ProductDetailViewModel()
    
    @State private var isBuyingPresented = false
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                ScrollView {
                    // 썸네일 이미지
                    ThumbnailTabView(urls: viewModel.productDetail?.imageUrls)
                    
                    // 상품 요약정보
                    VStack(alignment: .leading, spacing: 0) {
                        // 브랜드
                        ProductDetailBrandView(product: viewModel.productDetail)
                        
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
                        
                        // 상품 태그
                        HStack(alignment: .center, spacing: 2) {
                            TagTextView(text: "PLUS배송")
                            TagTextView(text: "무신사단독")
                        }
                        .padding(.top, 8)
                        
                        // 가격
                        ProductDetailPriceView(product: viewModel.productDetail)
                        
                    }
                    .padding(.horizontal, 16)
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.white)
                
                // 구매하기 버튼
                ProductDetailBuyButtonView(isBuyingPresented: $isBuyingPresented)
            }
            
            if isBuyingPresented {
                BottomSheetView(isPresented: $isBuyingPresented) {
                    VStack(alignment: .center, spacing: 0) {
                        Text("구매하기 구매하기")
                            .foregroundStyle(.blue)
                        Text("구매하기 구매하기")
                            .foregroundStyle(.blue)
                        Text("구매하기 구매하기")
                            .foregroundStyle(.blue)
                        Text("구매하기 구매하기")
                            .foregroundStyle(.blue)
                        Text("구매하기 구매하기")
                            .foregroundStyle(.blue)
                        Text("구매하기 구매하기")
                            .foregroundStyle(.blue)
                        Text("구매하기 구매하기")
                            .foregroundStyle(.blue)
                        Text("구매하기 구매하기")
                            .foregroundStyle(.blue)
                        Text("구매하기 구매하기")
                            .foregroundStyle(.blue)
                        Text("구매하기 구매하기")
                            .foregroundStyle(.blue)
                        Text("구매하기 구매하기")
                            .foregroundStyle(.blue)
                        
                        // 구분선
                        Rectangle()
                            .fill(Color.lightGray)
                            .frame(height: 1)
                        
                        HStack(alignment: .center, spacing: 8) {
                            Button {
                                print("장바구니 클릭")
                            } label: {
                                Text("장바구니")
                            }
                            .buttonStyle(SecondaryButtonStyle())
                            .frame(width: .infinity, height: 44)
                            
                            Button {
                                print("구매하기 클릭")
                            } label: {
                                Text("구매하기")
                            }
                            .buttonStyle(PrimaryButtonStyle())
                            .frame(width: .infinity, height: 44)
                        }
                        .padding(.top, 12)
                        .padding(.bottom, 20)
                    }
                    .padding(.horizontal, 16)
                }
            }
        }
        .task {
            await viewModel.getProductDetail(productId)
        }
    }
}

struct ProductDetailBrandView: View {
    
    let product: ProductResponse?
    
    var body: some View {
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
            Text(product?.manufacturerName ?? "")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.black)
            
            TagTextView(text: "단독")
            Spacer()
            
            Button {
                print("좋아요 클릭!")
            } label: {
                HStack(alignment: .center, spacing: 4) {
                    Image(systemName: "heart")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(.black)
                        .frame(width: 13, height: 13)
                        .clipped()
                    
                    Text("2.1만")
                        .font(.system(size: 13, weight: .medium))
                        .foregroundColor(.black)
                    
                }
                .padding(.horizontal, 5)
                .frame(height: 24)
                .background {
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Color(hex: "E0E0E0"))
                }
            }
            .buttonStyle(PressedEffectButtonStyle())
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
    }
}

struct ProductDetailPriceView: View {
    
    let product: ProductResponse?
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 4) {
            // 가격
            VStack(alignment: .leading, spacing: 2) {
                // 할인 전 가격
                if product?.discountRate != 0 {
                    Text("\((product?.price ?? 0).stringWithComma)원")
                        .font(.system(size: 13, weight: .regular))
                        .foregroundColor(Color(hex: "8A8A8A"))
                        .strikethrough()
                }
                
                // 할인 후 가격
                DiscountLabelView(
                    price: product?.price ?? 0,
                    discountRate: product?.discountRate,
                    textSize: 18
                )
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.top, 16)
    }
}

struct ProductDetailBuyButtonView: View {
    
    @Binding var isBuyingPresented: Bool
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Rectangle()
                .fill(Color.lightGray)
                .frame(height: 1)
            
            HStack(alignment: .center, spacing: 12) {
                VStack(alignment: .center, spacing: 0) {
                    Button(action: {
                        print("구매하기 옆 좋아요 클릭!")
                    }) {
                        Image(systemName: "heart")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.black)
                            .frame(width: 20, height: 20)
                            .clipped()
                    }
                    .padding(4)
                    .buttonStyle(PressedEffectButtonStyle())
                    Text(1324.stringWithComma)
                        .font(.system(size: 13, weight: .medium))
                        .foregroundStyle(.black)
                }
                .frame(minWidth: 48)
                Button(action: {
                    print("구매하기 클릭!")
                    isBuyingPresented.toggle()
                }) {
                    Text("구매하기")
                }
                .buttonStyle(PrimaryButtonStyle())
                .frame(maxWidth: .infinity, maxHeight: 44)
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .frame(maxWidth: .infinity)
            .background(.white)
        }
    }
}


#Preview {
    ProductDetailView(productId: 2)
}
