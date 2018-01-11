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
    let dateOfBirth: String
    let wikipediaURL: String
    
    
    init(_ json:JSON){
        firstName = json["givenName"].stringValue
        lastName = json["familyName"].stringValue
        nationality = json["nationality"].stringValue
        dateOfBirth = json["dateOfBirth"].stringValue
        wikipediaURL = json["url"].stringValue
    }
}
