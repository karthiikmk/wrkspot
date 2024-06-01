//
//  HomeView.swift
//  WrkSpotApp
//
//  Created by Karthik on 31/05/24.
//

import SwiftUI

/// A view that represents the home screen, displaying a header with the current time and a list of countries.
/// It also handles starting and stopping the Bluetooth device scanner.
struct HomeView: View {

    /// The view model responsible for managing the current date and time.
    @StateObject var viewModel = HomeViewModel()

    /// The view model responsible for managing the list of countries.
    @StateObject var countryListViewModel = CountryListViewModel()

    /// The Bluetooth device scanner service.
    @StateObject private var bluetoothDeviceScanner = BluetoothDeviceService()

    /// The body of the `HomeView`.
    var body: some View {
        NavigationView {
            VStack {
                HeaderView(currentTime: viewModel.currentDateTime)
                CountriesListView(viewModel: countryListViewModel)
                    .padding(.top, 6)
            }
            .padding(.horizontal, STANDARD_PADDING)
            .padding(.vertical, 10)
            .background(Color.wrkspotPurpleLight)
            .padding(1)
            .overlay(
                RoundedRectangle(cornerRadius: 0)
                    .stroke(Color.wrkspotPurple, lineWidth: 2)
            )
            .padding(.horizontal, STANDARD_PADDING)
            .onFirstAppear {
                bluetoothDeviceScanner.startScanning()
            }
            .onDisappear {
                bluetoothDeviceScanner.stopScanning()
            }
        }
    }
}

#Preview {
    HomeView()
}
