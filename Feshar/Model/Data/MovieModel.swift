//
//  MovieModel.swift
//  Feshar
//
//  Created by Awady on 4/10/20.
//  Copyright © 2020 Awady. All rights reserved.
//

import Foundation

struct MovieModel: Equatable {
    
    static var allMovies = [Movie]()
    static var popular = [Movie]()
    static var latest = [Movie]()
    static var nowPlaying = [Movie]()
    static var watchList = [Movie]()
    static var action = [Movie]()
    static var comedy = [Movie]()
    static var romance = [Movie]()
    static var cast = [Cast]()
}
