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
    var gameData: [String] = []
    var isReady: Bool = true
    @IBOutlet weak var inputTitle: UITextField!
    @IBOutlet weak var inputGameText: UITextField!
    @IBOutlet weak var showGameText: UITextView!
    @IBOutlet weak var showCategory: UILabel!
    @IBOutlet weak var uploadButton: RoundButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboard()
    }
    
    @IBAction func addLineButton(_ sender: RoundButton) {
        appendGameData()
        showGameData()
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
        if isReady {
            uploadTitle()
            uploadGame()
            alertSuccess()
            uploadButton.setTitle("RESET", for: UIControl.State.normal)
            isReady = false
        }
        else {
            reset()
            uploadButton.setTitle("업로드!", for: UIControl.State.normal)
            isReady = true
        }
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
                print("uploadTitle")
            }
        }
    }
    
    func appendGameData() {
        let lineData: String = inputGameText.text!
        inputGameText.text = ""
        gameData.append(lineData)
    }
    
    func showGameData() {
        var showData: String = ""
        for i in gameData {
            showData += i+"\n"
        }
        showGameText.text = showData
    }
    
    func uploadGame() {
        DispatchQueue.main.async {
            let title: String = self.inputTitle.text!
            let data = [title: self.gameData]
            self.ref.child("game").child(self.category).updateChildValues(data)
            print("uploadGame")
        }
    }
    
    func alertSuccess() {
        print("upload success")
        let alert = UIAlertController(title:"UPLOAD COMPLETE",message: ":)",preferredStyle: UIAlertController.Style.alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        present(alert,animated: true,completion: nil)
    }
    
    func reset() {
        inputTitle.text = ""
        inputGameText.text = ""
        showGameText.text = ""
        showCategory.text = "카테고리 선택"
    }
}
