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
            .padding(.vertical, 1)
            .padding(.horizontal, 4)
            .backgroundStyle(.tag)
    }
}

#Preview {
    TagTextView(text: "무신사단독")
}
