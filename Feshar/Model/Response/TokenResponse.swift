//
//  LoginResponse.swift
//  Feshar
//
//  Created by Awady on 4/10/20.
//  Copyright © 2020 Awady. All rights reserved.
//

import Foundation


struct TokenResponse: Codable {
    let success: Bool
    let expiresAt: String
    let requestToken: String
    
    enum CodingKeys: String, CodingKey {
        case success
        case expiresAt = "expires_at"
        case requestToken = "request_token"
    }
}
