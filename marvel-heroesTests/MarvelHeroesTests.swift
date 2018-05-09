//
//  marvel_heroesTests.swift
//  marvel-heroesTests
//
//  Created by Laurent Meert on 08/05/2018.
//  Copyright © 2018 Laurent Meert. All rights reserved.
//

import XCTest
import SwiftyJSON
@testable import marvel_heroes

class MarvelHeroesTests: XCTestCase {
    
    func testHeroesParsing() {
        
        guard let path = Bundle.main.path(forResource: "HeroesSample", ofType: "json") else {
            XCTFail()
            return
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let json = try JSON(data: data)
            
            guard let results = json["data"]["results"].array else {
                XCTFail()
                return
            }
            
            for result in results {
                XCTAssertNotNil(Hero.parseJSON(with: result))
            }
            
        } catch {
            XCTFail("\(error)")
        }
    }
    
    func testFailingParsing() {
        
        guard let path = Bundle.main.path(forResource: "HeroesSampleMissingFields", ofType: "json") else {
            XCTFail()
            return
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let json = try JSON(data: data)
            
            guard let results = json["data"]["results"].array else {
                XCTFail()
                return
            }
            
            for result in results {
                XCTAssertNil(Hero.parseJSON(with: result))
            }
            
        } catch {
            XCTFail("\(error)")
        }
    }
    
    func testHeroesViewModel() {
        let viewModel = HeroesViewModel()
        viewModel.fetchHeroes { (heroes) in
            XCTAssertNotNil(heroes)
        }
    }
    
    func testHeroesAPI() {
        let expect = expectation(description: "API Heroes Test")
        APIManager.shared.fetchHeroes(withRequestType: .all, forOffset: 0) { (movies) in
            XCTAssertNotNil(movies)
            expect.fulfill()
        }
        waitForExpectations(timeout: 15, handler: nil)
    }
    
    func testPerformanceHeroesAPIResponse() {
        
        var flag = 0
        let expect = expectation(description: "API Response performance")
        self.measure {
            
            APIManager.shared.fetchHeroes(withRequestType: .all, forOffset: 0) { (heroes) in
                flag += 1
                print("FLAG: \(flag)")
                XCTAssertNotNil(heroes)
                if flag == 10 { expect.fulfill() }
            }
        }
        
        waitForExpectations(timeout: 15, handler: nil)
    }
    
}
