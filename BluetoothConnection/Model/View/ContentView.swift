import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    

    var body: some View {
        NavigationView {
            
            VStack {
                
                Toggle("Scan Devices", isOn: $viewModel.isScanning)
                    .padding()
                
                if viewModel.isScanning {
                    
                    if viewModel.devices.isEmpty {
                        Text("No devices found")
                            .foregroundColor(.gray)
                            .padding()
                    } else {
                        List(viewModel.devices, id: \.id) { device in
                            DeviceRow(device: device)
                        }
                        .padding()
                    }
                } else {
                    Text("Toggle 'Scan Devices' to start scanning")
                        .padding()
                }
                
                if !viewModel.errorMessage.isEmpty {
                    Text("Error: \(viewModel.errorMessage)")
                        .foregroundColor(.red)
                        .padding()
                }
            }
            
            .navigationTitle("Bluetooth Devices")
        }
        
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

