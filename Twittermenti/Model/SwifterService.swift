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
    private let tweetCount = 100
//    private var sentimentScore: Int = 0

    // MARK: - Methods
    
    func fetchTweets(using searchText: String, completionHandler: @escaping (Bool, Int?) -> Void) {
        swifter.searchTweet(using: searchText, lang: Constants.english, count: tweetCount, tweetMode: .extended) { (results, metadata) in
            var tweets = [TweetSentimentClassifierInput]()

            for index in 0..<self.tweetCount {
                guard let tweet = results[index][Constants.fullText].string else { return }
                let tweetForclassification = TweetSentimentClassifierInput(text: tweet)
                tweets.append(tweetForclassification)
            }
            
            guard let sentimentScore = self.makePredictions(with: tweets) else { return }
            completionHandler(true, sentimentScore)
            
//            guard let getPredictions = self.makePredictions(with: tweets) else { return }
//            self.sentimentScore = getPredictions
//            completionHandler(true, self.sentimentScore)

        } failure: { (error) in
            print("There was an error with the Twitter API Request, \(error)")
        }
    }
    
    private func makePredictions(with tweets: [TweetSentimentClassifierInput]) -> Int? {
//        sentimentScore = 0
        var sentimentScore = 0
        do {
            guard let predictions = try sentimentClassifer?.predictions(inputs: tweets) else { return nil }
            for pred in predictions {
                let predLabel = pred.label
                getSentimentScore(predLabel, &sentimentScore)
//                sentimentScore = getSentimentScore(for: pred.label)
            }
        } catch {
            print("There was an error with macking a prediction, \(error)")
        }
        return sentimentScore
    }
    
    private func getSentimentScore(_ predLabel: String, _ sentimentScore: inout Int) {
        if predLabel == SentimentType.positif.rawValue {
            sentimentScore += 1
        } else if predLabel == SentimentType.negatif.rawValue {
            sentimentScore -= 1
        }
    }
    
//    private func getSentimentScore(for sentiment: String) -> Int {
//        if sentiment == SentimentType.positif.rawValue {
//            sentimentScore += 1
//        } else if sentiment == SentimentType.negatif.rawValue {
//            sentimentScore -= 1
//        }
//        return sentimentScore
//    }
}
