//
//  HeroesTableView.swift
//  marvel-heroes
//
//  Created by Laurent Meert on 08/05/2018.
//  Copyright © 2018 Laurent Meert. All rights reserved.
//

import UIKit

class HeroesTableView: UITableView {
    
    //MARK: Properties
    
    /// The showed list of heroes on the table view.
    private var heroes: [Hero]?
    
    /// The last item delegate
    private var lastItemDelegate: TableViewLastItemDelegate?
    
    /// The selected hero, if any
    var selectedHero: Hero?
    
    /// If search mode is currently enabled or disabled
    private var isSearching = false
    
    //MARK: Setup
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupFooterView()
    }
    
    /**
     Sets up the table view.
     - parameter movies: The list of movies to populate the table view.
     - parameter itemDelegate: The TableViewLastItemDelegate to use for callbacks.
     */
    func setup(withHeroes heroes: [Hero], lastItemDelegate: TableViewLastItemDelegate?) {
        
        delegate = self
        dataSource = self
        
        self.heroes = heroes
        self.lastItemDelegate = lastItemDelegate
        reloadData()
    }
    
    private func setupFooterView() {
        
        let footerView = Bundle.main.loadNibNamed(TableViewFooterView.nibName, owner: self, options: nil)?.first as? TableViewFooterView
        footerView?.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: 55)
        
        tableFooterView = footerView
    }
    
    /**
     Sets search mode enabled or disabled.
     - parameter isEnabled: If search mode should be enabled or disabled.
     */
    func setSearchMode(enabled isEnabled: Bool) {
        self.isSearching = isEnabled
    }
}

extension HeroesTableView: UITableViewDataSource {
    
    //MARK: Table View Data Source Functions
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HeroTableViewCell.identifier) as? HeroTableViewCell else {
            return UITableViewCell()
        }
        
        if let hero = heroes?[indexPath.row] {
            cell.configure(with: hero)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return heroes?.count ?? 0
    }
}

extension HeroesTableView: UITableViewDelegate {
    
    //MARK: Table View Delegate Functions
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedHero = heroes?[indexPath.row]
        if let topVC = UIApplication.topViewController() as? HeroesViewController {
            topVC.performSegue(withIdentifier: "detail", sender: topVC)
        }
        deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        /// Check if we have reached last item
        if indexPath.row == (heroes?.count ?? 0) - 1 {
            lastItemDelegate?.didReachLastItem()
        }
    }
}

/**
 The last item delegate for a table view.
 */
protocol TableViewLastItemDelegate {
    func didReachLastItem()
}
