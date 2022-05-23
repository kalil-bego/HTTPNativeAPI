//
//  ServerManager.swift
//  HTTPNativeAPI
//
//  Created by Kalil Bego on 12/05/22.
//

import GCDWebServer

public typealias Model = Endpoint

public struct ServerManager: Server {
    internal var port: UInt
    private var contextPath: String
    private var endpoints: [Model]
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

    public mutating func addEndpoint(_ endpoint: Model) {
        endpoint.methods.forEach { method in
            let path = endpoint.path
            let pathRegex = "\(contextPath)\(path)($|[/?].*)" // "/bus/dmb"
            let requestClass = method == .get ? GCDWebServerRequest.self : GCDWebServerDataRequest.self

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

    public mutating func addEndpoints(_ enpoints: [Model]) {
        endpoints.forEach { endpoint in
            addEndpoint(endpoint)
        }
    }

    public func getEndpoints() -> [Model] { self.endpoints }

    public func getContextPath() -> String { self.contextPath }
}
