//
//  LoggingConfiguration.swift
//  AirQualityDashboard
//
//  Created by Eliot Williams on 11/1/16.
//  Copyright © 2017 Raizlabs. All rights reserved.
//

import UIKit
import Swiftilities
import Services

struct LoggingConfiguration: AppLifecycle {

    func onDidLaunch(application: UIApplication, launchOptions: [UIApplicationLaunchOptionsKey: Any]?) {
        Log.logLevel = .info
        NetworkLog.logLevel = .info
    }

}
