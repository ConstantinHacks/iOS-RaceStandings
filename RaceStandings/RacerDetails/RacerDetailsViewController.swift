//
//  RacerDetailsViewController.swift
//  RaceStandings
//
//  Created by Constantin Koehler on 1/11/18.
//  Copyright © 2018 Constantin Koehler. All rights reserved.
//

import Foundation
import UIKit

class RacerDetailsViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nationalityLabel: UILabel!
    @IBOutlet weak var DOBLabel: UILabel!
    @IBOutlet weak var wikipediaButton: UIButton!
    
    var racer : Racer?
    
    override func viewDidLoad() {
        guard let racer = racer else {
            return
        }

        nameLabel.text = racer.firstName + " " + racer.lastName
        nationalityLabel.text = racer.nationality
        DOBLabel.text = racer.dateOfBirth
        
        
        super.viewDidLoad()
    }
    

    
    
    
}
