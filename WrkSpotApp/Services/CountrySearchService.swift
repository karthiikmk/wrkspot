//
//  CountrySearchService.swift
//  WrkSpotApp
//
//  Created by Karthik on 01/06/24.
//

import Foundation

/// A protocol defining methods for searching and filtering a list of countries.
protocol CountrySearcher {

    /// Filters the given list of countries based on the provided search text.
    /// - Parameters:
    ///   - countries: The list of countries to filter.
    ///   - searchText: The text to filter the countries by. If `nil` or empty, returns the original list.
    /// - Returns: A list of countries that match the search text.
    func filterCountries(countries: [Country], by searchText: String?) -> [Country]

    /// Applies a population filter to the given list of countries.
    /// - Parameters:
    ///   - countries: The list of countries to filter.
    ///   - threshold: The population threshold. Only countries with a population less than or equal to this value will be included.
    /// - Returns: A list of countries that meet the population threshold.
    func applyPopulationFilter(countries: [Country], threshold: Int) -> [Country]
}

// Default implementations for the CountrySearcher protocol methods.
extension CountrySearcher {

    /// Filters the given list of countries based on the provided search text.
    /// - Parameters:
    ///   - countries: The list of countries to filter.
    ///   - searchText: The text to filter the countries by. If `nil` or empty, returns the original list.
    /// - Returns: A list of countries that match the search text.
    func filterCountries(countries: [Country], by searchText: String?) -> [Country] {
        guard let searchText = searchText?.lowercased(), !searchText.isEmpty else {
            return countries
        }
        return countries.filter { $0.name.lowercased().contains(searchText) }
    }

    /// Applies a population filter to the given list of countries.
    /// - Parameters:
    ///   - countries: The list of countries to filter.
    ///   - threshold: The population threshold. Only countries with a population less than or equal to this value will be included.
    /// - Returns: A list of countries that meet the population threshold.
    func applyPopulationFilter(countries: [Country], threshold: Int) -> [Country] {
        return countries.filter { $0.population <= threshold }
    }
}

/// A service that implements the `CountrySearcher` protocol for searching and filtering countries.
struct CountrySearchService: CountrySearcher { }

