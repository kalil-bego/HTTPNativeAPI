//
//  PostTestEndpoint.swift
//  HTTPNativeAPI-App
//
//  Created by Kalil Bego on 17/05/22.
//

import HTTPNativeAPI

struct PostTestEndpoint: Endpoint {
    var path: String { "/teste" }
    var methods: [HTTPMethod] { [.post] }
    
    func call(success: @escaping (DataResponse) -> Void, failure: @escaping (DataError) -> Void) {
        success(DataResponse(object: ["teste": "post"]))
    }
}
