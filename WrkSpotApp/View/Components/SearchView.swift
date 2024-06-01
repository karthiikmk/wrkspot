//
//  SearchView.swift
//  WrkSpotApp
//
//  Created by Karthik on 01/06/24.
//

import SwiftUI

/// A view that provides a search text field for filtering countries.
/// - Note: The search text field calls the provided closure whenever the search text is updated.
struct SearchView: View {

    /// The current search text entered by the user.
    @State private var searchText = ""

    /// A closure that is called whenever the search text is updated.
    private let didUpdateSearch: (_ searchText: String) -> Void

    /// Initializes a new instance of `SearchView`.
    /// - Parameter didUpdateSearch: A closure that is called whenever the search text is updated.
    init(didUpdateSearch: @escaping ((_ searchText: String) -> Void)) {
        self.didUpdateSearch = didUpdateSearch
    }

    /// The content and behavior of the view.
    var body: some View {
        TextField("Search by Country", text: $searchText)
            .padding(.vertical, 12)
            .padding(.horizontal, STANDARD_PADDING)
            .background(
                RoundedRectangle(cornerRadius: 2)
                    .strokeBorder(Color.wrkspotGray, lineWidth: 2)
                    .background(Color.white)
                    .frame(height: 44)
            )
            .onChange(of: searchText) { oldValue, newValue in
                didUpdateSearch(newValue)
            }
    }
}

#Preview {
    SearchView { searchText in
        debugPrint("SearchText: \(searchText)")
    }
}
