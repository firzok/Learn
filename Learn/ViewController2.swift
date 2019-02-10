//
//  ViewController2.swift
//  Learn
//
//  Created by Mani on 10/14/18.
//  Copyright © 2018 Mani. All rights reserved.
//

import UIKit
import Firebase

class ViewController2: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {

    @IBOutlet var selectedGradeLabel: UILabel!
    @IBOutlet var pickerView: UIPickerView!
    
    
    
    let gradeArray = ["TWO", "THREE", "FOUR", "FIVE"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return gradeArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return gradeArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleData = gradeArray[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSAttributedString.Key.font:UIFont(name: "Helvetica Neue", size: 18.0)!,NSAttributedString.Key.foregroundColor:UIColor.white])
        return myTitle
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedGradeLabel.text = "Grade: " + gradeArray[row]
    }

    
    @IBAction func logoutButtonTapped(_ sender: Any) {
        try! Auth.auth().signOut()
        self.dismiss(animated: true, completion: nil)
        
    }
    
}
