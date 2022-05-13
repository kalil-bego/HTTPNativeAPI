//
//  ServerManager.swift
//  HTTPNativeAPI
//
//  Created by Kalil Bego on 12/05/22.
//

import Foundation
import GCDWebServer

public struct ServerManager: Server {
    public var port: UInt
    private var baseURL: String
    private var endpoints: [Endpoint]
    
    public init(port: UInt, baseURL: String) {
        self.port = port
        self.baseURL = baseURL
        self.endpoints = []
    }
    
    public func getBaseURL() -> String { self.baseURL }
    
    public mutating func addEndpoint(_ endpoint: Endpoint) {
        self.endpoints.append(endpoint)
    }
    
    public func getEndpoints() -> [Endpoint] { self.endpoints }
}

public struct Endpoint {
    private let path: String
    
    public init(path: String) {
        self.path = path
    }
}
