//
//  ViewController.swift
//  Twittermenti
//
//  Created by Angela Yu on 17/07/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit
//import SwifteriOS

class ViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sentimentLabel: UILabel!
    
    // MARK: - Properties
    
    private let swifterService = SwifterService()
    private var sentimentScore: Int?
    private var tweets: [TweetSentimentClassifierInput]?
//    var tweets: [TweetSentimentClassifierInput]?

    // MARK: - Actions

    @IBAction func predictPressed(_ sender: Any) {
        searchTweet()
//        DispatchQueue.main.async {
//            guard let tweets = self.tweets else { return }
//            self.getPredictions(with: tweets)
//        }

    }
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        searchTweet()
    }
    
    // MARK: - Methods

//    private func getScore(_ query: String) {
//        DispatchQueue.main.async {
//            self.sentimentScore = self.swifterService.searchTweet(using: query) // @Apple #blessed
//        }
        
//        sentimentScore = swifterService.searchTweet(using: query) // @Apple #blessed
        
//        let tweetsSearched = swifterService.searchTweet(using: query)
//        tweets = tweetsSearched
//        sentimentScore = swifterService.getPredictions(of: tweetsSearched ?? [TweetSentimentClassifierInput]() )
        
//        DispatchQueue.main.async {
//            guard let sentimentScore = self.sentimentScore else { return }
//            print("in getScore \(self.sentimentScore ?? 000)")
//            switch sentimentScore {
//            case 20..<150:
//                self.sentimentLabel.text = "Positif" //🙂
//            case -100..<0:
//                self.sentimentLabel.text = "Negatif" //☹️
//            default:
//                self.sentimentLabel.text = "Neutre"//😐
//            }
//        }
//    }
    
    private func searchTweet() {
//        swifterService.searchTweet(using: query) // @Apple #blessed
//        DispatchQueue.main.async {
//            self.sentimentScore = self.swifterService.searchTweet(using: query) // @Apple #blessed
//            print(self.sentimentScore)
//        }
        guard let query = textField.text, !query.isEmpty else { return } //
//        getScore(query)
//        sentimentScore = swifterService.searchTweet(using: query) // @Apple #blessed
        swifterService.searchTweet(using: query) { (success, sentimentScore) in // tweets
            if success {
//                print("in getScore \(String(describing: sentimentScore))")
                
                // OK
//                guard let tweets = tweets else { return }
//                self.tweets = tweets
                
                guard let sentimentScore = sentimentScore else { return }
                self.sentimentScore = sentimentScore
                self.diplayScore()
//                print("in searchTweet - sentimentScore \(String(describing: tweets))")
//                print("in getScore - self.sentimentScore \(String(describing: self.tweets))")

//                switch sentimentScore {
//                case 20..<150:
//                    self.sentimentLabel.text = "Positif" //🙂
//                case -100..<0:
//                    self.sentimentLabel.text = "Negatif" //☹️
//                default:
//                    self.sentimentLabel.text = "Neutre"//😐
//                }
            } else {
                print("error !!!")
            }
        }
        textField.text = String()
        
//        DispatchQueue.main.async {
//            print("in getScore \(self.sentimentScore ?? 000)")
//            guard let sentimentScore = self.sentimentScore else { return }
//            switch sentimentScore {
//            case 20..<150:
//                self.sentimentLabel.text = "Positif" //🙂
//            case -100..<0:
//                self.sentimentLabel.text = "Negatif" //☹️
//            default:
//                self.sentimentLabel.text = "Neutre"//😐
//            }
//        }
    }
    
//    private func getPredictions(with tweets: [TweetSentimentClassifierInput]) {
// //        sentimentScore = swifterService.getScore()
//
//        sentimentScore = swifterService.getPredictions(of: tweets)
//        print(sentimentScore as Any)
// //        sentimentLabel.text = String(format: "%d", sentimentScore ?? "err")
//        print("in getScore \(self.sentimentScore as Any)")
//        guard let sentimentScore = self.sentimentScore else { return }
//        switch sentimentScore {
//        case 20..<150:
//            self.sentimentLabel.text = "Positif" //🙂
//        case -100..<0:
//            self.sentimentLabel.text = "Negatif" //☹️
//        default:
//            self.sentimentLabel.text = "Neutre"//😐
//        }
//    }
    
//    private func getPredictions(with tweets: [TweetSentimentClassifierInput]) {
//        sentimentScore = swifterService.getPredictions(of: tweets)
//        print(sentimentScore as Any)
// //        sentimentLabel.text = String(format: "%d", sentimentScore ?? "err")
//        print("in getScore \(self.sentimentScore as Any)")
//        guard let sentimentScore = self.sentimentScore else { return }
//        switch sentimentScore {
//        case 20..<150:
//            self.sentimentLabel.text = "Positif" //🙂
//        case -100..<0:
//            self.sentimentLabel.text = "Negatif" //☹️
//        default:
//            self.sentimentLabel.text = "Neutre"//😐
//        }
//    }
    
    func diplayScore() {
        print(sentimentScore as Any)
        print("in getScore \(self.sentimentScore as Any)")
        guard let sentimentScore = self.sentimentScore else { return }
        switch sentimentScore {
        case 5..<1000:
            self.sentimentLabel.text = "🙂"
        case -1000..<(-3):
            self.sentimentLabel.text = "☹️"
        default:
            self.sentimentLabel.text = "😐"
        }
    }
}
