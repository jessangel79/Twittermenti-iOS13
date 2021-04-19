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

    // MARK: - Actions

    @IBAction func predictPressed(_ sender: Any) {
        searchTweet()
    }
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Methods

    private func searchTweet() {
        guard let query = textField.text, !query.isEmpty else { return }
        swifterService.searchTweet(using: query) { (success, sentimentScore) in
            if success {
                guard let sentimentScore = sentimentScore else { return }
                self.sentimentScore = sentimentScore
                self.diplayScore()
            } else {
                print("There is an error with search Tweet.")
                return
            }
        }
        textField.text = String()
        }
    
    private func diplayScore() {
        guard let sentimentScore = self.sentimentScore else { return }
        switch sentimentScore {
        case 3..<1000:
            self.sentimentLabel.text = "🙂"
        case -1000..<(-3):
            self.sentimentLabel.text = "☹️"
        default:
            self.sentimentLabel.text = "😐"
        }
        print("SentimentScore - display : \(sentimentScore)")
    }
}
