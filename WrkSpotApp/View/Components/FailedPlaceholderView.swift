//
//  FailedPlaceholderView.swift
//  WrkSpotApp
//
//  Created by Karthik on 01/06/24.
//

import SwiftUI

/// A view that displays a failed placeholder with an icon, title, and description.
struct FailedPlaceholderView: View {

    /// The body of the `FailedPlaceholderView`.
    var body: some View {
        PlaceholderView(
            icon: {
                Image(systemName: "xmark.circle.fill")
                    .font(.title)
                    .foregroundColor(.red)
            },
            title: "Error",
            description: "Please try again later"
        )
    }
}

#Preview {
    FailedPlaceholderView()
}
