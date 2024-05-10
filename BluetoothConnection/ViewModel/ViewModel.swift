import Foundation
import Combine

class ViewModel: ObservableObject, DeviceScannerDelegate {
    @Published var devices: [Device] = []
    @Published var posts: [Post] = []
    @Published var isLoading = false
    @Published var errorMessage = ""
    @Published var isScanning = false
    
    
    private var deviceScanner: DeviceScanner
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        deviceScanner = DeviceScanner()
        deviceScanner.delegate = self
    }
    
    func startScanning() {
        isScanning = true
        deviceScanner.startScanning()
        fetchPosts()
    }
    
    func stopScanning() {
        isScanning = false
    }
    
    func didDiscoverDevice(_ device: Device) {
        devices.append(device)
    }
    
    func fetchPosts() {
        guard let url = URL(string: "") else {
            errorMessage = "Invalid URL"
            return
        }
        
        isLoading = true
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [Post].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    self.isLoading = false
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }, receiveValue: { posts in
                self.posts = posts
            })
            .store(in: &cancellables)
    }
}
