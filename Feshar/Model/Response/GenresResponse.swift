//
//  GenresResponse.swift
//  Feshar
//
//  Created by Awady on 4/11/20.
//  Copyright © 2020 Awady. All rights reserved.
//

import Foundation

struct GenreResponse: Codable {
    let genres: [Genre]
}


struct Genre: Codable {
    let id: Int
    let name: String
}
