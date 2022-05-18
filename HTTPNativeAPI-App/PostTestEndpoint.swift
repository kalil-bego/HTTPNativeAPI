//
//  PostTestEndpoint.swift
//  HTTPNativeAPI-App
//
//  Created by Kalil Bego on 17/05/22.
//

import HTTPNativeAPI

struct PostTestEndpoint: Endpoint {
    var path: String { "/testepost" }
    var methods: [HTTPMethod] { [.post] }
    
    func call(request: [String: Any]?, success: @escaping (DataResponse) -> Void, failure: @escaping (DataError) -> Void) {
        print(request)
        success(DataResponse(object: ["teste": "post"]))
    }
}
