//
//  AppDelegate.swift
//  ChuckNorris
//
//  Created by Viachaslau Kastsechka on 3/4/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    private(set) var appCoordinator: AppCoordinator!

    let appAssembly = AppAssembly()

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let window = UIWindow(frame: UIScreen.main.bounds)
        window.backgroundColor = .white
        self.window = window

        startApp(with: launchOptions, in: window)

        window.makeKeyAndVisible()

        return true
    }

    // MARK: - Private

    private func startApp(with launchOptions: [UIApplication.LaunchOptionsKey: Any]?,
                          in window: UIWindow) {
        let appAssembly = AppAssembly()

        appCoordinator = AppCoordinator(appAssembly: appAssembly)
        appCoordinator.start()
    }
}

