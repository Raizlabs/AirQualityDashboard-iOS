//
//  AppDelegate.swift
//  AirQualityDashboard
//
//  Created by Eliot Williams on 11/1/16.
//  Copyright © 2017 Raizlabs. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var coordinator: AppCoordinator!
    var window: UIWindow?

    // Anything that doesn't rely on the existence of a viewcontroller should be in this preWindowConfigurations array
    let preWindowConfigurations: [AppLifecycle] = [
        LoggingConfiguration(),
        InstabugConfiguration(),
        Appearance.shared,
        CrashReportingConfiguration(),
        AnalyticsConfiguration(),
        DebugMenuConfiguration(),
        StatusBarConfiguration(),
        ReactBridge.shared,
        ]

    // Anything that relies on the existence of a window and an initial viewcontroller should be in this postWindowConfigurations array
    let rootViewControllerDependentConfigurations: [AppLifecycle] = [
        ]

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        // Don't load the main UI if we're unit testing.
        if let _: AnyClass = NSClassFromString("XCTest") {
            return true
        }

        for config in preWindowConfigurations where config.isEnabled {
            config.onDidLaunch(application: application, launchOptions: launchOptions)
        }

        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window

        self.coordinator = AppCoordinator(window: window)
        coordinator.start(animated: false, completion: {
            for config in self.rootViewControllerDependentConfigurations where config.isEnabled {
                config.onDidLaunch(application: application, launchOptions: launchOptions)
            }
        })

        return true
    }

}
