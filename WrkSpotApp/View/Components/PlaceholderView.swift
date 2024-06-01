//
//  PlaceholderView.swift
//  WrkSpotApp
//
//  Created by Karthik on 01/06/24.
//

import Foundation
import SwiftUI

/// A view that displays a placeholder with an icon, title, and description.
/// - Parameters:
///   - icon: A closure that returns the icon view to display.
///   - title: The title text to display.
///   - description: The description text to display.
struct PlaceholderView<Icon: View>: View {

    /// A closure that returns the icon view to display.
    var icon: () -> Icon

    /// The title text to display.
    var title: String

    /// The description text to display.
    var description: String

    /// The body of the `PlaceholderView`.
    var body: some View {
        VStack(spacing: STANDARD_SPACING) {
            icon()
            Text(title)
                .font(.title)
            Text(description)
                .font(.subheadline)
        }
    }
}

#Preview {
    PlaceholderView(
        icon: {
            return Image(systemName: "xmark.circle.fill")
                .font(.largeTitle)
                .foregroundColor(.red)
        },
        title: "Error",
        description: "Please try again later"
    )
}
