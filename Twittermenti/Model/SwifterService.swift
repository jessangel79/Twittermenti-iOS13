//
//  SwifterService.swift
//  Twittermenti
//
//  Created by Angelique Babin on 15/04/2021.
//  Copyright © 2021 London App Brewery. All rights reserved.
//

import Foundation
import SwifteriOS
import CoreML
import SwiftyJSON

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
    
    let sentimentClassifer = try? TweetSentimentClassifier(configuration: MLModelConfiguration())
    
    // MARK: - Methods
    
    func searchTweet(using: String) {
        swifter.searchTweet(using: using, lang: Constants.english, count: 100, tweetMode: .extended) { (results, metadata) in
            var tweets = [String]()
            for index in 0..<100 {
                guard let tweet = results[index][Constants.fullText].string else { return }
                tweets.append(tweet)
            }
            print(tweets.count)
        } failure: { (error) in
            print("There was an error with the Twitter API Request, \(error)")
        }
    }
    
    /// test of prediction (Neg-Pos-Neutral)
    func getPrediction() {
        do {
            let prediction = try sentimentClassifer?.prediction(text: "Apple is he best company !")
            print(prediction?.label ?? "error of label prediction")
        } catch {
            print("error of prediction : \(error.localizedDescription)")
        }
    }
}
