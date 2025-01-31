//
//  BaseViewModifier.swift
//  BaeknyeonSamgyetang
//
//  Created by cha on 11/15/24.
//

import SwiftUI


//struct BaseViewModifier: ViewModifier {
//    @ObservedObject var viewModel: BaseViewModel
//
//    func body(content: Content) -> some View {
//        ZStack {
//            content
//
//            if viewModel.isLoading {
//                ProgressView()
//                    .frame(alignment: .center)
//            }
//        }
//        .alert("오류", isPresented: $viewModel.showError) {
//            Button("확인", role: .cancel) { }
//        } message: {
//            Text(viewModel.errorMessage ?? "알 수 없는 오류가 발생했습니다.")
//        }
//    }
//}

struct BaseViewModifier: ViewModifier {
    var viewModels: [BaseViewModel]

    @State private var currentErrorViewModel: BaseViewModel?

    func body(content: Content) -> some View {
        ZStack {
            content

            // 하나라도 로딩 중이면 ProgressView 표시
            if viewModels.contains(where: { $0.isLoading }) {
                ProgressView()
                    .frame(alignment: .center)
            }
        }
        .alert(
            Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ?? "알림",
            isPresented: Binding(
                get: { currentErrorViewModel != nil },
                set: { _ in
                    currentErrorViewModel?.showError = false
                    currentErrorViewModel = nil
                }
            )
        ) {
            Button("확인", role: .cancel) { }
        } message: {
            Text(currentErrorViewModel?.errorMessage ?? "알 수 없는 오류가 발생했습니다.")
        }
        .onChange(of: viewModels.map { $0.showError }) { showErrorStates in
            if let index = showErrorStates.firstIndex(of: true) {
                currentErrorViewModel = viewModels[index]
            }
        }
    }
}

extension View {
    func baseViewStyle(viewModels: [BaseViewModel]) -> some View {
        modifier(BaseViewModifier(viewModels: viewModels))
    }
}

extension View {
    func baseViewStyle<VM: BaseViewModel>(viewModel: VM) -> some View {
        modifier(BaseViewModifier(viewModels: [viewModel]))
    }
}
