//
//  AddToWatchlistPost.swift
//  Feshar
//
//  Created by Awady on 4/11/20.
//  Copyright © 2020 Awady. All rights reserved.
//

import Foundation

struct AddToWatchlistPost: Codable {
    
    let mediaType: String
    let mediaId: Int
    let isWatchlist: Bool
    
    enum CodingKeys: String, CodingKey {
        case mediaType = "media_type"
        case mediaId = "media_id"
        case isWatchlist = "watchlist"
    }
}
