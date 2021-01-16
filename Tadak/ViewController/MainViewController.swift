//
//  ViewController.swift
//  Tadak_design
//
//  Created by Kang Minsang on 2020/12/31.
//

import UIKit
import Firebase

class MainViewController: UIViewController {

    @IBOutlet weak var UITextField_inputPhoneNumber: UITextField!
    
    let ref = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        uploadTitleData()
//        uploadGameData()
    }

    @IBAction func Button_korea(_ sender: UIButton) {
        goNextView()
    }
    
    @IBAction func Button_setting(_ sender: UIButton) {
        goSettingView()
    }
}




extension MainViewController {
    func goNextView() {
        let vcName = self.storyboard?.instantiateViewController(withIdentifier: "SelectViewController")
        vcName?.modalPresentationStyle = .fullScreen
        vcName?.modalTransitionStyle = .crossDissolve
        self.present(vcName!, animated: true, completion: nil)
    }
    
    func goSettingView() {
        let vcName = self.storyboard?.instantiateViewController(withIdentifier: "SettingViewController")
//        vcName?.modalPresentationStyle = .fullScreen
//        vcName?.modalTransitionStyle = .crossDissolve
        self.present(vcName!, animated: true, completion: nil)
    }
    
    func uploadTitleData() {
        ref.child("gametitle").setValue(GameText.gameTitle().gameTitle)
    }
    
    func uploadGameData() {
        let gameData = [
            "한글대전" : GameText.Korea().koreaText,
            "영어대전" : GameText.English().englishText,
            "Extra" : GameText.Extra().extraText
        ]
        ref.child("game").setValue(gameData)
    }
}
