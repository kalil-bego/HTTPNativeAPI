//
//  DataError.swift
//  HTTPNativeAPI
//
//  Created by Kalil Bego on 16/05/22.
//

public struct DataError {
    let status: Int
    let description: String
    
    public init(status: Int = 500, description: String) {
        self.status = status
        self.description = description
    }
    
    func getJSONResponse() -> [String: Any] {
        ["status": status, "description": description] as [String: Any]
    }
}
