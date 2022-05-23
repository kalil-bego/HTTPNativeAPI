//
//  DataError.swift
//  HTTPNativeAPI
//
//  Created by Kalil Bego on 16/05/22.
//

public struct DataError {
    let success: Bool = false
    let description: String
    
    public init(description: String) {
        self.description = description
    }
    
    func getJSONResponse() -> [String: Any] {
        ["sucesso": success, "description": description] as [String: Any]
    }
}
