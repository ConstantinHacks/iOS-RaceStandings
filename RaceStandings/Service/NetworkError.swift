//
//  NetworkError.swift
//  rofo-rewards-ios
//
//  Created by Jason Welch on 12/1/17.
//  Copyright © 2017 Mindgrub. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case unknownResponse

    static func error(forCode code: String) -> NetworkError {
        switch code {
        default:
            return .unknownResponse
        }
    }
}

extension NetworkError: LocalizedError {
    var title: String {
        return NSLocalizedString("Error", comment: "")
    }

    var localizedDescription: String {
        switch self {
        case .unknownResponse:
            return NSLocalizedString("Unexpected result has occurred", comment: "")
        }
    }
}
