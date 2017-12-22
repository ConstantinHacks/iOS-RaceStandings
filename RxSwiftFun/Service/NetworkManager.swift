//
//  NetworkManager.swift
//  RxSwiftFun
//
//  Created by Constantin Koehler on 12/20/17.
//  Copyright © 2017 Constantin Koehler. All rights reserved.
//

import RxSwift
import RxAlamofire
import Alamofire
import Foundation
import SwiftyJSON

struct NetworkManager {
    static let session = SessionManager()
    static var headers: HTTPHeaders {
        return [
            "Accept": "application/json",
            "Content-Type": "application/x-www-form-urlencoded",
        ]
    }
    private static let disposeBag = DisposeBag()

    static func getStandings(completion: @escaping([Standings]) -> Void) {
        let path = Constants.Network.currentLeaderBoard

        Alamofire.request(
            URL(string: path)!,
            method: .get)
        .validate()
        .responseJSON { (response) -> Void in
            guard response.result.isSuccess else{
                print("Error: \(String(describing: response.result.error))")
                completion([])
                return
            }
            
            let json = JSON(response.result.value!)
            let leaderboardData = json["MRData"]["StandingsTable"]["StandingsLists"][0]["DriverStandings"].arrayValue
            
            let leaderboard = leaderboardData.flatMap({ (leaderBoardDict) -> Standings? in
                return Standings(leaderBoardDict)
            })

            completion(leaderboard)
        }
    }
}
