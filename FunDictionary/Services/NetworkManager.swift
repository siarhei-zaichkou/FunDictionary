import Foundation

struct Links {
    static let baseUrl = "https://api.urbandictionary.com/v0/"
    static let searchByWord = baseUrl + "define?term="
    static let randomWord = baseUrl + "random"
}

enum NetworkError: Error {
    case invalidUrl
    case noData
    case decodingError
}

// MARK: - Networking
class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetch<T: Codable>(
        _ type: T.Type,
        from url: String,
        completion: @escaping (Result<T, NetworkError>) -> Void)  {
            guard let url = URL(string: url) else {
                completion(.failure(.invalidUrl))
                return
            }
            DispatchQueue.global().async {
            URLSession.shared.dataTask(with: url) { data, _, error in
                guard let data = data else {
                    completion(.failure(.noData))
                    return
                }
                do {
                    let definitions = try JSONDecoder().decode(T.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(definitions))
                    }
                } catch {
                    completion(.failure(.decodingError))
                }
            }.resume()
        }
    }
}
