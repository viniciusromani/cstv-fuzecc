//
//  Endpoint.swift
//  cstv-fuzecc
//
//  Created by Vinicius Romani on 02/09/24.
//

import Foundation

struct Endpoint {
    var path: String
    var queryItems: [URLQueryItem] = []
}
extension Endpoint {
    /**
     TODO: this should not be here, take a look at the following to store secrete keys the right way
     https://nshipster.com/secrets
     */
    var bearerToken: String {
        return "fnZQ78GqKHZgI3ghRhIuYTZ0Z9H8i1dhHyuI85a5EYsKnyp-hPY"
    }
    
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.pandascore.co"
        components.path = "/csgo" + path
        components.queryItems = queryItems
        
        guard let url = components.url else {
            preconditionFailure("Mal-formed URL \(components)")
        }
        
        return url
    }
    
    var headers: [String: Any] {
        return ["Authorization": "Bearer \(bearerToken)"]
    }
}

extension Endpoint {
    static var matches: Self {
        return Endpoint(path: "/matches")
    }
    
    static func match(id: String) -> Self {
        return Endpoint(path: "/matches/\(id)")
    }
}
