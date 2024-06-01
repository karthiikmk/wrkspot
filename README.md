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

- **ListView State Management**: The app effectively handles different states like loading, empty, failure, and loaded.

  <img src="https://github.com/karthiikmk/wrkspot/assets/15947675/2d2f9cbe-6960-4db5-9c96-94187ad14bcc" alt="Simulator Screenshot - iPhone 15 Pro Max - 2024-02-16 at 12.35.34" width="200" height="420">
  <img src="https://github.com/karthiikmk/wrkspot/assets/15947675/3fa02723-e24f-4b04-9566-f4e6e17133a1" alt="Simulator Screenshot - iPhone 15 Pro Max - 2024-02-16 at 12.35.40" width="200" height="420">
  <img src="https://github.com/karthiikmk/wrkspot/assets/15947675/4524e838-375d-45e6-82e6-5e754aa33a3d" alt="Simulator Screenshot - iPhone 15 Pro Max - 2024-02-16 at 12.35.40" width="200" height="420">
  <img src="https://github.com/karthiikmk/wrkspot/assets/15947675/c8b49f9c-348b-4fb3-9e3d-b0a85bf97f8f" alt="Simulator Screenshot - iPhone 15 Pro Max - 2024-02-16 at 12.35.40" width="200" height="420">

- **Population Filtering**: Users can filter countries based on population sizes.
  
  <img src="https://github.com/karthiikmk/wrkspot/assets/15947675/4b8aaa1d-a30d-4059-a670-aabf4ea7a661" alt="Simulator Screenshot - iPhone 15 Pro Max - 2024-02-16 at 12.35.40" width="200" height="420">
  <img src="https://github.com/karthiikmk/wrkspot/assets/15947675/5b03561c-0ba0-40dd-8ac0-dff4cede7a96" alt="Simulator Screenshot - iPhone 15 Pro Max - 2024-02-16 at 12.35.40" width="200" height="420">

- **Search Functionality**: Users can search for countries by name.

  <img src="https://github.com/karthiikmk/wrkspot/assets/15947675/c5e5aa9e-d119-44ae-855f-b77a0b8a1c62" alt="Simulator Screenshot - iPhone 15 Pro Max - 2024-02-16 at 12.35.34" width="200" height="420">

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

<img src="https://github.com/karthiikmk/wrkspot/assets/15947675/031b503f-dfcf-40c8-b9f6-71cfcbe4765b" alt="Simulator Screenshot - iPhone 15 Pro Max - 2024-02-16 at 12.35.34" width="300" height="500"> 
<img src="https://github.com/karthiikmk/wrkspot/assets/15947675/92d81c6b-978e-420e-bd1a-0928216dd538" alt="Simulator Screenshot - iPhone 15 Pro Max - 2024-02-16 at 12.35.34" width="600" height="500"> 

### Testing

The ViewModels are fully unit tested, ensuring the business logic is reliable and the app is maintainable. You can generate a code coverage report to see the extent of the tests.
![Screenshot 2024-06-01 at 4 44 12 PM](https://github.com/karthiikmk/wrkspot/assets/15947675/5f61f5aa-78c6-4f3c-a707-4c422c88428a)

### Previews

All views and components support previews in the Xcode canvas, allowing for easy UI development and iteration.
![image](https://github.com/karthiikmk/wrkspot/assets/15947675/5983d071-52d9-4d53-b2ea-8eb25e07a3e4)


## Conclusion

This project shows how to build a modern iOS app using SwiftUI. It focuses on clean architecture, robust state management, and best practices. The features and improvements demonstrate a comprehensive skill set in iOS development.

---
