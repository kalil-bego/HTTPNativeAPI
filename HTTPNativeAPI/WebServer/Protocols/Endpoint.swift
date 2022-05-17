//
//  Endpoint.swift
//  HTTPNativeAPI
//
//  Created by Kalil Bego on 16/05/22.
//

import GCDWebServer

public protocol Endpoint {
    var path: String { get }
    var methods: [HTTPMethod] { get }
    func call(success: @escaping (DataResponse) -> Void, failure: @escaping (DataError) -> Void)
    func process(request: GCDWebServerRequest, completion: @escaping (GCDWebServerCompletionBlock))
}

public extension Endpoint {
    func process(request: GCDWebServerRequest, completion: @escaping (GCDWebServerCompletionBlock)) {
//        let dataRequest = (request as? GCDWebServerDataRequest)?.jsonObject as? [String: Any]
        var response: GCDWebServerDataResponse?
        call(success: { data in
            response = GCDWebServerDataResponse(jsonObject: data.getJSONResponse())
        }, failure: { error in
            response = GCDWebServerDataResponse(jsonObject: error.getJSONResponse())
        })
        response?.setValue(request.headers["Origin"], forAdditionalHeader: "Access-Control-Allow-Origin")
        completion(response)
    }
}
