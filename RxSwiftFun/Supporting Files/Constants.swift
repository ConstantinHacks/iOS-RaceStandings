//
//  Constants.swift
//  RxSwiftFun
//
//  Created by Constantin Koehler on 12/20/17.
//  Copyright © 2017 Constantin Koehler. All rights reserved.
//

import Foundation

import UIKit
import Foundation
import CoreLocation

var isPhoneX: Bool {
    guard UIDevice().userInterfaceIdiom == .phone else {
        return false
    }
    return UIScreen.main.nativeBounds.height == 2436
}

struct Constants {

    struct Network {
        static let rootURL: String = "https://ergast.com/api/f1/"
        static let currentLeaderBoard: String = rootURL + "2017/driverStandings.json"
    }
    
}
