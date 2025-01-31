//
//  LifeCycleController.swift
//  BaeknyeonSamgyetang
//
//  Created by cha on 1/13/25.
//

import Combine
import UIKit
import SwiftUI

enum LifeCycle {
    case none
    case viewDidLoad
    case viewWillAppear
    case viewDidAppear
    case viewWillDisappear
    case viewDidDisappear
}

protocol LifeCycleHandlerProtocol: AnyObject {
    var lifeCycle: PassthroughSubject<LifeCycle, Never> { get }
}

final class LifeCycleController: UIViewController {
    private weak var handler: LifeCycleHandlerProtocol?
    
    init(handler: LifeCycleHandlerProtocol) {
        self.handler = handler
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handler?.lifeCycle.send(.viewDidLoad)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handler?.lifeCycle.send(.viewWillAppear)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        handler?.lifeCycle.send(.viewDidAppear)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        handler?.lifeCycle.send(.viewWillDisappear)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        handler?.lifeCycle.send(.viewDidDisappear)
    }
    
    deinit {
        print(self, #function)
    }
    
    struct Represntable: UIViewControllerRepresentable {
        typealias UIViewControllerType = LifeCycleController
        private let handler: LifeCycleHandlerProtocol
        
        init(handler: LifeCycleHandlerProtocol) {
            self.handler = handler
        }
        
        func makeUIViewController(context: Context) -> LifeCycleController {
            LifeCycleController(handler: handler)
        }
        
        func updateUIViewController(_ uiViewController: LifeCycleController, context: Context) {
            
        }
    }
}


//extension ContentView {
//    final class LifeCycleViewModel: ObservableObject, LifeCycleHandlerProtocol {
//        
//        private var cancellables: Set<AnyCancellable> = []
//        let lifeCycle = PassthroughSubject<LifeCycle, Never>()
//        
//        init() {
//            bind()
//        }
//        
//        private func bind() {
//            lifeCycle
//                .sink { [weak self] lifeCycle in
//                    self?.lifeCycleHandling(lifeCycle)
//                }
//                .store(in: &cancellables)
//        }
//        
//        private func lifeCycleHandling(_ lifeCycle: LifeCycle) {
//            BsLog.d(lifeCycle)
//            
//            switch lifeCycle {
//            case .viewDidLoad:
//                return
//            case .viewWillAppear:
//                return
//            case .viewDidAppear:
//                return
//            case .viewWillDisappear:
//                return
//            case .viewDidDisappear:
//                return
//            }
//        }
//        
//        deinit {
//            print(self, #function)
//        }
//    }
//}


final class LifeCycleViewModel: ObservableObject, LifeCycleHandlerProtocol {
    
    private var cancellables: Set<AnyCancellable> = []
    let lifeCycle = PassthroughSubject<LifeCycle, Never>()
    
    @Published private(set) var cycle: LifeCycle = .none
    
    init() {
        bind()
    }
    
    private func bind() {
        lifeCycle
            .sink { [weak self] lifeCycle in
                self?.lifeCycleHandling(lifeCycle)
            }
            .store(in: &cancellables)
    }
    
    private func lifeCycleHandling(_ lifeCycle: LifeCycle) {
        BsLog.d(lifeCycle)
        
        switch lifeCycle {
        case .none:
            cycle = .none
            return
        case .viewDidLoad:
            cycle = .viewDidLoad
            return
        case .viewWillAppear:
            cycle = .viewWillAppear
            return
        case .viewDidAppear:
            cycle = .viewDidAppear
            return
        case .viewWillDisappear:
            cycle = .viewWillDisappear
            return
        case .viewDidDisappear:
            cycle = .viewDidDisappear
            return
        }
    }
    
    deinit {
        print(self, #function)
    }
}

struct LifeCycleModifier: ViewModifier {
    let handler: LifeCycleHandlerProtocol
    func body(content: Content) -> some View {
        content
            .overlay(
                LifeCycleController.Represntable(handler: handler)
                    .frame(width: .zero, height: .zero)
            )
    }
}


extension View {
    func lifeCycle(handler: LifeCycleHandlerProtocol) -> some View {
        modifier(LifeCycleModifier(handler: handler))
    }
}
