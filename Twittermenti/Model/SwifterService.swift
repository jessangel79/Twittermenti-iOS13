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
    
//    init(sentimentScore: Int = 0) {
//        self.sentimentScore = sentimentScore
//    }
    
    // MARK: - Methods
    
//    func searchTweet(using word: String) -> [TweetSentimentClassifierInput]? {
//        var tweets = [TweetSentimentClassifierInput]()
//        swifter.searchTweet(using: word, lang: Constants.english, count: 100, tweetMode: .extended) { (results, metadata) in
// //            var tweets = [TweetSentimentClassifierInput]()
//
//            for index in 0..<100 {
//                guard let tweet = results[index][Constants.fullText].string else { return }
//                let tweetForclassification = TweetSentimentClassifierInput(text: tweet)
//                tweets.append(tweetForclassification)
//            }
// //            guard let getPredictions =  self.getPredictions(of: tweets) else { return }
// //            self.sentimentScore = getPredictions
//
//            self.sentimentScore = self.getPredictions(of: tweets)
//            print("in searchTweet after for - service \(self.sentimentScore as Any)")
//        } failure: { (error) in
//            print("There was an error with the Twitter API Request, \(error)")
//        }
//        print("in searchTweet - service \(sentimentScore as Any)")
//        print(tweets)
//        return tweets
//    }
    
    func searchTweet(using word: String, completionHandler: @escaping (Bool, Int?) -> Void) {
        swifter.searchTweet(using: word, lang: Constants.english, count: 100, tweetMode: .extended) { (results, metadata) in
            var tweets = [TweetSentimentClassifierInput]()

            for index in 0..<100 {
                guard let tweet = results[index][Constants.fullText].string else { return }
                let tweetForclassification = TweetSentimentClassifierInput(text: tweet)
                tweets.append(tweetForclassification)
            }
            
            self.sentimentScore = self.getPredictions(of: tweets)
//            guard let getPredictions =  self.getPredictions(of: tweets) else { return }
//            self.sentimentScore = getPredictions

//            let sentimentScore = self.getPredictions(of: tweets)
//            print("in searchTweet after for - service \(sentimentScore as Any)")
//            completionHandler(true, sentimentScore)
//            print("in searchTweet after for - service \(tweets)")
            completionHandler(true, self.sentimentScore)

        } failure: { (error) in
            print("There was an error with the Twitter API Request, \(error)")
        }
//        print("in searchTweet - service \(sentimentScore as Any)")
//        completionHandler(true, sentimentScore)
//        return sentimentScore
//        print(sentimentScore)
    }
    
//    func searchTweet(using word: String, completionHandler: @escaping (Bool, [TweetSentimentClassifierInput]?) -> Void) {
//        swifter.searchTweet(using: word, lang: Constants.english, count: 100, tweetMode: .extended) { (results, metadata) in
//            var tweets = [TweetSentimentClassifierInput]()
//
//            for index in 0..<100 {
//                guard let tweet = results[index][Constants.fullText].string else { return }
//                let tweetForclassification = TweetSentimentClassifierInput(text: tweet)
//                tweets.append(tweetForclassification)
//            }
// //            guard let getPredictions =  self.getPredictions(of: tweets) else { return }
// //            self.sentimentScore = getPredictions
//
// //            let sentimentScore = self.getPredictions(of: tweets)
// //            print("in searchTweet after for - service \(sentimentScore as Any)")
// //            completionHandler(true, sentimentScore)
// //            print("in searchTweet after for - service \(tweets)")
//            completionHandler(true, tweets)
//
//        } failure: { (error) in
//            print("There was an error with the Twitter API Request, \(error)")
//        }
// //        print("in searchTweet - service \(sentimentScore as Any)")
// //        completionHandler(true, sentimentScore)
// //        return sentimentScore
// //        print(sentimentScore)
//    }

//    func searchTweet(using word: String) -> Int? {
//        swifter.searchTweet(using: word, lang: Constants.english, count: 100, tweetMode: .extended) { (results, metadata) in
//            var tweets = [TweetSentimentClassifierInput]()
//
//            for index in 0..<100 {
//                guard let tweet = results[index][Constants.fullText].string else { return }
//                let tweetForclassification = TweetSentimentClassifierInput(text: tweet)
//                tweets.append(tweetForclassification)
//            }
// //            guard let getPredictions =  self.getPredictions(of: tweets) else { return }
// //            self.sentimentScore = getPredictions
//
//            self.sentimentScore = self.getPredictions(of: tweets)
//            print("in searchTweet after for - service \(self.sentimentScore as Any)")
//
//        } failure: { (error) in
//            print("There was an error with the Twitter API Request, \(error)")
//        }
//        print("in searchTweet - service \(sentimentScore as Any)")
//        return sentimentScore
// //        print(sentimentScore)
//    }
    
    // / test of predictions (Neg-Pos-Neutral)
//    func getPredictions(of tweets: [TweetSentimentClassifierInput]) -> Int { //  -> Int?
//        sentimentScore = 0
//        do {
//            guard let predictions = try sentimentClassifer?.predictions(inputs: tweets) else { return 000 }
//            for pred in predictions {
// //                print(pred.label)
//                // Counter of sentiment
// //                sentimentScore = getSentimentScore(for: pred.label)
//                sentimentScore = getSentimentScore(for: pred.label)
//            }
//        } catch {
//            print("There was an error with mackig a prediction, \(error)")
//        }
// //        print("in getPredictions 2 - service \(sentimentScore as Any)")
//        print("in getPredictions - service \(sentimentScore)")
//        return sentimentScore
//    }
    
    private func getPredictions(of tweets: [TweetSentimentClassifierInput]) -> Int { //  -> Int?
        sentimentScore = 0
        do {
            guard let predictions = try sentimentClassifer?.predictions(inputs: tweets) else { return 000 }
            for pred in predictions {
//                print(pred.label)
                // Counter of sentiment
//                sentimentScore = getSentimentScore(for: pred.label)
                sentimentScore = getSentimentScore(for: pred.label)
            }
        } catch {
            print("There was an error with mackig a prediction, \(error)")
        }
//        print("in getPredictions 2 - service \(sentimentScore as Any)")
        print("in getPredictions - service \(sentimentScore)")
        return sentimentScore
    }
    
    private func getSentimentScore(for sentiment: String) -> Int { //  -> Int
//        guard var sentimentScore = sentimentScore else { return }
        if sentiment == SentimentType.positif.rawValue {
            sentimentScore += 1
        } else if sentiment == SentimentType.negatif.rawValue {
            sentimentScore -= 1
        }
        return sentimentScore
    }
}
