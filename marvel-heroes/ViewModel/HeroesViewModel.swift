//
//  HeroesViewModel.swift
//  marvel-heroes
//
//  Created by Laurent Meert on 08/05/2018.
//  Copyright © 2018 Laurent Meert. All rights reserved.
//

import Foundation

class HeroesViewModel {
    
    //MARK: Properties
    
    /// The heroes respective offset for API pagination
    private var heroesOffsets: [String: Int] = [
        Constants.allHeroesOffsetKey: 0,
        Constants.searchHeroesOffsetKey: 0
    ]
    
    /// The stored list of heroes
    private var heroes = [Hero]()
    
    /// The stored list of searched heroes
    private var searchHeroes = [Hero]()
    
    /// The current search filter, if any
    private var searchFilter: String?
    
    /// The limit of results to fetch
    private let limit = 20
    
    /**
     Fetches heroes.
     - parameter filter: The filter text applied in case of search.
     - parameter isCanceledSearch: If the search was just canceled.
     */
    func fetchHeroes(filter: String? = nil,
                     canceledSearch isCanceledSearch: Bool = false,
                     completion: @escaping HeroesCompletion) {
        
        /// Reload existing popular movies if search was canceled
        if isCanceledSearch {
            print("Search was canceled. Reloading data with existing popular movies.")
            completion(heroes)
            return
        }
        
        /// Define request type, page key and returned movies
        var requestType: APIHeroesRequestType = .all
        var offsetKey = Constants.allHeroesOffsetKey
        var returnedHeroes = heroes
        
        if let filter = filter {
            
            /// Clean up search storage if search text (query) has changed
            if let searchFilter = searchFilter {
                if searchFilter != filter {
                    print("Search filter has changed. Resetting pagination and results storage.")
                    searchHeroes.removeAll()
                    heroesOffsets[Constants.searchHeroesOffsetKey] = 0
                    completion(searchHeroes)
                } else {
                    print("Search keyword is the same as before. Reloading existing search data.")
                    completion(searchHeroes)
                    return
                }
            }
            
            requestType = .search(filter)
            offsetKey = Constants.searchHeroesOffsetKey
            returnedHeroes = searchHeroes
        }
        
        searchFilter = filter
        
        guard let offset = heroesOffsets[offsetKey] else {
            print("Could not find page for key \(offsetKey)")
            return
        }
        
        APIManager.shared.fetchHeroes(withRequestType: requestType, forOffset: offset) { (heroes) in
            
            guard let heroes = heroes else {
                completion(nil)
                return
            }
            
            /// Add new heroes to stored property
            for hero in heroes {
                returnedHeroes.append(hero)
            }
            
            if filter == nil {
                self.heroes = returnedHeroes
            } else {
                self.searchHeroes = returnedHeroes
            }
            
            print("Finished fetching heroes for offset \(offset) (\(filter == nil ? "All" : "Search"))")
            self.heroesOffsets[offsetKey] = offset + self.limit
            completion(returnedHeroes)
        }
    }
}
