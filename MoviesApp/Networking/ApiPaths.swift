//
//  ApiPaths.swift
//  MoviesApp
//
//  Created by Mahmoud Sallam on 04/10/2021.
//

import Foundation
import UIKit
//#if DEBUG
//let environment = APIEnvironment.development
//#else
//let environment = APIEnvironment.production
//#endif

// get the base url based on the environmen)

struct APIPath {
    var popularMovies: String { return "\(Constants.URLS.baseURL)popular?api_key=\(Constants.APIKeys.kClientKey)"}
    var topRatedMovies: String {return "\(Constants.URLS.baseURL)top_rated?api_key=\(Constants.APIKeys.kClientKey)"}
}
