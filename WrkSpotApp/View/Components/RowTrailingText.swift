//
//  RowTrailingText.swift
//  WrkSpotApp
//
//  Created by Karthik on 01/06/24.
//

import SwiftUI

/// A view that displays a label and value in a trailing position.
/// - Parameters:
///   - label: The label text.
///   - value: The value text.
struct RowTrailingText: View {

    /// The label text.
    let label: String

    /// The value text.
    let value: String

    /// The body of the `RowTrailingText` view.
    var body: some View {
        Text("\(label): \(value)")
            .font(.system(size: 14))
            .fontWeight(.medium)
            .foregroundColor(Color.wrkspotPurple)
    }
}

#Preview {
    RowTrailingText(label: "Test", value: "BSD")
}
