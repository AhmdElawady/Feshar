//
//  Details.swift
//  Feshar
//
//  Created by Awady on 4/11/20.
//  Copyright © 2020 Awady. All rights reserved.
//

import Foundation

class Details {
    
    class func getDetails(movieId: Int, completion: @escaping (DetailsResponse?, Error?) -> Void) {
        Client.Auth.parameter = movieId
        let task = URLSession.shared.dataTask(with: Client.EndPoints.getDetails.url) { (data, response, error) in
            guard let data = data else {
                completion(nil, error)
                return
            }
            do {
                let decoder = JSONDecoder()
                let responseObject = try decoder.decode(DetailsResponse.self, from: data)
                completion(responseObject, nil)
            } catch {
                completion(nil, error)
            }
        }
        task.resume()
    }
}
