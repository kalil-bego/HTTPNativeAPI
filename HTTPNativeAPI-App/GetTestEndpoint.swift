//
//  GetTestEndpoint.swift
//  HTTPNativeAPI-App
//
//  Created by Kalil Bego on 16/05/22.
//

import Foundation
import HTTPNativeAPI

struct GetTestEndpoint: Endpoint {
    var path: String { "/teste" }
    var methods: [HTTPMethod] { [.get] }
    
    func call(success: @escaping (DataResponse) -> Void, failure: @escaping (DataError) -> Void) {
        success(DataResponse(object: ["hello": "world"]))
    }
}
