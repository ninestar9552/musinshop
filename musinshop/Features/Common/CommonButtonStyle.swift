//
//  CommonButtonStyle.swift
//  musinshop
//
//  Created by cha on 11/25/24.
//

import SwiftUI

struct PriamaryButtonStyle: ButtonStyle {
    var backgroundColor: Color = .black
    var textColor: Color = .white
    var borderColor: Color = .clear
    var fontSize: CGFloat = 14
    var cornerRadius: CGFloat = 4
    var borderWidth: CGFloat = 1
    
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .font(.system(size: fontSize, weight: .bold))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(backgroundColor) // 버튼의 배경색
                    .overlay(
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .stroke(borderColor, lineWidth: borderWidth) // 테두리 스타일
                    )
            )
            .foregroundColor(textColor)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0) // 눌렀을 때 크기 효과
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct PressedEffectButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
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
        .frame(width: 200, height: 44)
        .buttonStyle(PriamaryButtonStyle())
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.gray)
}
