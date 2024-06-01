//
//  DateProvider.swift
//  WrkSpotApp
//
//  Created by Karthik on 01/06/24.
//

import Foundation

/// A protocol for providing the current date. This abstraction allows for easier testing by injecting mock date providers.
protocol DateProvider {
    func currentDate() -> Date
}

extension Date: DateProvider {
    func currentDate() -> Date {
        return self
    }
}
