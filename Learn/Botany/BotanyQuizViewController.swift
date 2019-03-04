//
//  BotanyQuizViewController.swift
//  Learn
//
//  Created by Faateh Jarree on 3/2/19.
//  Copyright © 2019 Mani. All rights reserved.
//

import UIKit

class BotanyQuizViewController: UIViewController {

    private var questionsToAsk = botanyQuestions()
    private var currentAnswer: String?
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBAction func submitAnswerButtonTapped(_ sender: UIButton) {
        
        answerChoicesSegments.isUserInteractionEnabled = true
        answerChoicesSegments.tintColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        answerChoicesSegments.selectedSegmentIndex = UISegmentedControl.noSegment
        updateView()
    }
    
    @IBOutlet weak var questionNumber: UILabel!
    
    @IBOutlet weak var questionInformation: UITextView!
    
    @IBOutlet weak var answerChoicesSegments: UISegmentedControl!
    
    @IBAction func answerChoices(_ sender: UISegmentedControl) {
        
        if let answer = sender.titleForSegment(at: sender.selectedSegmentIndex) {
            
//            switch answer {
//
//            case "A": sender.tintColor = #colorLiteral(red: 0.9607843137, green: 0.1921568627, blue: 0.1490196078, alpha: 1)
//            case "B": sender.tintColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1); score += 1
//            case "C": sender.tintColor = #colorLiteral(red: 0.9607843137, green: 0.1921568627, blue: 0.1490196078, alpha: 1)
//            case "D": sender.tintColor = #colorLiteral(red: 0.9607843137, green: 0.1921568627, blue: 0.1490196078, alpha: 1)
//            default: break
//
//            }
            if (answer == currentAnswer) {
                sender.tintColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1); score += 1
            } else {
                sender.tintColor = #colorLiteral(red: 0.9607843137, green: 0.1921568627, blue: 0.1490196078, alpha: 1)
            }
            answerChoicesSegments.isUserInteractionEnabled = false
        }
        
    }
    
    private var score = 0 {
        didSet {
            updateScoreLabel()
        }
    }
    
    func updateScoreLabel() {
        let attributes: [NSAttributedString.Key:Any] = [
            .strokeWidth: 8.0,
            .strokeColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        ]
        let attributedString = NSAttributedString(string: "Score: \(score)", attributes: attributes)
        scoreLabel.attributedText = attributedString
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        scoreLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        updateView()
    }

    func updateView() {
        if questionsToAsk.questionArray.count > 0 {
            let questionToShow = questionsToAsk.questionArray.remove(at: 0)
            questionNumber.text = String(questionToShow.questionNumber)
            questionInformation.text = questionToShow.question
            currentAnswer = questionToShow.answer
        }
        
    }
    
}

extension Int {
    var arc4Random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
