//
//  GetTestEndpoint.swift
//  HTTPNativeAPI-App
//
//  Created by Kalil Bego on 16/05/22.
//

import HTTPNativeAPI

struct GetTestEndpoint: Endpoint {
    var path: String { "/teste" }
    var methods: [HTTPMethod] { [.get] }
    
    func call(request: [String: Any]?, success: @escaping (DataResponse) -> Void, failure: @escaping (DataError) -> Void) {
        success(DataResponse(object: ["hello": "world"]))
    }
}
