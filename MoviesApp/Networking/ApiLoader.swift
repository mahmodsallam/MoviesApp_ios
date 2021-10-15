//
//  ApiLoader.swift
//  MoviesApp
//
//  Created by Mahmoud Sallam on 04/10/2021.
//

import Foundation
struct APILoader<T: ApiHandler> {
    var apiHandler: T
    var urlSession: URLSession
    
    init(apiHandler: T, urlSession: URLSession = .shared) {
        self.apiHandler = apiHandler
        self.urlSession = urlSession
    }
    
    func loadAPIRequest(requestData: T.Request, completionHandler: @escaping (T.Response?, ServiceError?) -> ()) {
        if let urlRequest = apiHandler.makeRequest(from: requestData) {
            urlSession.dataTask(with: urlRequest) { (data, response, error) in
                
                if let httpResponse = response as? HTTPURLResponse {
                    
                    guard error == nil else {
                        completionHandler(nil, ServiceError(httpStatus: httpResponse.statusCode, message: "ServiceError : \(error?.localizedDescription ?? "Unknown Error")"))
                        return
                    }
                    
                    guard let responseData = data else {
                        completionHandler(nil, ServiceError(httpStatus: httpResponse.statusCode, message: "ServiceError : \(error?.localizedDescription ?? "Unknown Error")"))
                        return
                    }
                    
                    do {
                        let parsedResponse = try self.apiHandler.parseResponse(data: responseData, response: httpResponse)
                         completionHandler(parsedResponse, nil)
                    } catch {
                         completionHandler(nil, ServiceError(httpStatus:  httpResponse.statusCode, message: "ServiceError : \(error.localizedDescription)"))
                    }
                }
                
            }.resume()
        }
    }
}
