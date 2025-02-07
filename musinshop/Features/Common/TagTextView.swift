//
//  TagTextView.swift
//  musinshop
//
//  Created by cha on 2/7/25.
//

import SwiftUI

struct TagTextView: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.system(size: 11, weight: .regular))
            .foregroundColor(Color(hex: "666666"))
            .padding(.vertical, 1)
            .padding(.horizontal, 4)
            .background(
                RoundedRectangle(cornerRadius: 2)
                    .fill(Color(hex: "1A8A8A8A")) // 버튼의 배경색
            )
    }
}

#Preview {
    TagTextView(text: "무신사단독")
}
