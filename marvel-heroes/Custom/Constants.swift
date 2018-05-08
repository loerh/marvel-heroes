//
//  Constants.swift
//  marvel-heroes
//
//  Created by Laurent Meert on 08/05/2018.
//  Copyright © 2018 Laurent Meert. All rights reserved.
//

import Foundation

/**
 The list of constants for the overall application.
 */
struct Constants {
    
    /// The API base URL
    static let apiBaseURL = "http://gateway.marvel.com/v1/public/"
    
    /// The API key for marvel API
    static let marvelAPIKey = "d7bc7f6329f86cc7b0eb1938121df01c"
    
    /// The offset key for all heroes
    static let allHeroesOffsetKey = "heroesOffsetKey"
    
    /// The offset key for searched heroes
    static let searchHeroesOffsetKey = "searchHeroesOffsetKey"
}

/// A type alias for heroes completion
typealias HeroesCompletion = ([Hero]?) -> Void
