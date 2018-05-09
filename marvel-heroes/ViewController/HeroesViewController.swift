//
//  ViewController.swift
//  marvel-heroes
//
//  Created by Laurent Meert on 08/05/2018.
//  Copyright © 2018 Laurent Meert. All rights reserved.
//

import UIKit

class HeroesViewController: UIViewController {

    //MARK: Outlets
    
    /// The table view displaying heroes
    @IBOutlet weak var heroesTableView: HeroesTableView?
    
    /// The search bar
    @IBOutlet weak var searchBar: UISearchBar?
    
    //MARK: Properties
    
    /// The view model for heroes
    private let heroesViewModel = HeroesViewModel()
    
    //MARK: App Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        setupNavigationImage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Marvel's Heroes"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: self)
        
        if segue.identifier == "detail",
            let detailVC = segue.destination as? DetailViewController {
            detailVC.hero = heroesTableView?.selectedHero
            title = ""
        }
    }
    
    //MARK: Fetch
    
    /**
     Fetches data and feeds it into table view.
     */
    private func loadData() {
        
        var filter: String?
        if let searchText = searchBar?.text, !searchText.isEmpty {
            filter = searchText
        }
        
        heroesViewModel.fetchHeroes(filterText: filter) { (heroes) in
            if let heroes = heroes {
                self.heroesTableView?.setup(withHeroes: heroes, lastItemDelegate: self)
            }
        }
    }
    
    //MARK: Setup
    
    private func setupNavigationImage() {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        imageView.image = #imageLiteral(resourceName: "marvel_landscape")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        navigationItem.titleView = imageView
    }
}

extension HeroesViewController: TableViewLastItemDelegate {
    
    //MARK: Table View Last Item Delegate Functions
    
    /**
     When the table view has reached the last item.
     */
    func didReachLastItem() {
        loadData()
    }
}

extension HeroesViewController: UISearchBarDelegate {
    
    //MARK: Search Bar Delegate Functions
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        heroesTableView?.setSearchMode(enabled: !searchText.isEmpty)
        
        if searchText.isEmpty {
            heroesViewModel.fetchHeroes(canceledSearch: true) { (heroes) in
                if let heroes = heroes {
                    self.heroesTableView?.setContentOffset(.zero, animated: false)
                    self.heroesTableView?.setup(withHeroes: heroes, lastItemDelegate: self)
                }
            }
        } else {
            loadData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        
        /// Don't reload data for nothing if it was already in all heroes mode
        if searchBar.text?.isEmpty ?? true {
            return
        }
        
        searchBar.text = ""
        heroesTableView?.setSearchMode(enabled: false)
        
        heroesViewModel.fetchHeroes(canceledSearch: true) { (heroes) in
            if let heroes = heroes {
                self.heroesTableView?.setContentOffset(.zero, animated: false)
                self.heroesTableView?.setup(withHeroes: heroes, lastItemDelegate: self)
            }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

