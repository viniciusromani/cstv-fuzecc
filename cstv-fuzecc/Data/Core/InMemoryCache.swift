//
//  InMemoryCache.swift
//  cstv-fuzecc
//
//  Created by Vinicius Romani on 04/09/24.
//

import Foundation

protocol CacheProtocol: AnyObject {
    var wrapped: [String: Any] { get set }
    
    func insert(_ value: Any, forKey key: String)
    func value(forKey key: String) -> Any?
    func removeValue(forKey key: String)
}

final class InMemoryCache: CacheProtocol {
    internal var wrapped = [String: Any]()
    
    static let shared = InMemoryCache()
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
