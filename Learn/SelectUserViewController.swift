
import UIKit
import Firebase
import FirebaseDatabase

class SelectUserViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {

    @IBOutlet var selectedGradeLabel: UILabel!
    @IBOutlet var pickerView: UIPickerView!
    
    var ref: DatabaseReference?
    
    
    
    var kidArray:[String]  = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        
        self.ref!.child("children").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                
                let name = snap.childSnapshot(forPath: "displayName").value
                
                self.kidArray.append(name as! String)
                
            }
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        pickerView.reloadAllComponents()
        
        pickerView.reloadInputViews()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        pickerView.reloadAllComponents()
        
        pickerView.reloadInputViews()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        super.viewDidAppear(animated)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return kidArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return kidArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleData = kidArray[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSAttributedString.Key.font:UIFont(name: "Helvetica Neue", size: 24.0)!,NSAttributedString.Key.foregroundColor:UIColor.white])
        return myTitle
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedGradeLabel.text = "Hi: " + kidArray[row]
    }

    
    @IBAction func logoutButtonTapped(_ sender: Any) {
        try! Auth.auth().signOut()
        self.dismiss(animated: true, completion: nil)
        
    }
    
}
