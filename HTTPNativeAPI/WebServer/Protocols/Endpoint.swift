//
//  Endpoint.swift
//  HTTPNativeAPI
//
//  Created by Kalil Bego on 16/05/22.
//

import GCDWebServer

public protocol Endpoint {
    var path: String { get }
    var methods: [HTTPMethod] { get }
    func process(request: GCDWebServerRequest, completion: @escaping (GCDWebServerCompletionBlock))
}

public protocol Get {
    func call(success: @escaping (DataResponse) -> Void, failure: @escaping (DataError) -> Void)
}

public protocol Post {
    func call(body: Data?, success: @escaping (DataResponse) -> Void, failure: @escaping (DataError) -> Void)
}

public protocol Put {
    func call(body: Data?, success: @escaping (DataResponse) -> Void, failure: @escaping (DataError) -> Void)
}

public protocol Delete {
    func call(body: Data?, success: @escaping (DataResponse) -> Void, failure: @escaping (DataError) -> Void)
}

public extension Endpoint {
    var methods: [HTTPMethod] {
        var list: [HTTPMethod] = []
        switch self {
        case is Post:
            list.append(.post)
        case is Put:
            list.append(.put)
        case is Delete:
            list.append(.delete)
        default:
            list.append(.get)
        }
        return list
    }
    
    func decodeObject<T: Decodable>(model: T.Type, data: Data) -> T? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(model.self, from: data)
            return decodedData
        } catch {
            return nil
        }
    }
}

public extension Endpoint where Self: Get {
    func process(request: GCDWebServerRequest, completion: @escaping (GCDWebServerCompletionBlock)) {
        call(
            success: successResponse(_:),
            failure: failureResponse(_:)
        )
        setHeadersResponse(request: request)
        completion(response)
    }
}

public extension Endpoint where Self: Post {
    func process(request: GCDWebServerRequest, completion: @escaping (GCDWebServerCompletionBlock)) {
        call(
            body: getBody(request),
            success: successResponse(_:),
            failure: failureResponse(_:)
        )
        setHeadersResponse(request: request)
        completion(response)
    }
}

public extension Endpoint where Self: Put {
    func process(request: GCDWebServerRequest, completion: @escaping (GCDWebServerCompletionBlock)) {
        call(
            body: getBody(request),
            success: successResponse(_:),
            failure: failureResponse(_:)
        )
        setHeadersResponse(request: request)
        completion(response)
    }
}

public extension Endpoint where Self: Delete {
    func process(request: GCDWebServerRequest, completion: @escaping (GCDWebServerCompletionBlock)) {
        call(
            body: getBody(request),
            success: successResponse(_:),
            failure: failureResponse(_:)
        )
        setHeadersResponse(request: request)
        completion(response)
    }
}

fileprivate var response: GCDWebServerDataResponse?

fileprivate func successResponse(_ data: DataResponse) {
    response = GCDWebServerDataResponse(jsonObject: data.getJSONResponse())
}

fileprivate func failureResponse(_ error: DataError) {
    response = GCDWebServerDataResponse(jsonObject: error.getJSONResponse())
}

fileprivate func setHeadersResponse(request: GCDWebServerRequest) {
    response?.setValue(request.headers["Origin"], forAdditionalHeader: "Access-Control-Allow-Origin")
}

fileprivate func getBody(_ request: GCDWebServerRequest) -> Data? {
    let dataRequest: GCDWebServerDataRequest? = request as? GCDWebServerDataRequest
    return dataRequest?.data
}
