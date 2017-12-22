//
//  Racer.swift
//  RxSwiftFun
//
//  Created by Constantin Koehler on 12/20/17.
//  Copyright © 2017 Constantin Koehler. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Racer{
    let firstName: String
    let lastName: String
    let nationality: String
    
    init(_ json:JSON){
        firstName = json["givenName"].stringValue
        lastName = json["familyName"].stringValue
        nationality = json["nationality"].stringValue
    }
}
