//
//  BottomSheetView.swift
//  musinshop
//
//  Created by cha on 2/13/25.
//

import SwiftUI

struct BottomSheetView<Content: View>: View {
    @Binding var isPresented: Bool
    let content: Content
    @State private var offset: CGFloat = 0

    init(isPresented: Binding<Bool>, @ViewBuilder content: () -> Content) {
        self._isPresented = isPresented
        self.content = content()
    }

    var body: some View {
        ZStack {
            // Dim 처리된 배경
            Group {
                if isPresented {
                    Color.black.opacity(0.4)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            // 배경 선택시 바텀시트 닫기
                            withAnimation(.smooth()) {
                                isPresented = false
                            }
                        }
                }
            }
            .animation(.smooth(duration: 0.1), value: isPresented)

            // 바텀시트 콘텐츠
            // 각 Group은 자신의 애니메이션 로직을 독립적으로 가지게 되어, isPresented 값이 변경될 때 자동으로 애니메이션이 적용됨
            // 사용하는 쪽에서 withAnimation을 명시적으로 호출할 필요가 없음
            Group {
                if isPresented {
                    VStack(alignment: .center, spacing: 0) {
                        // 실제 content 영역
                        VStack(alignment: .center, spacing: 0) {
                            // 바텀시트 핸들
                            Capsule()
                                .frame(width: 36, height: 4)
                                .foregroundColor(Color(hex: "E0E0E0"))
                                .padding(.vertical, 8)
                            
                            // 바텀시트 콘텐츠
                            content
                                .frame(maxWidth: .infinity)
                        }
                        
                        // SafeArea bottom 영역을 채우는 흰색 배경
                        Color.white
                            .frame(height: UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0)
                    }
                    .background(Color.white)
                    .clipShape(
                        .rect(
                            topLeadingRadius: 10,
                            topTrailingRadius: 10
                        )
                    )
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom) // 하단에 고정
                    .ignoresSafeArea(.all, edges: .bottom)
                    .offset(y: offset)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                // 슬라이드 제스처로 바텀시트 높이가 변경되도록 처리
                                if value.translation.height > 0 {
                                    offset = value.translation.height
                                }
                            }
                            .onEnded { value in
                                // 슬라이드 제스쳐 높이가 100 이상일 경우 시트 닫기
                                if value.translation.height > 100 {
                                    withAnimation(.spring()) {
                                        isPresented = false
                                    }
                                }
                                
                                // Gesture가 끝나면 높이를 원래대로
                                withAnimation(.spring(duration: 0.3)) {
                                    offset = 0
                                }
                            }
                    )
                    .transition(.move(edge: .bottom)) // 하단에서 올라오는 애니메이션
                }
            }
            .animation(.smooth(duration: 0.5), value: isPresented) // 애니메이션 적용
        }
    }
}

// 사용예시
#Preview {
    
    @Previewable @State var isBottomSheetPresented = true
    
    ZStack {
        VStack {
            Button(action: {
                isBottomSheetPresented.toggle()
            }) {
                Text("바텀시트 Show!")
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
            
            Spacer()
        }
        
        if isBottomSheetPresented {
            BottomSheetView(isPresented: $isBottomSheetPresented) {
                VStack(spacing: 20) {
                    Text("Title")
                        .foregroundStyle(.black)
                        .font(.title)
                        .padding()
                    
                    Text("MessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessage")
                        .font(.body)
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)
            }
        }
    }
}
