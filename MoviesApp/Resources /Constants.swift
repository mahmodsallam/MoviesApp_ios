//
//  Constants.swift
//  MoviesApp
//
//  Created by Mahmoud Sallam on 04/10/2021.
//

import Foundation
struct Constants {
    
    // API Keys
    struct APIKeys {
        static var kClientKey = "02f0b6f87e14295183c069276db46d42"
    }
    
    // API Headers
    struct APIHeaders {
        static var kContentType = "Content-Type"
        static var contentTypeValue = "application/json"
    }
    
    struct URLS {
        static var baseImageUrl = "https://image.tmdb.org/t/p/w500"
        static var baseURL = "https://api.themoviedb.org/3/movie/"
    }
    
    
}
