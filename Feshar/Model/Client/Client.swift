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
        static var parameter = ""
    }
    
    enum EndPoints {
        static let baseUrl = "https://api.themoviedb.org/3"
        static let apiKeyParam = "?api_key=\(Client.apiKey)"
        
        case getToken
        case login
        case getSessionId
        case getWatchList
        case getFeaturedMovies
        case getPopularMovies
        case getLatestMovies
        case getNowPlaying
        case getAllMovies
        case addToWatchList
        case getGenres
        case getDetails
        case getCredits
        case getMovieDescover
        case getTVDiscover
        
        var stringValue: String {
            switch self {
            case .getToken: return
            EndPoints.baseUrl + "/authentication/token/new" + EndPoints.apiKeyParam
                
            case .login: return
                EndPoints.baseUrl + "/authentication/token/validate_with_login" + EndPoints.apiKeyParam
                
            case .getSessionId: return
                EndPoints.baseUrl + "/authentication/session/new" + EndPoints.apiKeyParam
                
            case .getWatchList: return
                EndPoints.baseUrl + "/account/\(Auth.accountId)/watchlist/movies" + EndPoints.apiKeyParam + "&session_id=\(Auth.sessionId)"
                
            case .getFeaturedMovies: return
                EndPoints.baseUrl + "/account/\(Auth.accountId)/watchlist/movies" + EndPoints.apiKeyParam + "&session_id=\(Auth.sessionId)"
                
            case .getPopularMovies: return
                EndPoints.baseUrl + "/movie/popular" + EndPoints.apiKeyParam
                
            case .getLatestMovies: return
                EndPoints.baseUrl + "/movie/latest" + EndPoints.apiKeyParam
                
            case .getNowPlaying: return
                EndPoints.baseUrl + "/movie/now_playing" + EndPoints.apiKeyParam
                
            case .getAllMovies: return
                EndPoints.baseUrl + "/discover/movie" + EndPoints.apiKeyParam
                
            case .addToWatchList: return
                EndPoints.baseUrl + "/account/\(Auth.accountId)/watchlist" + EndPoints.apiKeyParam + "&session_id=\(Auth.sessionId)"
                
            case .getGenres: return
                EndPoints.baseUrl + "/genre/movie/list" + EndPoints.apiKeyParam
                
            case .getDetails: return
                EndPoints.baseUrl + "/movie/\(Auth.parameter)" + EndPoints.apiKeyParam
                
            case .getCredits: return
                EndPoints.baseUrl + "/movie/\(Auth.parameter)/credits" + EndPoints.apiKeyParam
            case .getMovieDescover: return
                EndPoints.baseUrl + "/discover/movie" + EndPoints.apiKeyParam
            case .getTVDiscover: return
                EndPoints.baseUrl + "/discover/tv" + EndPoints.apiKeyParam
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
}
