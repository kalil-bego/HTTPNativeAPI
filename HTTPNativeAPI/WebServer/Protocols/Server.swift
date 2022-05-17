//
//  Server.swift
//  HTTPNativeAPI
//
//  Created by Kalil Bego on 13/05/22.
//

internal protocol Server {
    var port: UInt { get }
    func start(success: @escaping(URL) -> Void, failure: @escaping(Error?) -> Void)
    func stop()
}
