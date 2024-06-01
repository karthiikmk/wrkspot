//
//  HomeViewModel.swift
//  WrkSpotApp
//
//  Created by Karthik on 31/05/24.
//

import Foundation
import Combine

/// A ViewModel that provides the current date and time, updated every minute.
class HomeViewModel: ObservableObject {

    // The current date and time as a formatted string.
    @Published var currentDateTime: String = ""

    // The subscription to the timer that triggers the date and time updates.
    private var timerSubscription: AnyCancellable?

    // The date provider, allowing for easy mocking in tests.
    private let dateProvider: DateProvider

    /// Initializes the HomeViewModel with a date provider.
    /// - Parameter dateProvider: An object conforming to the DateProvider protocol, used to provide the current date.
    init(dateProvider: DateProvider = Date()) {
        self.dateProvider = dateProvider
        setupDateTimePublisher()
    }

    /// Sets up a publisher to update the current date and time every minute.
    private func setupDateTimePublisher() {
        timerSubscription = Timer.publish(every: 60, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.updateDateTime()
            }
        updateDateTime()
    }

    /// Updates the current date and time string to the formatted current date and time.
    func updateDateTime() {
        let now = dateProvider.currentDate()
        let dayFormatter = DateFormatter()
        dayFormatter.dateFormat = "d"
        dayFormatter.timeZone = TimeZone(abbreviation: "PST")

        let restOfDateFormatter = DateFormatter()
        restOfDateFormatter.dateFormat = "MMM h:mm a 'PST'"
        restOfDateFormatter.timeZone = TimeZone(abbreviation: "PST")

        let day = Int(dayFormatter.string(from: now)) ?? 1
        currentDateTime = "\(day.ordinal) \(restOfDateFormatter.string(from: now))"
        debugPrint("updating time: \(currentDateTime)")
    }

    deinit {
        // Cancel the timer subscription to prevent memory leaks.
        timerSubscription?.cancel()
    }
}
