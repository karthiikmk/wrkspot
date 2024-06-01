//
//  CountryViewModel.swift
//  WrkSpotApp
//
//  Created by Karthik on 31/05/24.
//

import Foundation
import Combine
import NetworkKit
import SerializationKit

/// A view model for managing and filtering a list of countries.
class CountryListViewModel: ObservableObject {

    /// The filtered list of countries based on search and population filter criteria.
    @Published private(set) var filteredCountries = [Country]()
    /// The complete list of fetched countries.
    @Published var countries = [Country]()
    /// The currently selected population filter.
    @Published var selectedPopulationFilter: PopulationFilter? = nil
    /// The current view state, representing the loading, success, or failure states of data fetching.
    @Published var viewState: ViewState = .loading

    /// The service responsible for fetching country data.
    let countryFetcher: CountryFetcher
    /// The service responsible for searching and filtering country data.
    let countrySearcher: CountrySearcher

    /// Initializes a new instance of `CountryListViewModel`.
    /// - Parameters:
    ///   - countryFetcher: The service used to fetch country data. Defaults to `CountryApiService`.
    ///   - countrySearcher: The service used to search and filter country data. Defaults to `CountrySearchService`.
    init(
        countryFetcher: CountryFetcher = CountryApiService(),
        countrySearcher: CountrySearcher = CountrySearchService()
    ) {
        self.countryFetcher = countryFetcher
        self.countrySearcher = countrySearcher
    }
}

// MARK: - API Methods
extension CountryListViewModel {

    /// Fetches the list of countries and updates the state of the view model.
    @MainActor
    func fetchCountries() async {
        viewState = .loading

        do {
            let fetchedCountries = try await countryFetcher.fetchCountries()
            self.countries = fetchedCountries
            self.filteredCountries = fetchedCountries
            self.viewState = filteredCountries.isEmpty ? .empty : .loaded
        } catch {
            viewState = .failed
            debugPrint(error)
        }
    }
}

// MARK: - Search Methods
extension CountryListViewModel {

    /// Updates the filtered list of countries based on the provided search text and the selected population filter.
    /// - Parameter searchText: The text to search for in the country names. Defaults to `nil`.
    func updateSearch(_ searchText: String? = nil) {
        var filtered = countrySearcher.filterCountries(countries: countries, by: searchText)
        if let populationFilter = selectedPopulationFilter {
            filtered = countrySearcher.applyPopulationFilter(countries: filtered, threshold: populationFilter.rawValue)
        }
        self.filteredCountries = filtered
    }
}

// MARK: - Population Filter Methods
extension CountryListViewModel {

    /// Clears the population filter and updates the filtered list of countries.
    func clearPopulationFilter() {
        updatePopulationfilter()
        updateSearch()
    }

    /// Updates the selected population filter and refilters the list of countries.
    /// - Parameter filter: The population filter to apply. Defaults to `nil`.
    func updatePopulationfilter(_ filter: PopulationFilter? = nil) {
        selectedPopulationFilter = filter
        updateSearch()
    }
}

// MARK: - View State Enum
extension CountryListViewModel {

    /// Represents the current state of the view in the `CountryListViewModel`.
    enum ViewState {
        /// The view is currently loading data.
        case loading
        /// The view has loaded data, but the list is empty.
        case empty
        /// The view failed to load data.
        case failed
        /// The view has successfully loaded data.
        case loaded
    }
}
