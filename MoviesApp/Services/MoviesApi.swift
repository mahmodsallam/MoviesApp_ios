//
//  MoviesApi.swift
//  MoviesApp
//
//  Created by Mahmoud Sallam on 05/10/2021.
//

import Foundation
struct MoviesApi:ApiHandler{
    func makeRequest(from param: [String: Any]) -> URLRequest? {
        let urlString =  APIPath().popularMovies
        if var url = URL(string: urlString) {
            if param.count > 0 {
                url = setQueryParams(parameters: param, url: url)
            }
            var urlRequest = URLRequest(url: url)
            setDefaultHeaders(request: &urlRequest)
            
            urlRequest.httpMethod = HttpMethod.get.rawValue
            return urlRequest
        }
        return nil
    }
    
    func parseResponse(data: Data, response: HTTPURLResponse) throws -> MovieModel {
        return try defaultParseResponse(data: data,response: response)
    }
}
