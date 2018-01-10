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
    
    // Generate an array of ints starting with 1950 up to the current year
    static let yearsArray = Array(Year.minimumYear...Year.currentYear())
    
    static var selectedYear: Int {
        get{return UserDefaults.standard.integer(forKey: "leaderBoardYear")}
        set(v){UserDefaults.standard.set(v,forKey:"leaderBoardYear")}
    }
    
    //If it's before the first race-day, default to previous year
    static func currentYear() -> Int{
        if(Calendar.current.component(.month, from: Date()) > 3){
            return Calendar.current.component(.year, from: Date())
        } else {
            let oneYearAgo = Calendar.current.date(byAdding: .year,value: -1, to: Date())
            return Calendar.current.component(.year, from: oneYearAgo!)
        }
    }
}
