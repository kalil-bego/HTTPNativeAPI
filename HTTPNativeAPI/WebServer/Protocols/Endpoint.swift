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

public protocol Post: PostBase {
    associatedtype DecodableModel: Decodable
    func call(model: DecodableModel, success: @escaping (DataResponse) -> Void, failure: @escaping (DataError) -> Void)
}

public protocol Put: PutBase {
    associatedtype DecodableModel: Decodable
    func call(model: DecodableModel, success: @escaping (DataResponse) -> Void, failure: @escaping (DataError) -> Void)
}

public protocol Delete: DeleteBase {
    associatedtype DecodableModel: Decodable
    func call(model: DecodableModel, success: @escaping (DataResponse) -> Void, failure: @escaping (DataError) -> Void)
}

public protocol PostBase {}

public protocol PutBase {}

public protocol DeleteBase {}

public extension Endpoint {
    var methods: [HTTPMethod] {
        var list: [HTTPMethod] = []
        switch self {
        case is PostBase:
            list.append(.post)
        case is PutBase:
            list.append(.put)
        case is DeleteBase:
            list.append(.delete)
        default:
            list.append(.get)
        }
        return list
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
        do {
            call(
                model: try parseModel(request, model: DecodableModel.self),
                success: successResponse(_:),
                failure: failureResponse(_:)
            )
        } catch let error {
            failureResponse(DataError(description: String(describing: error)))
        }
        setHeadersResponse(request: request)
        completion(response)
    }
}

public extension Endpoint where Self: Put {
    func process(request: GCDWebServerRequest, completion: @escaping (GCDWebServerCompletionBlock)) {
        do {
            call(
                model: try parseModel(request, model: DecodableModel.self),
                success: successResponse(_:),
                failure: failureResponse(_:)
            )
        } catch let error {
            failureResponse(DataError(description: error.localizedDescription))
        }
        setHeadersResponse(request: request)
        completion(response)
    }
}

public extension Endpoint where Self: Delete {
    func process(request: GCDWebServerRequest, completion: @escaping (GCDWebServerCompletionBlock)) {
        do {
            call(
                model: try parseModel(request, model: DecodableModel.self),
                success: successResponse(_:),
                failure: failureResponse(_:)
            )
        } catch let error {
            failureResponse(DataError(description: error.localizedDescription))
        }
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

fileprivate func parseModel<T: Decodable>(_ request: GCDWebServerRequest, model: T.Type) throws -> T {
    let dataRequest: GCDWebServerDataRequest? = request as? GCDWebServerDataRequest
    let data = dataRequest?.data ?? Data()
    let decoder = JSONDecoder()
    let decodedData = try decoder.decode(model.self, from: data)
    return decodedData
}
