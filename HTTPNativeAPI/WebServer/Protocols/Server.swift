//
//  Server.swift
//  HTTPNativeAPI
//
//  Created by Kalil Bego on 13/05/22.
//

import GCDWebServer

public protocol Server {
    var webServer: GCDWebServer { get }
    var port: UInt { get }
    func start(success: @escaping(URL) -> Void, failure: @escaping(Error?) -> Void)
}

public extension Server {
    var webServer: GCDWebServer { GCDWebServer() }
    
    func start(success: @escaping(URL) -> Void, failure: @escaping(Error?) -> Void) {
        if webServer.start(withPort: port, bonjourName: nil) {
            if let serverURL = webServer.serverURL {
                success(serverURL)
            } else {
                failure(nil)
            }
        } else {
            failure(nil)
        }
    }
}

