//
//  BaseViewModel.swift
//  BaeknyeonSamgyetang
//
//  Created by cha on 11/15/24.
//

import SwiftUI


// MARK: - Loading State Protocol
protocol LoadingState: AnyObject {
    var isLoading: Bool { get set }
}

// MARK: - Base ViewModel
class BaseViewModel: ObservableObject, LoadingState {
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var showError: Bool = false
    
    // 로딩 상태와 에러 처리를 메인 스레드에서 처리
    @MainActor
    private func updateLoadingState(_ isLoading: Bool) {
        self.isLoading = isLoading
    }
    
    @MainActor
    public func handleError(_ error: Error) {
        if let bsError = error as? BsError {
            errorMessage = bsError.localizedDescription
        } else {
            errorMessage = "\(error)"
        }
        showError = true
    }
    
    // 백그라운드에서 작업을 실행하고 결과만 메인 스레드에서 처리
    func withLoading<T>(_ operation: @escaping () async throws -> T) async -> T? {
        await updateLoadingState(true)
        
        do {
            let result = try await operation()
            await updateLoadingState(false)
            return result
        } catch {
            await updateLoadingState(false)
            await handleError(error)
            return nil
        }
    }
}
