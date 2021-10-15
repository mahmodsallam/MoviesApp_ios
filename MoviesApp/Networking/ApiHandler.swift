//
//  ApiHandler.swift
//  MoviesApp
//
//  Created by Mahmoud Sallam on 04/10/2021.
//

import Foundation


//This enum is used for maping different HTTP Methods
enum HttpMethod: String{
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

// this enum is used for dealing with the different status of networking
struct ServiceError: Error,Codable {
    let httpStatus: Int
    let message: String
}


// this protocol is used for handling request
protocol RequestHandler{
    associatedtype Request
    func makeRequest(from Data:Request ) -> URLRequest?
}

// added features for the request handler protocol like adding query parameters
extension RequestHandler {
    func setQueryParams(parameters:[String: Any], url: URL) -> URL {
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        components?.queryItems = parameters.map { element in URLQueryItem(name: element.key, value: String(describing: element.value) ) }
        return components?.url ?? url
    }
    func setDefaultHeaders(request: inout URLRequest) {
        request.setValue(Constants.APIHeaders.contentTypeValue, forHTTPHeaderField: Constants.APIHeaders.kContentType)
    }
}

// this protocol is used for dealing with response
protocol ResponseHandler{
    associatedtype Response
    func parseResponse(data:Data , response:HTTPURLResponse) throws -> Response
}

// extensions for the response handler
extension ResponseHandler {
    func defaultParseResponse<T: Codable>(data: Data, response: HTTPURLResponse) throws -> T {
        let jsonDecoder = JSONDecoder()
        do {
            let body = try jsonDecoder.decode(T.self, from: data)
            if response.statusCode == 200 {
                return body
            } else {
                throw ServiceError(httpStatus: response.statusCode, message: "Unknown Error")
            }
        } catch  {
            throw ServiceError(httpStatus: response.statusCode, message: error.localizedDescription)
        }
        
    }
}



typealias ApiHandler = RequestHandler & ResponseHandler







