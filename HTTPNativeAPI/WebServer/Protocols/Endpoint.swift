//
//  Endpoint.swift
//  HTTPNativeAPI
//
//  Created by Kalil Bego on 16/05/22.
//

import GCDWebServer

public protocol Endpoint {
    var path: String { get }
    var methods: [Methods] { get }
    var requestClass: GCDWebServerRequest.Type { get }
    func call(success: @escaping (DataResponse) -> Void, failure: @escaping (DataError) -> Void)
    func process(request: GCDWebServerRequest, completion: @escaping (GCDWebServerCompletionBlock))
}

public extension Endpoint {
    var methods: [Methods] {
        var lista: [Methods] = []
        switch self {
        case is Post:
            lista.append(.post)

        case is Get:
            lista.append(.get)

        case is Put:
            lista.append(.put)

        default:
            return [.get]
        }
        return lista
    }

    var requestClass: GCDWebServerRequest.Type {
        self is Get ? GCDWebServerRequest.self : GCDWebServerDataRequest.self
    }

    func process(request: GCDWebServerRequest, completion: @escaping (GCDWebServerCompletionBlock)) {
//        let dataRequest = (request as? GCDWebServerDataRequest)?.jsonObject as? [String: Any]
        var response: GCDWebServerDataResponse?
        if validate(request) {
            call(success: { data in
                response = GCDWebServerDataResponse(jsonObject: data.getJSONResponse())
                
                if let origin = request.headers["Origin"] {
                    response?.setValue(origin, forAdditionalHeader: "Access-Control-Allow-Origin")
                }
            }, failure: { error in
                response = GCDWebServerDataResponse(jsonObject: error.getJSONResponse())
            })
            completion(response)
        } else {
            completion(GCDWebServerResponse(statusCode: 401))
        }
    }

    private func validate(_ request: GCDWebServerRequest) -> Bool {
        request.headers["amc-session-id"] == SessionIdManager.sharedInstance.getInstance()
    }
}

public protocol Post {}

public protocol Get {}

public protocol Put {}

public protocol Delete {}
