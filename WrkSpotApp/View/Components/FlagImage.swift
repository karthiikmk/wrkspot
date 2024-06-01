//
//  FlagImage.swift
//  WrkSpotApp
//
//  Created by Karthik on 01/06/24.
//

import SwiftUI

/// A view that displays a flag image from a URL.
/// - Parameters:
///   - url: The URL string of the flag image.
struct FlagImage: View {

    /// The URL string of the flag image.
    let url: String

    /// The body of the `FlagImage` view.
    var body: some View {
        AsyncImage(url: URL(string: url)) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
        } placeholder: {
            Color.wrkspotGray
                .frame(width: 40, height: 40)
        }
    }
}

#Preview {
    let url = URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d3/Flag_of_Kiribati.svg/1280px-Flag_of_Kiribati.svg.png")!
    return FlagImage(url: url.absoluteString)
}
