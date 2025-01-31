//
//  AppDelegate.swift
//  BaeknyeonSamgyetang
//
//  Created by cha on 1/21/25.
//

import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupNavigationBarAppearance()
        return true
    }

    private func setupNavigationBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundEffect = UIBlurEffect(style: .light)
        appearance.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        
        // 뒤로가기 버튼 텍스트 숨김
        appearance.backButtonAppearance = UIBarButtonItemAppearance(style: .plain)
        appearance.backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.clear]
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}
