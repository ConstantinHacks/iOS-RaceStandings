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
    
    func getStandings() -> Observable<[Standings]> {
        return Observable.create { (observer) -> Disposable in
            let standings = [
                Standings(place: 1, racerName: "Lewis Hamilton", constructorName: "Mercedes", points: 300),
                Standings(place: 2, racerName: "Sebastian Vettel", constructorName: "Ferrari", points: 200),
                Standings(place: 3, racerName: "Daniel Ricciardo", constructorName: "Red Bull", points: 100)
                ]
            observer.onNext(standings)
            observer.onCompleted()
            
            return Disposables.create {
                print("Disposed")
            }
        }
    }
}
