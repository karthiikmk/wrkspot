//
//  CountryApiService.swift
//  WrkSpotApp
//
//  Created by Karthik on 01/06/24.
//

import Foundation
import SerializationKit
import NetworkKit

protocol CountryFetcher {

    func fetchCountries() async throws -> [Country]
}

class CountryApiService: CountryFetcher {

    var networkKit: NetworkKit<CountryApiURLRequest>

    init(networkKit: NetworkKit<CountryApiURLRequest> = .init(with: .shared)) {
        self.networkKit = networkKit
    }

    func fetchCountries() async throws -> [Country] {
        let decoder = CodableDecoder<[Country]>()
        let fetchedCountries = try await networkKit.requestCodableData(.fetchCountries, decoder: decoder)
        return fetchedCountries
    }
}
