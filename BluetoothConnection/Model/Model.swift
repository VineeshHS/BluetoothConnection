import Foundation
import CoreBluetooth

struct Post: Codable,Identifiable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}


struct SensorData: Codable {
    let sensorID: String
    let value: Double
    let timestamp: Date
}


struct Device {
    let name: String
    let id: UUID
}

