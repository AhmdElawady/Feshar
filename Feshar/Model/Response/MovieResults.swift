//
//  DetailsService.swift
//  Feshar
//
//  Created by Awady on 4/9/20.
//  Copyright © 2020 Awady. All rights reserved.
//

import UIKit

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
