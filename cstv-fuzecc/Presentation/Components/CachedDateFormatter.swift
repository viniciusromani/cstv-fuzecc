//
//  CachedDateFormatter.swift
//  cstv-fuzecc
//
//  Created by Vinicius Romani on 03/09/24.
//

import Foundation

class CachedDateFormatter {
    struct Key: Equatable, Hashable {
        let format: String
        let locale: Locale
        
        static func == (lhs: Key, rhs: Key) -> Bool {
            return lhs.format == rhs.format &&
                   lhs.locale == rhs.locale
        }
    }
    
    static let shared = CachedDateFormatter()
    private init() { }
    
    private var cache = [Key: DateFormatter]()
    
    private func dateFormatter(format: String, locale: Locale = Locale.current) -> DateFormatter {
        let key = Key(format: format, locale: locale)
        if let cached = cache[key] {
            return cached
        }
        
        let formatter = DateFormatter()
        formatter.locale = locale
        formatter.dateFormat = format
        cache[key] = formatter
        return formatter
    }
}

// Available Formats
extension CachedDateFormatter {
    func fetchMatchesFilterFormatter() -> DateFormatter {
        let format = "yyyy-MM-dd"
        return dateFormatter(format: format)
    }
    
    func matchScheduleFormatter() -> DateFormatter {
        let format = "HH:mm"
        return dateFormatter(format: format)
    }
    
    func iso8601Formatter() -> DateFormatter {
        let format = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter(format: format)
    }
}
