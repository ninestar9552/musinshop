//
//  ThumbnailImageView.swift
//  musinshop
//
//  Created by cha on 2/4/25.
//

import SwiftUI

struct ThumbnailImageView: View {
    
    let url: String?
    
    var body: some View {
        if let imageUrl = url, let url = URL(string: imageUrl) {
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
            .background(Color(hex: "F5F5F5"))
        } else {
            // 이미지가 없는 경우 기본 이미지
            Color(hex: "F5F5F5")
                .frame(maxWidth: .infinity)
                .aspectRatio(1/1.2, contentMode: .fit) // 가로:세로 비율 1:1.2
        }
    }
}

#Preview {
    ThumbnailImageView(url: nil)
}
