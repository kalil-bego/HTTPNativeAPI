//
//  ServerManager.swift
//  HTTPNativeAPI
//
//  Created by Kalil Bego on 12/05/22.
//

import GCDWebServer

public struct ServerManager: Server {
    internal var port: UInt
    private var contextPath: String
    private var endpoints: [Endpoint]
    private let webServer: GCDWebServer = GCDWebServer()

    public init(port: UInt, contextPath: String) {
        self.port = port
        self.contextPath = contextPath
        self.endpoints = []
    }

    public func start(success: @escaping (URL) -> Void, failure: @escaping (Error?) -> Void) {
        webServer.start(withPort: port, bonjourName: nil)
        if webServer.isRunning {
            if let serverURL = self.webServer.serverURL {
                success(serverURL)
            } else {
                failure(ServerError.noFoundServerURL)
            }
        } else {
            failure(ServerError.serverNotLoaded)
        }
    }

    public func stop() {
        webServer.stop()
    }

    public mutating func addEndpoint(_ endpoint: Endpoint) {
        endpoint.methods.forEach { method in
            let path = endpoint.path
            let requestClass = endpoint.requestClass
            let pathRegex = "\(contextPath)\(path)($|[/?].*)" // "/bus/dmb"

            webServer.addHandler(
                forMethod: method.rawValue,
                pathRegex: pathRegex,
                request: requestClass,
                asyncProcessBlock: { (request, completion) in
                    endpoint.process(request: request, completion: completion)
                }
            )
            self.endpoints.append(endpoint)
        }
    }

    public func getEndpoints() -> [Endpoint] { self.endpoints }

    public func getContextPath() -> String { self.contextPath }
}
