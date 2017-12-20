//
//  Standings.swift
//  RxSwiftFun
//
//  Created by Constantin Koehler on 12/18/17.
//  Copyright © 2017 Constantin Koehler. All rights reserved.
//


import Foundation
import RxSwift
import RxDataSources



struct Standings {
    let place: Int
    let racerName: String
    let constructorName: String
    let points: Double
}

struct SectionOfStandings {
    var header: String
    var items: [Item]
}

extension SectionOfStandings: SectionModelType {
    typealias Item = Standings
    
    init(original: SectionOfStandings, items: [Item]) {
        self = original
        self.items = items
    }
}


