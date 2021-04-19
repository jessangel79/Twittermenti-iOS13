//
//  SentimentType.swift
//  Twittermenti
//
//  Created by Angelique Babin on 16/04/2021.
//  Copyright © 2021 London App Brewery. All rights reserved.
//

import Foundation

enum SentimentType: String {
    case positif = "Pos"
    case negatif = "Neg"
    case neutral = "Neutral"
    
//    func sentiment() -> String {
//        return self.rawValue
//    }
    
//    func getSentimentScore(for sentiment: String) -> Int {
//        var sentimentScore = 0
//        guard let sentimentType = SentimentType(rawValue: sentiment) else { return 0 }
//        if sentimentType == .positif {
//            sentimentScore += 1
//        } else if sentimentType == .negatif {
//            sentimentScore -= 1
//        }
//        return sentimentScore
//    }
}
