//
//  DataResponse.swift
//  HTTPNativeAPI
//
//  Created by Kalil Bego on 16/05/22.
//

public struct DataResponse {
    let success: Bool
    let object: [String: Any]
    
    public init(success: Bool = true, object: [String: Any]) {
        self.success = success
        self.object = object
    }

    func getJSONResponse() -> [String: Any] {
        ["data": object] as [String: Any]
    }
}
