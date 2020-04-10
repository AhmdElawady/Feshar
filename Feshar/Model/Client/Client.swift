//
//  Client.swift
//  Feshar
//
//  Created by Awady on 4/10/20.
//  Copyright © 2020 Awady. All rights reserved.
//

import Foundation


class Client {
    
    static let apiKey = "ca063adfe4d92a9eeda6834fb090034c"
    
    struct Auth {
        static var accountId = 0
        static var requestToken = ""
        static var sessionId = ""
    }
    
    enum EndPoints {
        static let baseUrl = "https://api.themoviedb.org/3"
        static let apiKeyParam = "?api_key=\(Client.apiKey)"
        
        case getToken
        case login
        case getSessionId
        case getHomeMovies
        case getDetailsMovie
        case getWatchList
        case getFeaturedMovies
        
        var stringValue: String {
            switch self {
            case .getToken: return
            EndPoints.baseUrl + "/authentication/token/new" + EndPoints.apiKeyParam
                
            case .login: return
                EndPoints.baseUrl + "/authentication/token/validate_with_login" + EndPoints.apiKeyParam
                
            case .getSessionId: return
                EndPoints.baseUrl + "/authentication/session/new" + EndPoints.apiKeyParam
                
            case .getHomeMovies: return
                EndPoints.baseUrl + "/acount/\(Auth.accountId)/watchlist/movies" + EndPoints.apiKeyParam + "&session_id=\(Auth.sessionId)"
                
            case .getDetailsMovie: return
                EndPoints.baseUrl + "/acount/\(Auth.accountId)/watchlist/movies" + EndPoints.apiKeyParam + "&session_id=\(Auth.sessionId)"
                
            case .getWatchList: return
                EndPoints.baseUrl + "/acount/\(Auth.accountId)/watchlist/movies" + EndPoints.apiKeyParam + "&session_id=\(Auth.sessionId)"
                
            case .getFeaturedMovies: return
                EndPoints.baseUrl + "/acount/\(Auth.accountId)/watchlist/movies" + EndPoints.apiKeyParam + "&session_id=\(Auth.sessionId)"
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
}
