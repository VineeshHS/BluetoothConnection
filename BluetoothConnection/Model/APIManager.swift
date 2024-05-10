import Foundation
import Combine

class APIManager {
    static let shared = APIManager()
    
    private let baseURL = ""
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetchPosts() -> AnyPublisher<[Post], Error> {
        guard let url = URL(string: "\(baseURL)/posts") else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }
        
        return session.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [Post].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

enum NetworkError: Error {
    case invalidURL
}
