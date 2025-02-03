//
//  ContentView.swift
//  orderapp
//
//  Created by cha on 11/1/24.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var navigationVM = NavigationViewModel()
    
    var body: some View {
        CategoryListView()
            .environmentObject(navigationVM)
    }
}

#Preview {
    ContentView()
}
