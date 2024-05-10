import Foundation
import CoreBluetooth

protocol DeviceScannerDelegate: AnyObject {
    func didDiscoverDevice(_ device: Device)
}

class DeviceScanner: NSObject, ObservableObject {
    weak var delegate: DeviceScannerDelegate?
    
    private var centralManager: CBCentralManager!
    
    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    func startScanning() {
        centralManager.scanForPeripherals(withServices: nil, options: nil)
    }
}

extension DeviceScanner: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            startScanning()
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        let device = Device(name: peripheral.name ?? "Unknown Device", id: peripheral.identifier)
        delegate?.didDiscoverDevice(device)
    }
}

