//
//  Coordinator.swift
//  Clima
//
//  Created by Omar Assidi on 26/01/2025.
//  Copyright © 2025 App Brewery. All rights reserved.
//

import UIKit

public protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    var onComplete: (() -> Void)? { get set }
    func start()
}

extension Coordinator {
    func add(coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }
    func remove(coordinator: Coordinator) {
        childCoordinators.removeAll { $0 === coordinator }
    }
}
