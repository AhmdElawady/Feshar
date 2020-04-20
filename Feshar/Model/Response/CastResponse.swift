//
//  File.swift
//  Feshar
//
//  Created by Awady on 4/11/20.
//  Copyright © 2020 Awady. All rights reserved.
//

import Foundation

struct CastResponse: Codable {
    let id: Int
    let cast: [Cast]
}


struct Cast: Codable {
    let castId: Int
    let character: String
    let name: String
    let profilePic: String?
    
    enum CodingKeys: String, CodingKey {
        case castId = "cast_id"
        case character
        case name
        case profilePic = "profile_path"
    }
}
