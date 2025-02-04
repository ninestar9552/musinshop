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
    
    var body: some View {
        if let urls = urls {
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
            .onChange(of: currentIndex) { _ in
                handleInfiniteScroll()
            }
        } else {
            ThumbnailImageView(url: nil)
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
