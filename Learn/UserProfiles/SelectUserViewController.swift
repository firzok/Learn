
import UIKit
import Firebase
import FirebaseDatabase

class SelectUserViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {

    @IBOutlet var selectedKidLabel: UILabel!
    @IBOutlet var pickerView: UIPickerView!
    
    var currentKid: String?
    
    //Firebase DB ref
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
                self.currentKid = self.kidArray[0]
            }
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        if self.kidArray.count == 0{
            self.ref = Database.database().reference()
            let userID = Auth.auth().currentUser?.uid
            
            self.ref!.child("children").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
                
                for child in snapshot.children {
                    let snap = child as! DataSnapshot
                    
                    let name = snap.childSnapshot(forPath: "displayName").value
                    
                    self.kidArray.append(name as! String)
                    self.currentKid = self.kidArray[0]
                }
                
            }) { (error) in
                print(error.localizedDescription)
            }
        }
        
        
        
        
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
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return CGFloat( 90.0)
    }
    
//    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
//        let titleData = kidArray[row]
//        let myTitle = NSAttributedString(string: titleData, attributes: [NSAttributedString.Key.font:UIFont(name: "Helvetica Neue", size: 32.0)!,NSAttributedString.Key.foregroundColor:UIColor.white])
//        return myTitle
//    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        var pickerLabel = view as? UILabel;
        
        if (pickerLabel == nil)
        {
            pickerLabel = UILabel()
            
            pickerLabel?.font = UIFont(name: "Helvetica Neue", size: 40)
            pickerLabel?.textAlignment = NSTextAlignment.center
            pickerLabel?.textColor = UIColor.white
        }
        
        pickerLabel?.text = kidArray[row]
        
        return pickerLabel!
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedKidLabel.text = "Hi: " + kidArray[row]
        currentKid = kidArray[row]
    }

    
    @IBAction func logoutButtonTapped(_ sender: Any) {
        try! Auth.auth().signOut()
        self.performSegue(withIdentifier: "unwindToLoginOrRegister", sender: self)
        
    }
    
    @IBAction func proceedButtonTapped(_ sender: Any) {
        
        let defaults = UserDefaults.standard
        defaults.set(currentKid ?? kidArray[0], forKey: "CurrentKid")
        
        self.performSegue(withIdentifier: "proceedToApp", sender: sender)
    }
    
    
}
