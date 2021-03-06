//
//  ReactBridge.swift
//  AirQualityDashboard
//
//  Created by Chris Ballinger on 5/18/18.
//

import Foundation
import React

protocol ReactRepresentable {
    var propsDictionary: [AnyHashable: Any] { get }
}

enum ReactModule: String {
    case airQuality = "RNAirQuality"
}

extension RCTRootView {
    func update(_ value: ReactRepresentable) {
        appProperties = value.propsDictionary
    }
}

class ReactBridge: NSObject {
    private var bridge: RCTBridge?

    static let shared = ReactBridge()

    override init() {
        super.init()
    }

    public func makeView(module: ReactModule,
                         initialProperties: [AnyHashable: Any] = [:],
                         useIntrinsicContentSize: Bool = false) -> RCTRootView? {
        guard let bridge = self.bridge else {
            fatalError("React Bridge not setup!")
        }
        let view = RCTRootView(bridge: bridge, moduleName: module.rawValue, initialProperties: initialProperties)
        if useIntrinsicContentSize {
            view?.sizeFlexibility = .widthAndHeight
        }
        else {
            view?.sizeFlexibility = .none
        }
        return view
    }
}

extension ReactBridge: RCTBridgeDelegate {
    func sourceURL(for bridge: RCTBridge) -> URL {
        #if DEBUG
        #if targetEnvironment(simulator)
        let jsCodeLocation = URL(string: "http://localhost:8081/index.bundle?platform=ios")!
        #else
        let jsCodeLocation = URL(string: "http://10.20.11.109.xip.io:8081/index.bundle?platform=ios")!
        #endif
        #else
        let jsCodeLocation = Bundle.main.url(forResource: "main", withExtension: "jsbundle")!
        #endif
        return jsCodeLocation
    }
}

extension ReactBridge: AppLifecycle {
    func onDidLaunch(application: UIApplication, launchOptions: [UIApplicationLaunchOptionsKey: Any]?) {
        self.bridge = RCTBridge(delegate: self, launchOptions: launchOptions)
    }
}
