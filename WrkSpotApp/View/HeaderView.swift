//
//  HeaderView.swift
//  WrkSpotApp
//
//  Created by Karthik on 01/06/24.
//

import SwiftUI

/// A view that displays a header with the current time.
/// - Parameters:
///   - currentTime: The current time string to display.
struct HeaderView: View {

    /// The current time string to display.
    let currentTime: String

    /// The body of the `HeaderView` view.
    var body: some View {
        HStack(alignment: .center, spacing: STANDARD_PADDING) {
            Text("WrkSpot")
                .font(.system(size: 22))
                .fontWeight(.regular)
            Spacer()
            Text(currentTime)
                .font(.subheadline)
            Spacer()
            Image(systemName: "person.crop.circle")
                .imageScale(.large)
        }
        .frame(height: 34)
        .padding(STANDARD_PADDING)
        .background(Color.wrkspotPinkLight)
        .overlay(
            RoundedRectangle(cornerRadius: 0)
                .stroke(Color.wrkspotPink, lineWidth: 2)
        )
    }
}

#Preview {
    HeaderView(currentTime: "d MMM h:mm a 'PST'")
}
