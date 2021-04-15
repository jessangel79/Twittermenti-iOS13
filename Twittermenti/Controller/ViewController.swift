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
    
    // MARK: - Actions

    @IBAction func predictPressed(_ sender: Any) {
    
    }
    
    // MARK: - Properties
    
    private let swifterService = SwifterService()
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
//        getPrediction()
        searchTweet()
    }
    
    // MARK: - Methods
    
    private func searchTweet() {
        swifterService.searchTweet(using: "@Apple")
    }
    
    private func getPrediction() {
        swifterService.getPrediction()
    }

}
