//
//  URLRequest.swift
//  Space_iOS
//
//  Created by lina on 2021/10/02.
//

import Foundation

extension URLRequest {
    static func makeURLRequest(from urlString: String, parameters: [String: String]? = nil) -> URLRequest? {
        guard var component = URLComponents(string: urlString) else {
            return nil
        }
        if let parameter = parameters {
            var queryItems: [URLQueryItem] = []
            for (key, value) in parameter {
                let queryItem = URLQueryItem(name: key, value: value)
                queryItems.append(queryItem)
            }
            component.queryItems = queryItems
        }
        guard let url = component.url else {
            return nil
        }
        return URLRequest(url: url)
    }
}
