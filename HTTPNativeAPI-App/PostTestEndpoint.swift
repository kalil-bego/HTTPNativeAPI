//
//  PostTestEndpoint.swift
//  HTTPNativeAPI-App
//
//  Created by Kalil Bego on 17/05/22.
//

import HTTPNativeAPI

struct PostTestEndpoint: Endpoint, Post {
    var path: String { "/teste" }
    
    func call(body: Data?, success: @escaping (DataResponse) -> Void, failure: @escaping (DataError) -> Void) {
        guard let object = decodeObject(model: PostTestEndpointData.self, data: body ?? Data()) else {
            failure(DataError(description: ""))
            return
        }
        success(DataResponse(object: ["teste": object.data]))
    }
}

struct PostTestEndpointData: Decodable {
    let data: String
}
