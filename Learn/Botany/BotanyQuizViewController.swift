//
//  BotanyQuizViewController.swift
//  Learn
//
//  Created by Faateh Jarree on 3/2/19.
//  Copyright © 2019 Mani. All rights reserved.
//

import UIKit
import Firebase


class BotanyQuizViewController: UIViewController {
    
    //Firebase DB ref
    var ref: DatabaseReference?
    
    private var questionsToAsk = botanyQuestions()
    private var currentAnswer: String?
    
    @IBOutlet weak var quizEndScoreLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var questionNumber: UILabel!
    @IBOutlet weak var questionInformation: UITextView!
    @IBOutlet weak var answerChoicesSegments: UISegmentedControl!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var submitResultButtonLabel: UIButton!
    
    
    func gameOver(){
        //store the score in UserDefaults
        let defaults = UserDefaults.standard
        let kidName = defaults.value(forKey: "CurrentKid") as! String?
        defaults.set(score, forKey: "BotanyLastScore"+(kidName ?? ""))
        
        if let userID = Auth.auth().currentUser?.uid, let kidName = defaults.value(forKey: "CurrentKid") as! String?{
            self.ref!.child("score").child(userID).child(kidName).observeSingleEvent(of: .value, with: { (snapshot) in
                if let s = snapshot.childSnapshot(forPath: "BotanyScore").value{
                    
                    if let firebaseScore = s as? Int {
                        if firebaseScore < self.score{
                        self.ref!.child("score").child(userID).child(kidName).updateChildValues(["BotanyScore": self.score])
                        }
                    } else {
                        self.ref!.child("score").child(userID).child(kidName).updateChildValues(["BotanyScore": self.score])
                    }
                    
                } else {
                    print("ERROR! getting BotanyScore from Firebase while trying to save new score")
                }
                
            }) { (error) in
                print(error.localizedDescription)
            }
            
            
            
        } else {
            print("ERROR! Unable to save BotanyScore to Firebase")
        }
        
    }
    
    
    
    @IBAction func submitResultButtonTapped(_ sender: UIButton) {
        gameOver()
        dismiss(animated: true)
//        performSegue(withIdentifier: "Return To Play Screen", sender: sender)
    }
    
    @IBAction func submitAnswerButtonTapped(_ sender: UIButton) {
        
        if (self.answerChoicesSegments.selectedSegmentIndex == -1) {
            Toast.show(message: "Please Choose an answer to proceed", controller: self)
        }
        else {
            answerChoicesSegments.isUserInteractionEnabled = true
            answerChoicesSegments.tintColor = #colorLiteral(red: 1, green: 0.8911997676, blue: 0.9159995317, alpha: 1)
            answerChoicesSegments.selectedSegmentIndex = UISegmentedControl.noSegment
            updateView()
        }
    }
    
    @IBAction func answerChoices(_ sender: UISegmentedControl) {
        
        if let answer = sender.titleForSegment(at: sender.selectedSegmentIndex) {
            
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
            .strokeColor: #colorLiteral(red: 1, green: 0.8911997676, blue: 0.9159995317, alpha: 1)
        ]
        let attributedString = NSAttributedString(string: "Score: \(score)", attributes: attributes)
        scoreLabel.attributedText = attributedString
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ref = Database.database().reference()
        answerChoicesSegments.selectedSegmentIndex = UISegmentedControl.noSegment
        quizEndScoreLabel.isHidden = true
        highScoreLabel.isHidden = true
        scoreLabel.textColor = #colorLiteral(red: 1, green: 0.8911997676, blue: 0.9159995317, alpha: 1)
        submitResultButtonLabel.isHidden = true
        updateView()
    }
    
    func updateView() {
        if (questionsToAsk.questionArray.count > 0) {
            let questionToShow = questionsToAsk.questionArray.remove(at: 0)
            questionNumber.text = String(questionToShow.questionNumber)
            questionInformation.text = questionToShow.question
            currentAnswer = questionToShow.answer
        } else if (questionsToAsk.questionArray.count == 0) {
            quizHasEnded()
            UserDefaults.standard.set(score, forKey: "BotanyScore")
        }
    }
    
    func quizHasEnded() {
        answerChoicesSegments.isUserInteractionEnabled = false
        quizEndScoreLabel.isHidden = false
        highScoreLabel.isHidden = false
        scoreLabel.isHidden = true
        questionNumber.isHidden = true
        questionInformation.isHidden = true
        answerChoicesSegments.isHidden = true
        submitButton.isHidden = true
        submitResultButtonLabel.isHidden = false
        quizEndScoreLabel.text = "Last Score: \(score)"
        
        let defaults = UserDefaults.standard
        let currentKid = defaults.value(forKey: "CurrentKid") as! String
        
        if let user = Auth.auth().currentUser{
            
            let userID = user.uid
            self.ref!.child("score").child(userID).child(currentKid).observeSingleEvent(of: .value, with: { (snapshot) in
                
                if let s = snapshot.childSnapshot(forPath: "BotanyScore").value{
                    if s is NSNull{
                        self.highScoreLabel.text = "High Score: \(self.score)"
                    } else{
                        if s as! Int > self.score{
                            self.highScoreLabel.text = "High Score: \(s)"
                        } else {
                            self.highScoreLabel.text = "High Score: \(self.score)"
                        }
                        
                    }
                } else {
                    print("ERROR! getting BotanyScore from Firebase")
                }
                
            }) { (error) in
                print(error.localizedDescription)
            }
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
