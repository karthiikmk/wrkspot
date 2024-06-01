//
//  WrkSpotAppTests.swift
//  WrkSpotAppTests
//
//  Created by Karthik on 01/06/24.
//

import XCTest
@testable import WrkSpotApp

final class CountryListViewModelTest: XCTestCase {

    var mockFetcher: MockCountryFetcher!
    var viewModel: CountryListViewModel!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockFetcher = MockCountryFetcher()
        viewModel = CountryListViewModel(countryFetcher: mockFetcher)
    }

    override func tearDownWithError() throws {
        mockFetcher = nil
        viewModel = nil
        try super.tearDownWithError()
    }
}

// MARK: - Fetch Country Tests
extension CountryListViewModelTest {

    func testFetchCountriesSuccess() async {
        // Given
        let mockFetcher = MockCountryFetcher(countries: [.bangladesh()])
        let viewModel = CountryListViewModel(countryFetcher: mockFetcher)
        // When
        await viewModel.fetchCountries()
        // Then
        XCTAssertEqual(viewModel.countries.count, 1)
        XCTAssertEqual(viewModel.viewState, .loaded)
    }

    func testFetchCountriesSuccessWithEmptyResulsts() async {
        // Given
        let mockFetcher = MockCountryFetcher(countries: [])
        let viewModel = CountryListViewModel(countryFetcher: mockFetcher)
        // When
        await viewModel.fetchCountries()
        // Then
        XCTAssertEqual(viewModel.countries.count, 0)
        XCTAssertEqual(viewModel.viewState, .empty)
    }

    func testFetchCountriesFailure() async {
        // Given
        let mockFetcher = MockCountryFetcher(error: WrkSpotError.networkError)
        let viewModel = CountryListViewModel(countryFetcher: mockFetcher)
        // When
        await viewModel.fetchCountries()
        // Then
        XCTAssertEqual(viewModel.countries.count, 0)
        XCTAssertEqual(viewModel.viewState, .failed)
    }
}

// MARK: - Search Tests
extension CountryListViewModelTest {

    func testUpdateSearchWithNilSearchText() {
        // Given
        let testCountries = [Country.bangladesh(), Country.belgium()]
        viewModel.countries = testCountries
        // When
        viewModel.updateSearch(nil)
        // Then
        XCTAssertEqual(viewModel.filteredCountries.count, testCountries.count)
    }

    func testUpdateSearchWithEmptySearchText() {
        // Given
        let testCountries = [Country.bangladesh(), Country.belgium()]
        viewModel.countries = testCountries
        // When
        viewModel.updateSearch("")
        // Then
        XCTAssertEqual(viewModel.filteredCountries.count, testCountries.count)
    }

    func testUpdateSearchWithNonEmptySearchText() {
        // Given
        let testCountries = [Country.bangladesh(), Country.belgium()]
        viewModel.countries = testCountries
        // When
        viewModel.updateSearch("ban")
        // Then
        XCTAssertEqual(viewModel.filteredCountries, [Country.bangladesh()])
    }

    func testUpdateSearchWithNoMatch() {
        // Given
        let testCountries = [Country.bangladesh(), Country.belgium()]
        viewModel.countries = testCountries
        // When
        viewModel.updateSearch("xyz")
        // Then
        XCTAssertTrue(viewModel.filteredCountries.isEmpty)
    }
}

// MARK: - Population Filter Tests
extension CountryListViewModelTest {

    func testClearPopulationFilter() {
        // Given
        let testCountries: [Country] = [.bangladesh(), .belgium(), .kiribati(), .bosnia(), .bulgaria()]
        viewModel.countries = testCountries

        // When filtering one million
        viewModel.updatePopulationfilter(.oneMillion)
        XCTAssertEqual(viewModel.filteredCountries, [.kiribati()])

        // When clearning filters
        viewModel.clearPopulationFilter()
        // Then
        XCTAssertEqual(viewModel.filteredCountries, testCountries)
    }

    func testUpdatePopulationfilterWithNilPopulationFilter() {
        // Given
        let testCountries = [Country.bangladesh(), Country.belgium()]
        viewModel.countries = testCountries
        // When
        viewModel.updatePopulationfilter(nil)
        // Then
        XCTAssertEqual(viewModel.filteredCountries, testCountries)
    }

    func testUpdatePopulationfilterWithLessThanOneMillionPopulationFilter() {
        // Given
        let testCountries: [Country] = [.bangladesh(), .belgium(), .kiribati()]
        viewModel.countries = testCountries
        // When
        viewModel.updatePopulationfilter(.oneMillion)
        // Then
        XCTAssertEqual(viewModel.filteredCountries, [.kiribati()])
    }

    func testUpdatePopulationfilterWithLessThanFiveMillionPopulationFilter() {
        // Given
        let testCountries: [Country] = [.bangladesh(), .belgium(), .kiribati(), .bosnia()]
        viewModel.countries = testCountries
        // When
        viewModel.updatePopulationfilter(.fiveMillion)
        // Then
        XCTAssertEqual(viewModel.filteredCountries, [.kiribati(), .bosnia()])
    }

    func testUpdatePopulationfilterWithLessThanTenMillionPopulationFilter() {
        // Given
        let testCountries: [Country] = [.bangladesh(), .belgium(), .kiribati(), .bosnia(), .bulgaria()]
        viewModel.countries = testCountries
        // When
        viewModel.updatePopulationfilter(.tenMillion)
        // Then
        XCTAssertEqual(viewModel.filteredCountries, [.kiribati(), .bosnia(), .bulgaria()])
    }
}

class MockCountryFetcher: CountryFetcher {
    var countriesToReturn: [Country]
    var errorToThrow: Error?

    init(countries: [Country] = [], error: Error? = nil) {
        self.countriesToReturn = countries
        self.errorToThrow = error
    }

    func fetchCountries() async throws -> [Country] {
        if let error = errorToThrow {
            throw error
        }
        return countriesToReturn
    }
}
