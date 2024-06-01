# WrkSpot App

## Overview

This project is an iOS app built for iOS 17 using SwiftUI. It shows how to use modern iOS development practices and technologies. The app follows the MVVM pattern and uses SOLID principles. It includes features like listing countries with search and filtering, and basic Bluetooth scanning, assuming a panic button device.

## Tech Stack

- **iOS 17**
- **SwiftUI**
- **Swift Package Manager**
- **Combine**
- **Swift Serialization (Encodable & Decodable)**

## Architecture

### MVVM

The app uses the Model-View-ViewModel (MVVM) architecture. This separates the business logic and state management (handled by the ViewModels) from the UI (handled by the Views), making the app easier to test and maintain.

### SOLID Principles

The code follows SOLID principles, which helps keep the system scalable, maintainable, and robust. For example, `CountryFetcher` and `CountrySearcher` components demonstrate these principles.

## Features

### Header Time Update

- The header time is updated every minute to display the current time.

### Bluetooth Peripheral Scanning

- The app includes basic Bluetooth scanning, assuming the use of a panic button device.

### Country Listing

- **Search Functionality**: Users can search for countries by name.
- **Population Filtering**: Users can filter countries based on population sizes.
- **Robust State Management**: The app effectively handles different states like loading, empty, failure, and loaded.

## Improvements

- **Color Management**: Uses color sets from the asset catalog for consistent colors.
- **Population Filter**: Added a population filter caption view under the search bar with a clear button.
- **Edge Case Handling**: Handles all edge cases in the country list, including failure, empty, loading, and loaded states.
- **Code Coverage**: Ensures extensive unit test coverage for all ViewModels.
- **Preview Support**: All views and components can be previewed in the canvas for easy UI development.

## Running the Project

1. Clone the repository.
2. Open the project in Xcode.
3. Build the project to generate documentation.
   - Go to **Product** → **Build for** → **Documentation** (or use `Ctrl + Shift + Cmd + D`).

### Documentation

The project is fully documented using DocC. To view the documentation:
1. Build the project as described above.
2. Access the documentation through Xcode to get detailed insights into the codebase.

### Testing

The ViewModels are fully unit tested, ensuring the business logic is reliable and the app is maintainable. You can generate a code coverage report to see the extent of the tests.

### Previews

All views and components support previews in the Xcode canvas, allowing for easy UI development and iteration.

## Conclusion

This project shows how to build a modern iOS app using SwiftUI. It focuses on clean architecture, robust state management, and best practices. The features and improvements demonstrate a comprehensive skill set in iOS development.

---
