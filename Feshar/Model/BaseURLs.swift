//
//  BaseURLs.swift
//  Feshar
//
//  Created by Awady on 4/7/20.
//  Copyright © 2020 Awady. All rights reserved.
//

import Foundation


struct BaseURLs {
    
    static let baseImageUrl = "http://image.tmdb.org/t/p/w300"
    static let homeUrl = "http://api.themoviedb.org/3/trending/movie/week?api_key=6c52966d9be717e486a2a0c499867009&page=1&sort_by=release_date.desc"
    static let featuredUrl = "http://api.themoviedb.org/3/discover/movie?api_key=6c52966d9be717e486a2a0c499867009&page=1&sort_by=release_date.desc"
    static let detailsUrl = "https://api.themoviedb.org/3/movie/10784?api_key=6c52966d9be717e486a2a0c499867009&language=en-US"
    
}
