//
//  DetailsService.swift
//  Feshar
//
//  Created by Awady on 4/9/20.
//  Copyright © 2020 Awady. All rights reserved.
//

import Foundation

struct MovieResults: Codable {
    let page: Int
    let results: [Movie]
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct Movie: Codable {
    let id: Int
    let name: String?   // movie name for Home
    let mainPoster: String
    let IMDBRate: Double
    let Description: String
    let genresId: [Int]
    let tvName: String?   // tv show name movie
    var isWatchlisted: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "title"
        case mainPoster = "poster_path"
        case IMDBRate = "vote_average"
        case Description = "overview"
        case genresId = "genre_ids"
        case tvName = "name"
        case isWatchlisted
    }
}

