//
//  Question.swift
//  Learn
//
//  Created by Firzok Nadeem on 06/12/2018.
//  Copyright © 2018 Mani. All rights reserved.
//

class Question {

    var question : String
    var solution : String
    var score : Int
    
    // Initializer
    init(question : String, solution : String, score : Int) {
        self.question = question
        self.solution = solution
        self.score = score
    }
}
