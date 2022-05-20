//
//  PostTestEndpoint.swift
//  HTTPNativeAPI-App
//
//  Created by Kalil Bego on 17/05/22.
//

import HTTPNativeAPI

struct PostTestEndpoint: Endpoint, Post {
    var path: String { "/testepost" }
    
    func call(body: Data?, success: @escaping (DataResponse) -> Void, failure: @escaping (DataError) -> Void) {
        do {
            let json = try JSONDecoder().decode(PostTestEndpointData.self, from: body ?? Data())
            success(DataResponse(object: ["teste": json.data]))
        } catch let error {
            failure(DataError(description: error.localizedDescription))
        }
    }
}

struct PostTestEndpointData: Decodable {
    let data: String
}
