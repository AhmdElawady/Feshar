//
//  DetailsResponse.swift
//  Feshar
//
//  Created by Awady on 4/11/20.
//  Copyright © 2020 Awady. All rights reserved.
//

import Foundation

struct DetailsResponse: Codable {
    let id: Int
    let name: String
    let mainPoster: String
    let IMDBRate: Double
    let Description: String
    let genres: [Genre]
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "title"
        case mainPoster = "poster_path"
        case IMDBRate = "vote_average"
        case Description = "overview"
        case genres
    }
}
