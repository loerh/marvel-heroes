//
//  APIManager.swift
//  marvel-heroes
//
//  Created by Laurent Meert on 08/05/2018.
//  Copyright © 2018 Laurent Meert. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import CryptoSwift

/**
 A manager for API calls.
 */
class APIManager {
    
    /// The shared instance
    static let shared = APIManager()
    
    /**
     Fetches Heroes.
     - parameter offset: The offset to use for this request.
     */
    func fetchHeroes(withRequestType requestType: APIHeroesRequestType,
                     forOffset offset: Int,
                     completion: @escaping HeroesCompletion) {
        
        let timestamp = 1
        let hash = "\(timestamp)c1c1642e70553e26fe3c2e95af7e70535cf022ff\(Constants.marvelAPIKey)".md5()
        
        // Define parameters
        var parameters: Parameters = [
            "apikey": Constants.marvelAPIKey,
            "offset": offset,
            "ts": timestamp,
            "hash": hash
        ]
        
        switch requestType {
        case .all:
            break
        case .search(let keyword):
            parameters["nameStartsWith"] = keyword
        }
        
        /// Fetch
        fetch(withAdditionalURL: "characters", parameters: parameters) { (json) in
            
            /// Make sure we have a JSON
            guard let json = json else {
                completion(nil)
                return
            }
            
            /// Extract results
            guard let results = json["data"]["results"].array else {
                print("Could not find results key in JSON.")
                completion(nil)
                return
            }
            
            /// Make sure we have at least 1 result
            guard results.count > 0 else {
                print("No more results found")
                completion(nil)
                return
            }
            
            var heroes = [Hero]()
            for result in results {
                if let hero = Hero.parseJSON(with: result) {
                    heroes.append(hero)
                }
            }
            
            completion(heroes)
        }
    }
    
    /**
     Fetches generically from the API.
     - parameter additionalURL: The additional URL to use after base URL.
     - parameter method: The HTTPMethod to use e.g. GET, POST, PUT, ... Defaults to GET.
     - parameter parameters: The list of parameters to use for this request. Defaults to nil.
     - parameter encoding: The type of encoding. Defaults to URLEncoding.default.
     - parameter headers: The HTTPHeadears to use, if any. Defaults to nil.
     - parameter completion: The completion handler that sends back the freshly initialised JSON object, if any.
     */
    private func fetch(withAdditionalURL additionalURL: String,
                       method: HTTPMethod = .get,
                       parameters: Parameters? = nil,
                       encoding: ParameterEncoding = URLEncoding.default,
                       headers: HTTPHeaders? = nil,
                       completion: @escaping (JSON?) -> Void) {
        
        let url = Constants.apiBaseURL + additionalURL
        
        Alamofire.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers).responseData { (dataResponse) in
            
            /// Make sure we've got data back
            guard let data = dataResponse.result.value else {
                print("Could not find any data for this request!")
                completion(nil)
                return
            }
            
            /// Initialise JSON Object
            do {
                let json = try JSON(data: data)
                completion(json)
            } catch {
                print(error)
                completion(nil)
            }
        }
    }
}

/**
 The type of heroes request with the API
 */
enum APIHeroesRequestType {
    
    /// All heroes
    case all
    
    /// Search heroes with search text
    case search(String)
}
