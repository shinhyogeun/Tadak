//
//  ViewController.swift
//  Tadak_design
//
//  Created by Kang Minsang on 2020/12/31.
//

import UIKit
import Firebase

class MainViewController: UIViewController {
    
    @IBOutlet weak var korButton: UIButton!
    @IBOutlet weak var engButton: UIButton!
    @IBOutlet weak var extButton: UIButton!
    
    let ref = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        uploadTitleData()
//        uploadGameData()
        
    }

    @IBAction func topicButton(_ sender: UIButton) {
        if sender == korButton {
            korGame()
        }
        if sender == engButton {
            engGame()
        }
        if sender == extButton {
            extGame()
        }
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
    
    func korGame() {
        let kor = "한글대전"
        GameList.getGameListAndThen(pressedButtonText: kor) {
            self.goNextView()
        }
        return
    }
    
    func engGame() {
        let eng = "영어대전"
        GameList.getGameListAndThen(pressedButtonText: eng) {
            self.goNextView()
        }
        return
    }
    
    func extGame() {
        let ext = "Extra"
        GameList.getGameListAndThen(pressedButtonText: ext) {
            self.goNextView()
        }
        return
    }
}
