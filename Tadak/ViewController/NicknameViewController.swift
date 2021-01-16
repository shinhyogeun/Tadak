//
//  ViewController.swift
//  Tadak_design
//
//  Created by Kang Minsang on 2020/12/31.
//

import UIKit
import Firebase

class NicknameViewController: UIViewController {

    @IBOutlet weak var inputNickName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboard()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func Button_start(_ sender: RoundButton) {
        if let inputNickName = inputNickName.text {
            Login.ifInputNickNameUnique(nick: inputNickName) { (isErrorExite) in
                if isErrorExite {
                    //경고창으로 같은 닉네임 보여주기
                    print("same!!!!!!!!!!!!!!!!")
                } else {
                    self.goMainView()
                }
                
            }
        }
    }
}



extension NicknameViewController {
    func goMainView() {
        let vcName = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController")
        vcName?.modalPresentationStyle = .fullScreen
        vcName?.modalTransitionStyle = .crossDissolve
        self.present(vcName!, animated: true, completion: nil)
    }
}
