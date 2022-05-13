//
//  ServerManager.swift
//  HTTPNativeAPI
//
//  Created by Kalil Bego on 12/05/22.
//

import Foundation
import GCDWebServer

final public class ServerManager {
    
    private let webServer: GCDWebServer = GCDWebServer()
    
    public init(port: UInt) {
        webServer.addDefaultHandler(forMethod: "GET", request: GCDWebServerRequest.self, processBlock: { request in
            return GCDWebServerDataResponse(html:"<html><body><p>Hello World</p></body></html>")
        })
            
        webServer.start(withPort: port, bonjourName: "GCD Web Server")
        
        print("Visit \(String(describing: webServer.serverURL)) in your web browser")
    }
    
}
