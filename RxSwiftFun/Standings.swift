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
    let place: String
    let racerDetails: Racer
    let constructorName: String
    let points: String
    
    init?(_ json: JSONAttributes) {
        place = json["position"] as? String ?? ""
        racerDetails = Racer(json["Driver"] as! JSONAttributes)
        constructorName = "VAUXHALL"
        points = json["points"] as? String ?? ""
    }
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


