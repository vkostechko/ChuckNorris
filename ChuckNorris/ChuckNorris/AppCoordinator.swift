//
//  AppCoordinator.swift
//  ChuckNorris
//
//  Created by Viachaslau Kastsechka on 3/4/23.
//

import UIKit

final class AppCoordinator {
    let appAssembly: AppAssembly

    init(appAssembly: AppAssembly) {
        self.appAssembly = appAssembly
    }

    func start() {
        let view = JokesBuilder(dataRepository: appAssembly.dataRepository)
            .configure()
        let navController = UINavigationController(rootViewController: view)
        (UIApplication.shared.delegate as? AppDelegate)?.window?.rootViewController = navController
    }
}
