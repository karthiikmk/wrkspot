//
//  SwiftUI+Ext.swift
//  WrkSpotApp
//
//  Created by Karthik on 31/05/24.
//

import Foundation
import SwiftUI

let STANDARD_PADDING: CGFloat = 8
let STANDARD_SPACING: CGFloat = 8

extension Color {
    static var random: Color {
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}

extension Int {
    /// Converts an integer to its ordinal string representation.
    var ordinal: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .ordinal
        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}

private struct OnFirstAppear: ViewModifier {

    @State private var hasAppeared = false
    let action: (() -> Void)?

    func body(content: Content) -> some View {
        content.onAppear {
            if !hasAppeared {
                hasAppeared = true
                action?()
            }
        }
    }
}

extension View {
    func onFirstAppear(perform action: (() -> Void)? = nil) -> some View {
        modifier(OnFirstAppear(action: action))
    }
}
