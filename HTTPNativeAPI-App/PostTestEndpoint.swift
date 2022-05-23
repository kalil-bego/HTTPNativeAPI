//
//  PostTestEndpoint.swift
//  HTTPNativeAPI-App
//
//  Created by Kalil Bego on 17/05/22.
//

import HTTPNativeAPI

struct PostTestEndpoint: Endpoint, Post {
    typealias DecodableModel = PostTestEndpointData
    var path: String { "/teste" }
    
    func call(model: PostTestEndpointData, success: @escaping (DataResponse) -> Void, failure: @escaping (DataError) -> Void) {
        success(DataResponse(object: ["teste" : model.data]))
    }
}

struct PostTestEndpointData: Decodable {
    let data: String
}
