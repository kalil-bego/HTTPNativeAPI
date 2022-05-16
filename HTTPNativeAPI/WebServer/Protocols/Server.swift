//
//  Server.swift
//  HTTPNativeAPI
//
//  Created by Kalil Bego on 13/05/22.
//

import GCDWebServer

internal protocol Server {
    var webServer: GCDWebServer { get }
    var port: UInt { get }
    func start(success: @escaping(URL) -> Void, failure: @escaping(Error?) -> Void)
    func stop()
}

internal extension Server {
    var webServer: GCDWebServer { GCDWebServer() }
}
