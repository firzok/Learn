//
//  BotanyQuestions.swift
//  Learn
//
//  Created by Faateh Jarree on 3/3/19.
//  Copyright © 2019 Mani. All rights reserved.
//

import Foundation

struct questionDetail {
    let questionNumber: Int
    let question: String
    let answer: String
}

struct botanyQuestions {
    var questionArray: [questionDetail]
    init() {
        let q1 = questionDetail(questionNumber: 1,question: """
These plants do not have a vascular system to transport water and food to all parts of the plant.\nA)Rose\n B)Mango\n C)Moss\n D)Money Plant
""",answer: "C")
        let q2 = questionDetail(questionNumber: 2,question: """
Which of these is not the plant? \n A)Grass \n B)Fungi \n C)Fern \n D)Moss
""",answer: "B")
        let q3 = questionDetail(questionNumber: 3,question: """
What do mosses have that apple trees do not have?.\n A)Stem\n B)Seed\n C)Spore\n D)Flower
""",answer: "C")
        let q4 = questionDetail(questionNumber: 4,question: """
The ferns have dot like structures on the under side of their leaves. These are called?.\n A)Pollen\n B)Anther\n C)Stigma\n D)Spores
""",answer: "D")
        let q5 = questionDetail(questionNumber: 5,question: """
One way the mosses and ferns are alike is that they both.\nA)Are flowering plants\nB)Produce spores\nC)Can grow in areas with very little water\nD)Angiosperms
""",answer: "B")
        let q6 = questionDetail(questionNumber: 6,question: """
Trees can grow very tall because they are\nA)Vascular\nB)Flowering\nC)Deciduous\nD)Non Vascular
""",answer: "A")
        let q7 = questionDetail(questionNumber: 7,question: """
Which of these is an example of a non vascular plant.\nA)Mosses\nB)Pine tree\nC)Rose plant\nD)Lemon plant
""",answer: "A")
        let q8 = questionDetail(questionNumber: 8,question: """
Which of these is a process that allows plants to make their food\nA)Photosynthesis\nB)Excretion\nC)Reproduction\nD)Transpiration
""",answer: "A")
        let q9 = questionDetail(questionNumber: 9,question: """
The transfer of pollen grain from anther to stigma is known as\nA)Nectar\nB)Fertilization\nC)Pollination\nD)Transpiration
""",answer: "C")
        let q10 = questionDetail(questionNumber: 10,question: """
The top part of the pistil which is sticky and traps pollen is known as\nA)Pistil\nB)Carpel\nC)Petals\nD)Stigma
""",answer: "D")
        questionArray = [q1,q2,q3,q4,q5,q6,q7,q8,q9,q10]
    }
}
