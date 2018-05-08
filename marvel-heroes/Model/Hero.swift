//
//  Hero.swift
//  marvel-heroes
//
//  Created by Laurent Meert on 08/05/2018.
//  Copyright © 2018 Laurent Meert. All rights reserved.
//

import Foundation
import SwiftyJSON

/**
 The Hero struct model.
 */
struct Hero {

    /// The ID of this hero
    let id: Int
    
    /// The name of this hero
    let name: String
    
    /// The hero description
    let heroDescription: String
    
    /// The image thumbnail URL
    let imageURL: String
    
    /**
     Parses JSON object into a Hero object, if possible.
     - parameter json: The JSON object to convert.
     - returns: The converted Hero object, if any.
     */
    static func parseJSON(with json: JSON) -> Hero? {
        
        /// ID
        guard let id = json[HeroKey.id.rawValue].int else {
            print("Could not find an ID key when parsing Hero")
            return nil
        }
        
        /// Name
        guard let name = json[HeroKey.name.rawValue].string else {
            print("Could not find a name key when parsing Hero")
            return nil
        }
        
        /// Hero description
        guard let heroDescription = json[HeroKey.description.rawValue].string else {
            print("Could not find a description key when parsing Hero")
            return nil
        }
        
        /// Image URL
        guard let thumbnail = json[HeroKey.thumbnail.rawValue].dictionary else {
            print("Could not find a thumbnail key when parsing Hero")
            return nil
        }
        
        guard let thumbnailPath = thumbnail[HeroKey.thumbnailPath.rawValue]?.string else {
            print("Could not find a thumbnail path key when parsing Hero")
            return nil
        }
        
        guard let thumbnailExtension = thumbnail[HeroKey.thumbnailExtension.rawValue]?.string else {
            print("Could not find a thumbnail extension key when parsing Hero")
            return nil
        }
        
        return Hero(id: id, name: name, heroDescription: heroDescription, imageURL: "\(thumbnailPath).\(thumbnailExtension)")
    }
}

/**
 The list of keys to parse JSON object into a Hero object.
 */
enum HeroKey: String {
    case id
    case name
    case description
    case thumbnail
    case thumbnailPath = "path"
    case thumbnailExtension = "extension"
}
