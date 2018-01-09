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
import SwiftyJSON


struct Standings {
    let place: String
    let racerDetails: Racer
    let constructorName: Constructor
    let points: String
    
    init(_ json: JSON) {
        place = json["position"].stringValue
        racerDetails = Racer(json["Driver"])
        constructorName = Constructor(json["Constructors"][0])
        points = json["points"].stringValue
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


