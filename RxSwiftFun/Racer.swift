//
//  Racer.swift
//  RxSwiftFun
//
//  Created by Constantin Koehler on 12/20/17.
//  Copyright © 2017 Constantin Koehler. All rights reserved.
//

import Foundation

struct Racer{
    let firstName: String
    let lastName: String
    let nationality: String
    
    init(_ json:JSONAttributes){
        firstName = json["givenName"] as? String ?? ""
        lastName = json["familyName"] as? String ?? ""
        nationality = json["nationality"] as? String ?? ""
    }
}
