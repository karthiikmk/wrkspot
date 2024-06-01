//
//  HomeViewModelTests.swift
//  WrkSpotAppTests
//
//  Created by Karthik on 01/06/24.
//

import XCTest
@testable import WrkSpotApp

final class HomeViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testUpdateDateTime() {
        // Given
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        formatter.timeZone = TimeZone(abbreviation: "PST")

        let mockDate = formatter.date(from: "2024/05/01 15:30")!
        let dateProvider = MockDateProvider(date: mockDate)
        let viewModel = HomeViewModel(dateProvider: dateProvider)
        // When
        viewModel.updateDateTime()
        // Then
        XCTAssertEqual(viewModel.currentDateTime, "1st May 3:30 PM PST")
    }
}

class MockDateProvider: DateProvider {
    var mockDate: Date
    init(date: Date) {
        self.mockDate = date
    }

    func currentDate() -> Date {
        return mockDate
    }
}
