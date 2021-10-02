//
//  NetworkManger.swift
//  Space_iOS
//
//  Created by lina on 2021/10/02.
//

import Foundation

final class NetworkManger {
    
    static let shared = NetworkManger()
    private init() {}
    
    private enum NetworkError: Error {
        case invalidURL
        case failureResponse(code: Int?)
        case emptyData
    }
    
    func request(urlString: String, parameters: [String : String]? = nil, completion: @escaping (Result<Data, Error>) -> ()) {
        guard let urlRequest = URLRequest.makeURLRequest(from: urlString, parameters: parameters) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
//        urlRequest.addValue(Config.bearerToken, forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                let statusCode = (response as? HTTPURLResponse)?.statusCode
                completion(.failure(NetworkError.failureResponse(code: statusCode)))
                return
            }
            if let data = data {
                completion(.success(data))
            }
        }.resume()
    }
}
