//
//  Year.swift
//  RaceStandings
//
//  Created by Constantin Köhler on 1/8/18.
//  Copyright © 2018 Constantin Koehler. All rights reserved.
//

import Foundation

struct Year {
    static let minimumYear = 1950
    
    lazy var selectedYear = Year.currentYear()
    
    static func currentYear() -> Int{
        return Calendar.current.component(.year, from: Date())
    }
}
