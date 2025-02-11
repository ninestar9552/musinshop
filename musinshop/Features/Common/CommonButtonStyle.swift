//
//  CommonButtonStyle.swift
//  musinshop
//
//  Created by cha on 11/25/24.
//

import SwiftUI

struct CustomButtonStyle: ButtonStyle {
    var fontSize: CGFloat = 14
    var fontWeight: Font.Weight = .semibold
    var textColor: Color = .white
    var backgroundColor: Color = .black
    var borderColor: Color = .clear
    var borderWidth: CGFloat = 1
    var cornerRadius: CGFloat = 4
    
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .font(.system(size: fontSize, weight: fontWeight))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .backgroundStyle(
                backgroundColor: backgroundColor,
                foregroundColor: textColor,
                borderColor: borderColor,
                borderWidth: borderWidth,
                cornerRadius: cornerRadius
            )
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0) // 눌렀을 때 크기 효과
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct PrimaryButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .font(.system(size: 14, weight: .medium))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .backgroundStyle(.primaryButton)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0) // 눌렀을 때 크기 효과
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct SecondaryButtonStyle: ButtonStyle {
    
    var isDisabled: Bool = false
    
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .font(.system(size: 13, weight: .semibold))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .backgroundStyle(isDisabled ? .secondaryDisabledButton : .secondaryEnabledButton)
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
            Text("Primary Style")
        }
        .frame(width: 200, height: 44)
        .buttonStyle(PrimaryButtonStyle())
        
        Button(action: {
            
        }) {
            Text("Secondary Style")
        }
        .frame(width: 200, height: 44)
        .buttonStyle(SecondaryButtonStyle())
        
        Button(action: {
            
        }) {
            Text("Secondary Disabled Style")
        }
        .frame(width: 200, height: 44)
        .buttonStyle(SecondaryButtonStyle(isDisabled: true))
        .disabled(true)
        
        Button(action: {
            
        }) {
            Text("PressedEffect Style")
        }
        .frame(width: 200, height: 44)
        .buttonStyle(PressedEffectButtonStyle())
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
}
