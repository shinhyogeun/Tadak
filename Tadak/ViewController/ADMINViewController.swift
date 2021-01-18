//
//  ADMINViewController.swift
//  Tadak
//
//  Created by Kang Minsang on 2021/01/18.
//

import UIKit
import Firebase

class ADMINViewController: UIViewController {
    
    let ref = Database.database().reference()
    var category: String = ""
    @IBOutlet weak var inputTitle: UITextField!
    @IBOutlet weak var inputGameText: UITextField!
    @IBOutlet weak var showGameText: UITextView!
    @IBOutlet weak var showCategory: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboard()
    }
    
    @IBAction func addLineButton(_ sender: RoundButton) {
        
    }
    
    @IBAction func korButton(_ sender: RoundButton) {
        category = "한글대전"
        showCategory.text = category
    }
    @IBAction func engButton(_ sender: RoundButton) {
        category = "영어대전"
        showCategory.text = category
    }
    @IBAction func extButton(_ sender: UIButton) {
        category = "Extra"
        showCategory.text = category
    }
    
    @IBAction func uploadButton(_ sender: RoundButton) {
        uploadTitle()
        
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        backtoMainView()
    }
}



extension ADMINViewController {
    func backtoMainView() {
        let vcName = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController")
        vcName?.modalPresentationStyle = .fullScreen
        vcName?.modalTransitionStyle = .crossDissolve
        self.present(vcName!, animated: true, completion: nil)
    }
    
    func uploadTitle() {
        DispatchQueue.main.async {
            self.ref.child("gametitle").child(self.category).observeSingleEvent(of: .value) { (snapshot) in
                
                let index = Int(snapshot.childrenCount)
                let title: String = self.inputTitle.text!
                let data = [String(index): title]
                
                self.ref.child("gametitle").child(self.category).updateChildValues(data)
            }
        }
    }
}
