//
//  CountryRow.swift
//  WrkSpotApp
//
//  Created by Karthik on 31/05/24.
//

import SwiftUI

/// A view that displays a row of information about a country.
/// - Parameters:
///   - country: The country object containing information to display.
struct CountryRow: View {

    /// The country object containing information to display.
    var country: Country

    /// The body of the `CountryRow` view.
    var body: some View {
        HStack(spacing: STANDARD_SPACING) {
            FlagImage(url: country.media.flag)
            Text(country.name)
                .font(.system(size: 18))
                .foregroundColor(Color.wrkspotTitle)
            Spacer()
            VStack(alignment: .trailing, spacing: 4) {
                RowTrailingText(label: "Capital", value: country.capital)
                RowTrailingText(label: "Currency", value: country.currency)
                RowTrailingText(label: "Population", value: "\(country.population)")
            }
            .font(.caption)
        }
        .background(Color.wrkspotPinkLight)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(EdgeInsets(top: 5, leading: -10, bottom: 5, trailing: -10))
    }
}

#Preview {
    CountryRow(country: Country.bangladesh())
        .frame(maxHeight: 80)
        .padding()
}

