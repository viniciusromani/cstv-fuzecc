//
//  MockSerie.swift
//  cstv-fuzeccTests
//
//  Created by Vinicius Romani on 05/09/24.
//

import Foundation
@testable import cstv_fuzecc

extension Serie {
    static func mock() -> Serie {
        let series = [
            Serie(id: "7744", name: "Europe season 48 2024"),
            Serie(id: "7903", name: "Season 19 2024"),
            Serie(id: "7920", name: "Online Stage Fall 2024"),
            Serie(id: "7881", name: "Series #10 season 2 2024"),
            Serie(id: "7747", name: "Advanced Europe season 50 2024")
        ]
        return series.randomElement()!
    }
}
