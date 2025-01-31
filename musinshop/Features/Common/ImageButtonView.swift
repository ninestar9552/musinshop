//
//  IconButtonView.swift
//  BaeknyeonSamgyetang
//
//  Created by cha on 11/13/24.
//

import SwiftUI

struct ImageButtonView: View {
    var systemIcon: String?
    var icon: String?
    var text: String
    
    private var image: Image {
        if let systemIcon {
            return Image(systemName: systemIcon)
        } else if let icon {
            return Image(icon)
        } else {
            return Image(systemName: "person.crop.circle")
        }
    }
    
    var body: some View {
        HStack {
            image
                .resizable()
                .scaledToFit()
                .frame(width: 26, height: 26) // 아이콘 크기 설정
                .foregroundColor(.brown)
            
            Text(text)
                .font(.system(size: 22, weight: .medium))
                .foregroundColor(.black)
                .lineLimit(1)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 3, y: 3)
    }
}

#Preview {
    ImageButtonView(text: "방문포장")
}
