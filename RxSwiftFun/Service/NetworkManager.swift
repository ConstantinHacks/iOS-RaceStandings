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

struct NetworkManager {
    static let session = SessionManager()
    static var headers: HTTPHeaders {
        return [
            "Accept": "application/json",
            "Content-Type": "application/x-www-form-urlencoded",
        ]
    }
    private static let disposeBag = DisposeBag()

    static func getStandings() -> Observable<[Standings]> {
        let path = Constants.Network.currentLeaderBoard
        
        return json(.get, path)
            .map({ json in
                guard let MRdata = json["MRData"] as? JSON,
                let standingsTable = MRdata["StandingsTable"] as? JSON,
                let driverStandings = standingsTable["DriverStandings"] as? JSON
                    else{
                        throw NetworkError.unknownResponse
                }
                
                return [Standings(driverStandings)!]
            })
    }
    
}

typealias JSON = [String: Any]

/**
 Identifies any model that can be instantiated by a `JSON` object
 */
protocol JSONConvertable {
    init(_ json: JSON)
    var isValid: Bool { get }
}

extension NetworkManager {
    
    private static func json(_ method: HTTPMethod, _ url: URLConvertible, parameters: [String : Any]? = nil, encoding: ParameterEncoding = JSONEncoding.default) -> Observable<JSON> {
        
        return jsonArray(method, url, parameters: parameters, encoding: encoding)
            .map { jsonArray throws -> JSON in
                if jsonArray.count == 1, let json = jsonArray.first {
                    return json
                }
                throw NetworkError.unknownResponse
        }
    }
    
    private static func jsonArray(_ method: HTTPMethod, _ url: URLConvertible, parameters: [String : Any]? = nil, encoding: ParameterEncoding = JSONEncoding.default) -> Observable<[JSON]> {
        
        let serializer = DataResponseSerializer { (_, _, data, _) -> Result<[JSON]> in
            do {
                let json = try self.extractJSONCollection(from: data)
                return Result.success(json)
            } catch {
                return Result.failure(error)
            }
        }
        
        return session.rx
            .request(method, url, parameters: parameters, encoding: encoding, headers: headers)
            .flatMap { $0.rx.result(responseSerializer: serializer) }
    }
    
    /// Receives data returned from a network call and throws if any error is found or JSON can't be extracted. An array is returned for simpler reuse.
    private static func extractJSONCollection(from data: Data?) throws -> [JSON] {
        guard let data = data else {
            // Something has gone horribly wrong
            throw NetworkError.unknownResponse
        }
        guard let jsonObject = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) else {
            // No JSON in response
            throw NetworkError.unknownResponse
        }
        
        if let jsonArray = jsonObject as? [JSON] {
            return jsonArray
        }
        
        guard let json = jsonObject as? JSON else {
            throw NetworkError.unknownResponse
        }
        // Check for error message in JSON
        if let errorCode = json["error"] as? String {
            throw NetworkError.error(forCode: errorCode)
        } else {
            return [json]
        }
    }
}

