//
//  UIImage+Extensions.swift
//  Clima
//
//  Created by Omar Assidi on 26/01/2025.
//  Copyright © 2025 App Brewery. All rights reserved.
//

import UIKit

extension UIImage {
    struct Common {
        static var background: UIImage {
            return .init(named: "background")!
        }
        static var locationImage: UIImage {
            return .init(systemName: "location.circle.fill")!
        }
        static var searchImage: UIImage {
            return .init(systemName: "magnifyingglass")!
        }
        static var conditionImage: UIImage {
            return .init(systemName: "questionmark.circle.dashed")!
        }
    }
}
