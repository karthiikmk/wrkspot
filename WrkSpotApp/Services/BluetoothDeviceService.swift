//
//  BluetoothDeviceScanner.swift
//  WrkSpotApp
//
//  Created by Karthik on 01/06/24.
//

import Foundation
import CoreBluetooth

/// A Bluetooth device scanner designed to interact with a panic button device.
/// This scanner connects to the panic button, reads its state, and handles notifications for button presses.
class BluetoothDeviceService: NSObject, ObservableObject {

    // Published properties for scanning state and detected peripherals
    @Published var isScanning = false

    private var centralManager: CBCentralManager!
    private var panicButtonPeripheral: CBPeripheral?
    private let panicButtonPeripheralName: String = "My Panic Button"

    // UUIDs for the characteristics of the panic button service
    private let panicButtonStateCharID = CBUUID(string: "0x2A56") // FIXME: - replace with acutal id

    private var panicButtonStateCharacteristic: CBCharacteristic?

    /// Initializes the BluetoothDeviceScanner and sets up the central manager.
    override init() {
        super.init()
        self.centralManager = CBCentralManager(delegate: self, queue: nil)
    }

    /// Starts scanning for Bluetooth peripherals.
    func startScanning() {
        guard centralManager.state == .poweredOn else {
            debugPrint("CentralManager state is not powered on!")
            return
        }
        debugPrint("Scanning for peripherals...")
        isScanning = true
        centralManager.scanForPeripherals(withServices: nil, options: nil)
    }

    /// Stops scanning for Bluetooth peripherals.
    func stopScanning() {
        centralManager.stopScan()
        isScanning = false
    }
}

// MARK: - CBCentralManagerDelegate
extension BluetoothDeviceService: CBCentralManagerDelegate {

    /// Called when the central manager's state is updated.
    /// - Parameter central: The central manager whose state has been updated.
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            debugPrint("CentralManager is powered on!")
            startScanning()
        } else {
            debugPrint("CentralManager state updated to \(central.state)")
        }
    }

    /// Called when a peripheral is discovered.
    /// - Parameters:
    ///   - central: The central manager that discovered the peripheral.
    ///   - peripheral: The discovered peripheral.
    ///   - advertisementData: A dictionary containing any advertisement data.
    ///   - RSSI: The received signal strength indicator (RSSI) of the peripheral.
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        guard peripheral.name == panicButtonPeripheralName else { return }
        // Stop existing scan
        centralManager.stopScan()
        // Initiate connection
        centralManager.connect(peripheral)
        panicButtonPeripheral = peripheral
    }

    /// Called when a connection to a peripheral is established.
    /// - Parameters:
    ///   - central: The central manager that established the connection.
    ///   - peripheral: The connected peripheral.
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        // Discover services provided by the peripheral
        peripheral.discoverServices(nil)
        peripheral.delegate = self
    }
}

// MARK: - CBPeripheralDelegate
extension BluetoothDeviceService: CBPeripheralDelegate {

    /// Called when services are discovered on the peripheral.
    /// - Parameters:
    ///   - peripheral: The peripheral that provides the services.
    ///   - error: An error object containing details of any errors that occurred.
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard let allServices = peripheral.services else { return }
        allServices.forEach { peripheral.discoverCharacteristics(nil, for: $0) }
    }

    /// Called when characteristics are discovered for a service on the peripheral.
    /// - Parameters:
    ///   - peripheral: The peripheral that provides the service.
    ///   - service: The service that contains the characteristics.
    ///   - error: An error object containing details of any errors that occurred.
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        guard let characteristics = service.characteristics else { return }
        for characteristic in characteristics where characteristic.uuid == panicButtonStateCharID {
            self.panicButtonStateCharacteristic = characteristic

            // Enable notifications for the characteristic if supported
            if characteristic.properties.contains(.notify) {
                peripheral.setNotifyValue(true, for: characteristic)
            }
        }
    }

    /// Called when the value of a characteristic is updated.
    /// - Parameters:
    ///   - peripheral: The peripheral that provides the characteristic.
    ///   - characteristic: The characteristic whose value has been updated.
    ///   - error: An error object containing details of any errors that occurred.
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        guard characteristic.uuid == panicButtonStateCharID, let value = characteristic.value else { return }

        // Decode the value to a format your app can use (e.g., integer or string)
        let buttonState = value.first.map { $0 != 0 }
        debugPrint("Panic button state \(String(describing: buttonState))")
    }
}

// MARK: - Reading from and Writing to Characteristics
extension BluetoothDeviceService {

    /// Writes data to the panic button state characteristic.
    /// - Parameter data: The data to write.
    func writeToCharacteristic(data: Data) {
        guard let peripheral = panicButtonPeripheral, let characteristic = panicButtonStateCharacteristic else { return }
        guard characteristic.properties.contains(.write) || characteristic.properties.contains(.writeWithoutResponse) else { return }

        let type: CBCharacteristicWriteType = characteristic.properties.contains(.write) ? .withResponse : .withoutResponse
        peripheral.writeValue(data, for: characteristic, type: type)
    }
}
