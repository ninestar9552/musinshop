//
//  ProductListView.swift
//  musinshop
//
//  Created by cha on 2/3/25.
//

import SwiftUI

struct ProductListView: View {
    
    var category: Category
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
        }
    }
}

#Preview {
    ProductListView(
        category: Category(
            id: 3,
            name: "바지",
            parentId: 1,
            children: nil
        )
    )
}
