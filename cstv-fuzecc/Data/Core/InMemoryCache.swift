//
//  InMemoryCache.swift
//  cstv-fuzecc
//
//  Created by Vinicius Romani on 04/09/24.
//

import Foundation

final class Cache {
    private var wrapped = [String: Any]()
    
    static let shared = Cache()
    private init() { }
    
    func insert(_ value: Any, forKey key: String) {
        wrapped.updateValue(value, forKey: key)
    }
    
    func value(forKey key: String) -> Any? {
        if let value = wrapped[key] {
            return value
        }
        return nil
    }
    
    func removeValue(forKey key: String) {
        wrapped.removeValue(forKey: key)
    }
}
