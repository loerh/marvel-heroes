//
//  DetailViewController.swift
//  marvel-heroes
//
//  Created by Laurent Meert on 08/05/2018.
//  Copyright © 2018 Laurent Meert. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var heroImageView: UIImageView?
    
    @IBOutlet weak var heroNameLabel: UILabel?
    
    @IBOutlet weak var heroDescriptionLabel: UILabel?
    
    var hero: Hero?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let hero = hero {
            configureOutlets(with: hero)
        }
    }
    
    private func configureOutlets(with hero: Hero) {
        title = hero.name
        heroImageView?.sd_setImage(with: URL(string: hero.imageURL), placeholderImage: #imageLiteral(resourceName: "no_image"))
        heroNameLabel?.text = hero.name
        heroDescriptionLabel?.text = hero.heroDescription
    }
}
