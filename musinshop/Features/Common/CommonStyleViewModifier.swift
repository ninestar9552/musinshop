//
//  CommonStyleViewModifier.swift
//  musinshop
//
//  Created by cha on 2/7/25.
//

import SwiftUI


// BackgroundViewModifier 정의
struct BackgroundViewModifier: ViewModifier {
    
    let backgroundColor: Color
    let foregroundColor: Color
    let borderColor: Color
    let borderWidth: CGFloat
    let cornerRadius: CGFloat
    
    func body(content: Content) -> some View {
        content
            .background(backgroundColor)
            .overlay {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(borderColor, lineWidth: borderWidth)
            }
            .cornerRadius(cornerRadius)
            .foregroundStyle(foregroundColor)
    }
}

// BackgroundViewModifier를 사용하는 확장함수
extension View {
    func backgroundStyle(
        backgroundColor: Color = .clear,
        foregroundColor: Color = .black,
        borderColor: Color = .clear,
        borderWidth: CGFloat = 1,
        cornerRadius: CGFloat = 0
    ) -> some View {
        modifier(
            BackgroundViewModifier(
                backgroundColor: backgroundColor,
                foregroundColor: foregroundColor,
                borderColor: borderColor,
                borderWidth: borderWidth,
                cornerRadius: cornerRadius
            )
        )
    }
}


// BackgroundViewModifier를 enum으로 관리하여 스타일 정의
extension View {
    func backgroundStyle(_ style: BackgroundStyle) -> some View {
        modifier(style.modifier)
    }
}

enum BackgroundStyle {
    case primaryButton
    case secondaryEnabledButton
    case secondaryDisabledButton
    case tag
    case custom(backgroundColor: Color, foregroundColor: Color, borderColor: Color, borderWidth: CGFloat, cornerRadius: CGFloat)
    
    var modifier: BackgroundViewModifier {
        switch self {
        case .primaryButton:
            return BackgroundViewModifier(
                backgroundColor: .black,
                foregroundColor: .white,
                borderColor: .clear,
                borderWidth: 0,
                cornerRadius: 4
            )
        case .secondaryEnabledButton:
            return BackgroundViewModifier(
                backgroundColor: .white,
                foregroundColor: .black,
                borderColor: Color(hex: "E0E0E0"),
                borderWidth: 1,
                cornerRadius: 4
            )
        case .secondaryDisabledButton:
            return BackgroundViewModifier(
                backgroundColor: .lightGray,
                foregroundColor: Color(hex: "CCCCCC"),
                borderColor: Color(hex: "EBEBEB"),
                borderWidth: 1,
                cornerRadius: 4
            )
        case .tag:
            return BackgroundViewModifier(
                backgroundColor: Color(hex: "1A8A8A8A"),
                foregroundColor: Color(hex: "666666"),
                borderColor: .clear,
                borderWidth: 0,
                cornerRadius: 2
            )
        case .custom(let backgroundColor, let foregroundColor, let borderColor, let borderWidth, let cornerRadius):
            return BackgroundViewModifier(
                backgroundColor: backgroundColor,
                foregroundColor: foregroundColor,
                borderColor: borderColor,
                borderWidth: borderWidth,
                cornerRadius: cornerRadius
            )
        }
    }
}

#Preview {
    VStack {
        Text("Hello, World!")
    }
    .backgroundStyle(.secondaryDisabledButton)
}
