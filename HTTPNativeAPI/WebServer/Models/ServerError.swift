//
//  ServerError.swift
//  HTTPNativeAPI
//
//  Created by Kalil Bego on 14/05/22.
//

import Foundation

public enum ServerError: Error {
    case noFoundServerURL, serverNotLoaded
}

extension ServerError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noFoundServerURL: return "Could not find server URL"
        case .serverNotLoaded: return "The server cannot be loaded"
        }
    }
}
