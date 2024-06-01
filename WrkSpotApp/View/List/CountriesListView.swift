//
//  CountriesListView.swift
//  WrkSpotApp
//
//  Created by Karthik on 31/05/24.
//

import SwiftUI
import SerializationKit
import NetworkKit

/// A view that displays a list of countries with various states including loading, empty, and error states.
/// It also provides search and filter functionalities.
/// - Parameters:
///   - viewModel: The view model responsible for managing and providing the list of countries.
struct CountriesListView: View {

    /// The view model responsible for managing and providing the list of countries.
    @ObservedObject var viewModel: CountryListViewModel

    /// State variable to control the display of the filter action sheet.
    @State private var showingFilterSheet = false

    /// The body of the `CountriesListView`.
    var body: some View {
        VStack {
            switch viewModel.viewState {
            case .loading:
                ListPlaceholderView { loader }
            case .empty:
                ListPlaceholderView { EmptyPlaceholderView() }
            case .failed:
                ListPlaceholderView { FailedPlaceholderView() }
            case .loaded:
                content
            }
        }
        .onAppear { Task { await viewModel.fetchCountries() } }
        .actionSheet(
            isPresented: $showingFilterSheet,
            content: populationActionSheet
        )
    }

    /// A view representing the loader for the loading state.
    private var loader: some View {
        VStack(spacing: STANDARD_SPACING) {
            ProgressView().scaleEffect(1.5, anchor: .center)
            Text("Fetching countries..")
                .font(.title)
                .foregroundStyle(Color.wrkspotTitle)
        }
    }

    /// A view representing the search bar and filter button.
    private var searchBar: some View {
        HStack {
            SearchView { viewModel.updateSearch($0) }
            Button(action: { showingFilterSheet = true }) {
                Image(systemName: "line.3.horizontal.decrease.circle")
                    .imageScale(.large)
            }
            .foregroundColor(Color.wrkspotTitle)
        }
    }

    /// A view representing the population filter information and clear button.
    private var populationFilterView: some View {
        Group {
            if let populationFilter = viewModel.selectedPopulationFilter {
                HStack(spacing: STANDARD_SPACING) {
                    Text("Filter population by: \(populationFilter)")
                        .fontWeight(.light)
                        .font(.subheadline)
                        .foregroundColor(Color.wrkspotTitle)
                    Spacer()
                    Button(action: { viewModel.clearPopulationFilter() }, label: {
                        Text("Clear")
                    })
                    .font(.system(size: 14))
                }
            }
        }
    }

    /// A function that returns an action sheet for population filtering options.
    /// - Returns: An `ActionSheet` with population filter options.
    private func populationActionSheet() -> ActionSheet {
        ActionSheet(title: Text("Filter by Population"), buttons: [
            .default(Text("< 1 M")) { viewModel.updatePopulationfilter(.oneMillion) },
            .default(Text("< 5 M")) { viewModel.updatePopulationfilter(.fiveMillion) },
            .default(Text("< 10 M")) { viewModel.updatePopulationfilter(.tenMillion) },
            .cancel()
        ])
    }

    /// A view builder that constructs the main content view.
    @ViewBuilder
    private var content: some View {
        searchBar
        populationFilterView
        Spacer()
        listContent
    }

    /// A view builder that constructs the list content view.
    @ViewBuilder
    private var listContent: some View {
        List(viewModel.filteredCountries) { country in
            CountryRow(country: country)
                .listRowSeparator(.hidden)
                .listRowBackground(
                    RoundedRectangle(cornerRadius: 0)
                        .foregroundColor(Color.wrkspotPinkLight)
                        .padding(EdgeInsets(top: 4, leading: 0, bottom: 4, trailing: 0))
                )
                .frame(height: 80)
        }
        .listStyle(.plain)
    }
}

/// A generic view that displays a placeholder with custom content.
/// - Parameters:
///   - content: A closure that returns the custom content to display.
struct ListPlaceholderView<Content: View>: View {

    /// A closure that returns the custom content to display.
    let content: () -> Content

    /// Initializes a new instance of `ListPlaceholderView`.
    /// - Parameter content: A closure that returns the custom content to display.
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    /// The body of the `ListPlaceholderView`.
    var body: some View {
        ZStack {
            Color.clear
            content()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    struct CountryFetcherMock: CountryFetcher {
        func fetchCountries() async -> [Country] {
            let data = Bundle.getData("countries", bundle: .main)
            let fetchedCountries = CodableDecoder<[Country]>().decode(data).value ?? []
            return fetchedCountries
        }
    }
    let counterFetcher = CountryFetcherMock()
    let viewModel = CountryListViewModel(countryFetcher: counterFetcher)
    return CountriesListView(viewModel: viewModel)
}
