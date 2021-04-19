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
    
    private var keyTwitterApi: String {
        return valueForAPIKey(named: Constants.twitterAPIKey)
    }

    private var secretKeyTwitterApi: String {
        return valueForAPIKey(named: Constants.twitterAPISecretKey)
    }
    
    private var swifter: Swifter {
        return Swifter(consumerKey: keyTwitterApi, consumerSecret: secretKeyTwitterApi)
    }
    
    private let sentimentClassifer = try? TweetSentimentClassifier(configuration: MLModelConfiguration())
    private var sentimentScore: Int = 0

    // MARK: - Methods
    
    func searchTweet(using word: String, completionHandler: @escaping (Bool, Int?) -> Void) {
        swifter.searchTweet(using: word, lang: Constants.english, count: 100, tweetMode: .extended) { (results, metadata) in
            var tweets = [TweetSentimentClassifierInput]()

            for index in 0..<100 {
                guard let tweet = results[index][Constants.fullText].string else { return }
                let tweetForclassification = TweetSentimentClassifierInput(text: tweet)
                tweets.append(tweetForclassification)
            }
            
            self.sentimentScore = self.getPredictions(of: tweets)
            completionHandler(true, self.sentimentScore)

        } failure: { (error) in
            print("There was an error with the Twitter API Request, \(error)")
        }
    }
    
    private func getPredictions(of tweets: [TweetSentimentClassifierInput]) -> Int {
        sentimentScore = 0
        do {
            guard let predictions = try sentimentClassifer?.predictions(inputs: tweets) else { return 0 }
            for pred in predictions {
                // Counter of sentiment
                sentimentScore = getSentimentScore(for: pred.label)
            }
        } catch {
            print("There was an error with macking a prediction, \(error)")
        }
        return sentimentScore
    }
    
    private func getSentimentScore(for sentiment: String) -> Int {
        if sentiment == SentimentType.positif.rawValue {
            sentimentScore += 1
        } else if sentiment == SentimentType.negatif.rawValue {
            sentimentScore -= 1
        }
        return sentimentScore
    }
}
