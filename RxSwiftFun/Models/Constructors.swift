//
//  Constructors.swift
//  RxSwiftFun
//
//  Created by Constantin Köhler on 12/22/17.
//  Copyright © 2017 Constantin Koehler. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Constructor{
    let name : String
    let nationality : String
    
    init(_ json: JSON) {
        name = json["name"].stringValue
        nationality = json["nationality"].stringValue
    }
}


