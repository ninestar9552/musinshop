//
//  ThumbnailTabView.swift
//  musinshop
//
//  Created by cha on 2/4/25.
//

import SwiftUI

struct ThumbnailTabView: View {
    
    let urls: [String]?
    
    @State private var currentIndex = 1 // 앞뒤 가상이미지 추가로 index 1부터 시작
    @State private var indicatorCurrentIndex = 1
    
    var body: some View {
        if let urls = urls {
            ZStack {
                TabView(selection: $currentIndex) {
                    ThumbnailImageView(url: urls.last)
                        .tag(0)
                    
                    ForEach(urls.indices, id: \.self) { index in
                        ThumbnailImageView(url: urls[index])
                            .tag(index + 1) // 페이지를 인식하기 위해 태그 설정
                    }
                    
                    ThumbnailImageView(url: urls.first)
                        .tag(urls.count + 1)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never)) // 페이지 스타일과 인디케이터 설정
                .onChange(of: currentIndex) { currentIndex in
                    // 무한 스크롤 설정
                    handleInfiniteScroll()
                    // page indicator number 관리
                    if currentIndex == 0 {
                        indicatorCurrentIndex = urls.count
                    } else if currentIndex == urls.count + 1 {
                        indicatorCurrentIndex = 1
                    } else {
                        indicatorCurrentIndex = currentIndex
                    }
                }
                
                HStack {
                    Spacer()
                    VStack {
                        Spacer()
                        HStack {
                            Text("\(indicatorCurrentIndex) / \(urls.count)")
                                .font(.system(size: 13, weight: .regular))
                            Image(systemName: "chevron.right")
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(.black)
                                .frame(height: 9)
                        }
                        .padding(.horizontal, 6)
                        .frame(height: 24)
                        .backgroundStyle(
                            backgroundColor: Color(hex: "66FFFFFF"),
                            foregroundColor: .black,
                            cornerRadius: 4
                        )
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 15)
            }
            .frame(maxWidth: .infinity)
            .aspectRatio(1/1.2, contentMode: .fit)
        } else {
            ThumbnailImageView(url: nil)
                .frame(maxWidth: .infinity)
                .aspectRatio(1/1.2, contentMode: .fit)
        }
    }
    
    private func handleInfiniteScroll() {
        if let urls = urls {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                if currentIndex == 0 {
                    currentIndex = urls.count
                } else if currentIndex == urls.count + 1 {
                    currentIndex = 1
                }
            }
        }
    }
}


#Preview {
    ThumbnailTabView(urls: [
        "https://image.msscdn.net/thumbnails/images/goods_img/20240926/4469019/4469019_17273438310338_big.jpg?w=1200",
        "https://image.msscdn.net/thumbnails/images/prd_img/20240926/4469019/detail_4469019_17282940722304_big.jpg?w=1200",
        "https://image.msscdn.net/thumbnails/images/prd_img/20240926/4469019/detail_4469019_17282940765252_big.jpg?w=1200",
        "https://image.msscdn.net/thumbnails/images/prd_img/20240926/4469019/detail_4469019_17282940807604_big.jpg?w=1200",
        "https://image.msscdn.net/thumbnails/images/prd_img/20240926/4469019/detail_4469019_17282940854218_big.jpg?w=1200",
        "https://image.msscdn.net/thumbnails/images/prd_img/20240926/4469019/detail_4469019_17282940913738_big.jpg?w=1200",
        "https://image.msscdn.net/thumbnails/images/prd_img/20240926/4469019/detail_4469019_17282940986250_big.jpg?w=1200"
      ])
}
