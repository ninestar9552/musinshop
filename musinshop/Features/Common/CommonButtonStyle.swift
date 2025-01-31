//
//  CommonButtonStyle.swift
//  musinshop
//
//  Created by cha on 11/25/24.
//

import SwiftUI

struct RoundedBorderButtonStyle: ButtonStyle {
    var textColor: Color = .white
    var borderColor: Color = .white
    var fontSize: CGFloat = 16
    var cornerRadius: CGFloat = 25
    var borderWidth: CGFloat = 1
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: fontSize, weight: .semibold))
            .foregroundColor(textColor)
            .padding(.vertical, 8) // 위아래 여백
            .padding(.horizontal, 15) // 좌우 여백
            .background(Color.clear) // 배경 투명
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(borderColor, lineWidth: borderWidth) // 테두리 스타일
            )
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0) // 눌렀을 때 크기 효과
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

#Preview {
    
    VStack {
        Button(action: {
            
        }) {
            Text("Hello, World!")
        }
        .buttonStyle(RoundedBorderButtonStyle())
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.gray)
}
