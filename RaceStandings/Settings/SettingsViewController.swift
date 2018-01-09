//
//  SettingsViewController.swift
//  RaceStandings
//
//  Created by Constantin Koehler on 1/9/18.
//  Copyright © 2018 Constantin Koehler. All rights reserved.
//

import Foundation
import UIKit


class SettingsViewController : UIViewController {
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.topItem?.title = "Settings"
    }
}
