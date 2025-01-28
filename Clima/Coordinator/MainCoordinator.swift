//
//  Untitled.swift
//  Clima
//
//  Created by Omar Assidi on 26/01/2025.
//  Copyright © 2025 App Brewery. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var onComplete: (() -> Void)?
    func start() {
        let vc = ViewControllerFactory.getWeatherViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func getNavigationBarAppearance() -> UINavigationBarAppearance {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(named: "navBarColor")
        appearance.titleTextAttributes = [
            .font: UIFont.systemFont(ofSize: 20.0, weight: .semibold),
            .foregroundColor: UIColor.white
        ]
        appearance.largeTitleTextAttributes = [
            .font: UIFont.systemFont(ofSize: 30.0, weight: .bold),
            .foregroundColor: UIColor.white
        ]
        return appearance
    }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}
