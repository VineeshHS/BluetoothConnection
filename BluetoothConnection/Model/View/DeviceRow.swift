import Foundation
import CoreBluetooth
import SwiftUI
struct DeviceRow: View {
    let device: Device
    @State private var isConnected = false
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(device.name)
                    .font(.headline)
                Text(device.id.uuidString)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
            Button(action: {
                if isConnected {
                    // Disconnect from device
                    // Implement disconnection logic here
                    isConnected = false
                } else {
                    // Connect to device
                    // Implement connection logic here
                    isConnected = true
                }
            }) {
                Text(isConnected ? "Disconnect" : "Connect")
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(isConnected ? Color.red : Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(5)
            }
        }
        .padding(.vertical, 5)
    }
}


