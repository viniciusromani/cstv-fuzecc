//
//  MockNetwork.swift
//  cstv-fuzeccTests
//
//  Created by Vinicius Romani on 05/09/24.
//

import Foundation
import Combine
@testable import cstv_fuzecc

class MockCache: CacheProtocol {
    var wrapped = [String: Any]()
    
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
