//
//  SwifterService.swift
//  Twittermenti
//
//  Created by Angelique Babin on 15/04/2021.
//  Copyright © 2021 London App Brewery. All rights reserved.
//

import Foundation
import SwifteriOS

final class SwifterService {
    
    // MARK: - Properties
    
    var keyTwitterApi: String {
        return valueForAPIKey(named: Constants.twitterAPIKey)
    }

    var secretKeyTwitterApi: String {
        return valueForAPIKey(named: Constants.twitterAPISecretKey)
    }
    
    var swifter: Swifter {
        return Swifter(consumerKey: keyTwitterApi, consumerSecret: secretKeyTwitterApi)
    }
    
    // MARK: - Methods
    
    func searchTweet(using: String) {
        swifter.searchTweet(using: using, count: 100) { (results, metadata) in
            print(results)
        } failure: { (error) in
            print("There was an error with the Twitter API Request, \(error)")
        }
    }
}
