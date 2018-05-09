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
    
    @IBOutlet weak var imageViewTopConstraint: NSLayoutConstraint?
    
    var hero: Hero?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageViewTopConstraint?.constant += UIScreen.main.bounds.size.height
        view.layoutIfNeeded()
        
        if let hero = hero {
            configureOutlets(with: hero)
        }
        
        heroImageView?.layer.cornerRadius = 3
        heroImageView?.clipsToBounds = true
        
        imageViewTopConstraint?.constant = 30
        UIView.animate(withDuration: 0.6) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func configureOutlets(with hero: Hero) {
        title = hero.name
        heroImageView?.sd_setImage(with: URL(string: hero.imageURL), placeholderImage: #imageLiteral(resourceName: "no_image"))
        heroNameLabel?.text = hero.name
        heroDescriptionLabel?.text = hero.heroDescription.isEmpty ? "No hero description." : hero.heroDescription
    }
}
