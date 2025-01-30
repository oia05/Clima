//
//  UtilsModule.swift
//  Clima
//
//  Created by Omar Assidi on 30/01/2025.
//  Copyright © 2025 App Brewery. All rights reserved.
//

import Factory
import CoreLocation

extension Container {
    var locationManager: Factory<CLLocationManager> {
        self {
            CLLocationManager()
        }
    }
}
