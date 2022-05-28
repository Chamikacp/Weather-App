//
//  APIService.swift
//  WeatherApp
//
//  Created by Chamika Perera on 2022-05-21.
//

import Foundation

// API Weather service
public class APIService {
    public static let shared = APIService()
    
    public enum APIError: Error {
        case error(_ errorString: String)
    }
    
    // get json from api
    public func getJSON<T: Decodable>(urlString: String,
                                      dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate,
                                      keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys,
                                      completion: @escaping (Result<T,APIError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.error(NSLocalizedString("Error: Invalid URL", comment: ""))))
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(.error("Error: \(error.localizedDescription)")))
                return
            }
            guard let data = data else {
                completion(.failure(.error(NSLocalizedString("Error: Data is unreadable", comment: ""))))
                return
            }
            let decorder = JSONDecoder()
            decorder.dateDecodingStrategy = dateDecodingStrategy
            decorder.keyDecodingStrategy = keyDecodingStrategy
            do {
                let decodedData = try decorder.decode(T.self, from: data)
                completion(.success(decodedData))
                return
            } catch let decodingError {
                completion(.failure(APIError.error("Error: \(decodingError.localizedDescription)")))
                return
            }
        }.resume()
    }
}
