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


// MARK: - ServiceResult

/// A representation of the result of a service request.
///
/// - Success: Indicates that the request successfully completed. The
///             resulting data is supplied.
/// - Failure: Indicates that the request failed. The underlying cause
///             of the failure is supplied with a ServiceError.
enum ServiceResult<T> {
    case Success(T)
    case Failure(Error)
}

typealias JSONAttributes = [String:Any]

struct NetworkManager {
    static let session = SessionManager()
    static var headers: HTTPHeaders {
        return [
            "Accept": "application/json",
            "Content-Type": "application/x-www-form-urlencoded",
        ]
    }
    private static let disposeBag = DisposeBag()

    static func getStandings(completion: @escaping(ServiceResult<[Standings]>?) -> Void) {
        let path = Constants.Network.currentLeaderBoard
        
        RxAlamofire.requestJSON(.get,path)
            .debug()
            .subscribe(onNext:{ json in
                if let dict = json as? JSONAttributes{
                    let mrData = dict["MRData"] as! Dictionary<String,AnyObject>
                }
            }).dispose(by: disposeBag)


                
//        RxAlamofire.requestJSON(
//            URL(string: path)!,
//            .get)
//        .validate()
//        .responseJSON { (response) -> Void in
//            guard response.result.isSuccess else{
//                print("Error: \(String(describing: response.result.error))")
//                completion(nil)
//                return
//            }
//
//            guard let value = response.result.value as? JSONAttributes,
//                let mrData = value["MRData"] as? JSONAttributes,
//                let standingsTable = mrData["StandingsTable:"] as? JSONAttributes,
//                let standingsList = standingsTable["StandingsLists"] as? JSONAttributes,
//                let driverStandings = standingsList["DriverStandings"] as? [JSONAttributes]
//                else{
//                    return
//                }
//
//            let leaderboard = driverStandings.flatMap({ (leaderBoardDict) -> Standings? in
//                return Standings(leaderBoardDict)
//            })
//
//            completion(ServiceResult.Success(leaderboard))
//
//        }
        
        
            
        
//        return json(.get, path)
//            .map({ json in
//                guard let MRdata = json["MRData"] as? JSON,
//                let standingsTable = MRdata["StandingsTable"] as? JSON,
//                let standingsList = standingsTable["StandingsLists"] as? JSON,
//                    let driverStandings = standingsList["DriverStandings"] as? [JSON]
//                    else{
//                        throw NetworkError.unknownResponse
//                }
//
//                return [Standings(driverStandings)!]
//            })

        
    }
