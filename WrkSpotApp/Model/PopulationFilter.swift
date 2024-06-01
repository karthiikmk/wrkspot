//
//  PopulationFilter.swift
//  WrkSpotApp
//
//  Created by Karthik on 31/05/24.
//

import Foundation

enum PopulationFilter: Int, CustomStringConvertible {

    case oneMillion = 1_000_000
    case fiveMillion = 5_000_000
    case tenMillion = 10_000_000

    var description: String {
        switch self {
        case .oneMillion:
            return "< 1 M"
        case .fiveMillion:
            return "< 5 M"
        case .tenMillion:
            return "< 10 M"
        }
    }
}
