//
//  HeroTableViewCell.swift
//  marvel-heroes
//
//  Created by Laurent Meert on 08/05/2018.
//  Copyright © 2018 Laurent Meert. All rights reserved.
//

import UIKit
import SDWebImage

/**
 The table view cell for a hero.
 */
class HeroTableViewCell: UITableViewCell {
    
    //MARK: Properties
    
    /// The cell identifier
    static let identifier = "HeroTableViewCell"
    
    //MARK: Outlets
    
    /// The hero name label
    @IBOutlet weak var heroNameLabel: UILabel?
    
    /// The hero thumbnail image view
    @IBOutlet weak var thumbnailImageView: UIImageView?
    
    //MARK: Configuration
    
    /**
     Configures the cell using metadata.
     - parameter hero: The Hero object to use for this cell.
     */
    func configure(with hero: Hero) {
        
        heroNameLabel?.text = hero.name
        thumbnailImageView?.sd_setImage(with: URL(string: hero.imageURL), placeholderImage: #imageLiteral(resourceName: "no_image"))
    }
    
}
