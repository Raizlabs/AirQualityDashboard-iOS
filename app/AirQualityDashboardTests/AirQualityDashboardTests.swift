//
//  AirQualityDashboardTests.swift
//  AirQualityDashboardTests
//
//  Created by Eliot Williams on 11/1/16.
//  Copyright © 2017 Raizlabs. All rights reserved.
//

import XCTest
@testable import AirQualityDashboard

class AirQualityDashboardTests: XCTestCase {
    func testUserDefaults() {
        XCTAssertFalse(UserDefaults.hasOnboarded)
    }
}
