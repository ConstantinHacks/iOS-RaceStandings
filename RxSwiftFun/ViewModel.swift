//
//  ViewModel.swift
//  RxSwiftFun
//
//  Created by Constantin Koehler on 12/19/17.
//  Copyright © 2017 Constantin Koehler. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxDataSources

class ViewModel {
    
    private let standings: Observable<Standings>
    
    init(){
        standings = NetworkManager.getStandings()
            .flatMapLatest{
                
        }
    }
    
    func getStandings(onSuccess: @escaping (Standings) -> Void){
        
    }

}
