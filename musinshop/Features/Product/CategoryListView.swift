//
//  EmptyView.swift
//  musinshop
//
//  Created by cha on 11/12/24.
//

import SwiftUI

struct CategoryListView: View {
    
    @StateObject var viewModel: CategoryListViewModel = CategoryListViewModel()
    
    @State private var selectedParentId: Int = 1
    
    let icons: [String] = [
        "https://image.msscdn.net/images/category_img/men/ITEM_001006_17164419735311_big.png",
        "https://image.msscdn.net/images/category_img/men/ITEM_001005_17164419731519_big.png",
        "https://image.msscdn.net/images/category_img/men/ITEM_003002_17164419814765_big.png",
        "https://image.msscdn.net/images/category_img/men/ITEM_003010_17164419834071_big.png"
    ]
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .leading) { // ZStack으로 레이어 분리
                HStack(alignment: .top, spacing: 0) {
                    // 좌측: 1depth 카테고리 목록
                    ScrollView {
                        LazyVStack(spacing: 0) { // LazyVStack을 사용하고 spacing을 0으로 설정
                            ForEach(viewModel.categoryList.filter { $0.parentId == nil }) { category in
                                CategoryCell(
                                    name: category.name,
                                    isSelected: selectedParentId == category.id
                                )
                                .onTapGesture {
                                    selectedParentId = category.id
                                }
                            }
                        }
                        .frame(width: 108)
                        .background(.red)
                    }
                    .background(Color.lightGray)
                    
                    // 우측: 2depth 카테고리 목록
                    ScrollView {
                        LazyVGrid(columns: [
                            GridItem(.flexible(), alignment: .top),
                            GridItem(.flexible(), alignment: .top),
                            GridItem(.flexible(), alignment: .top)
                        ]) {
                            ForEach(viewModel.categoryList.filter { $0.parentId == selectedParentId }) { category in
                                NavigationLink(destination: ProductListView(category: category)) {
                                    Category2Cell(
                                        name: category.name,
                                        iconUrl: icons[category.id%icons.count]
                                    )
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                }
            }
        }
        .task {
            await viewModel.getCategoryList()
        }
    }
}

struct CategoryCell: View {
    let name: String
    let isSelected: Bool
    
    var body: some View {
        Text(name)
            .font(isSelected ? .system(size: 13, weight: .semibold) : .system(size: 13))
            .foregroundColor(isSelected ? Color.black : Color(hex: "8A8A8A"))
            .contentShape(Rectangle()) // 탭 제스처 영역 확장
            .padding(.horizontal, 16)
            .padding(.vertical, 0)
            .frame(minWidth: 108, maxWidth: 108, minHeight: 36, maxHeight: 36, alignment: .leading)
            .background(isSelected ? Color.white : Color.lightGray)
    }
}

struct Category2Cell: View {
    let name: String
    let iconUrl: String
    
    var body: some View {
        VStack(alignment: .center) {
            AsyncImage(url: URL(string: iconUrl)) { image in
                image.resizable().scaledToFit()
            } placeholder: {
                Color.gray.opacity(0.3)
            }
            .frame(width: 60, height: 60)
            .cornerRadius(8)
            
            Text(name)
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(.black)
                .lineLimit(2)
                .multilineTextAlignment(.center)
                .frame(minWidth: 65, maxWidth: 80, alignment: .center)
                .padding(.horizontal, 2)
        }
        .frame(maxWidth: .infinity, alignment: .top)  // VStack을 상단 정렬
    }
}

#Preview {
    
    CategoryListView()
}

