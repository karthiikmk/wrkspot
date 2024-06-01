//
//  EmptyPlaceholderView.swift
//  WrkSpotApp
//
//  Created by Karthik on 01/06/24.
//

import SwiftUI

/// A view that displays an empty placeholder with an icon and title.
struct EmptyPlaceholderView: View {

    /// The body of the `EmptyPlaceholderView`.
    var body: some View {
        PlaceholderView(
            icon: {
                Image(systemName: "tray")
                    .font(.title)
                    .foregroundColor(Color.wrkspotTitle)
            },
            title: "List is empty",
            description: ""
        )
    }
}

#Preview {
    EmptyPlaceholderView()
}
