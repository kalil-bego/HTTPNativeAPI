//
//  ServerManager.swift
//  HTTPNativeAPI
//
//  Created by Kalil Bego on 12/05/22.
//

import Foundation
import GCDWebServer

public class ServerManager {
    
    private let webServer: GCDWebServer = GCDWebServer()
    private let port: UInt
    
    public init(port: UInt) {
        self.port = port
        webServer.addDefaultHandler(forMethod: "GET",
                                    request: GCDWebServerRequest.self,
                                    processBlock: { request in
            return GCDWebServerDataResponse(html:"<html><body><p>Hello World</p></body></html>")
        })
    }
    
    public func start(completion: @escaping(URL?) -> Void) {
        webServer.start(withPort: port, bonjourName: nil)
        completion(webServer.serverURL)
    }
    
}
