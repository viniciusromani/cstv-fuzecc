//
//  MockMatches.swift
//  cstv-fuzeccTests
//
//  Created by Vinicius Romani on 05/09/24.
//

import Foundation
@testable import CSTV

extension Match {
    static func mock() -> Match {
        return mockSorted().randomElement()!
    }
    
    static func mockYesterday() -> Match {
        let isoFormatter = CachedDateFormatter.shared.iso8601Formatter()
        let dateFormatter = CachedDateFormatter.shared.fetchMatchesFilterFormatter()
        let noon = Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: Date())!
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: noon)!
        let yesterdayString = dateFormatter.string(from: yesterday)
        
        return Match(id: "1028862", status: "not_started",
              scheduledAt: isoFormatter.date(from: "\(yesterdayString)T13:30:00+0000")!,
              opponents: [Team.mock(), Team.mock()], league: League.mock(), serie: Serie.mock())
    }
    
    static func mockSorted() -> [Match] {
        let isoFormatter = CachedDateFormatter.shared.iso8601Formatter()
        let dateFormatter = CachedDateFormatter.shared.fetchMatchesFilterFormatter()
        let todayString = dateFormatter.string(from: Date())
        
        return [
            Match(id: "1021248", status: "running", 
                  scheduledAt: isoFormatter.date(from: "\(todayString)T10:30:00+0000")!,
                  opponents: [Team.mock(), Team.mock()], league: League.mock(), serie: Serie.mock()),
            
            Match(id: "1028863", status: "running", 
                  scheduledAt: isoFormatter.date(from: "\(todayString)T10:45:00+0000")!,
                  opponents: [Team.mock(), Team.mock()], league: League.mock(), serie: Serie.mock()),
            
            Match(id: "1028862", status: "not_started",
                  scheduledAt: isoFormatter.date(from: "\(todayString)T13:30:00+0000")!,
                  opponents: [Team.mock(), Team.mock()], league: League.mock(), serie: Serie.mock()),
            
            Match(id: "1033344", status: "not_started",
                  scheduledAt: isoFormatter.date(from: "\(todayString)T14:00:00+0000")!,
                  opponents: [Team.mock(), Team.mock()], league: League.mock(), serie: Serie.mock()),
            
            Match(id: "1032767", status: "finished", 
                  scheduledAt: isoFormatter.date(from: "\(todayString)T08:00:00+0000")!,
                  opponents: [Team.mock(), Team.mock()], league: League.mock(), serie: Serie.mock())
        ]
    }
    
    static func shuffled() -> [Match] {
        return mockSorted().shuffled()
    }
}
