//
//  ViewController.swift
//  Twittermenti
//
//  Created by Angela Yu on 17/07/2019.
//  Copyright ÂŠ 2019 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sentimentLabel: UILabel!
    
    // MARK: - Properties
    
    private let swifterService = SwifterService()

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
        swifterService.fetchTweets(using: query) { (success, sentimentScore) in
            if success {
                guard let sentimentScore = sentimentScore else { return }
                self.updateUI(with: sentimentScore)
            } else {
                print("There is an error with search Tweet.")
                return
            }
        }
        textField.text = String()
    }
    
    private func updateUI(with sentimentScore: Int) {
        switch sentimentScore {
        case 20..<1000:
            self.sentimentLabel.text = "đ"
        case 10..<20:
            self.sentimentLabel.text = "đ"
        case 1..<10:
            self.sentimentLabel.text = "đ"
        case 0:
            self.sentimentLabel.text = "đ"
        case -10..<(0):
            self.sentimentLabel.text = "âšī¸"
        case -20..<(-10):
            self.sentimentLabel.text = "đĄ"
        default:
            self.sentimentLabel.text = "đ¤Ž"
        }
        print("SentimentScore - display : \(sentimentScore)")
    }
}
