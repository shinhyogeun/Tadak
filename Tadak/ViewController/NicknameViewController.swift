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
                    self.showAlert()
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
    
    func showAlert() {
        print("same NickName")
        let alert = UIAlertController(title:"다른 닉네임이 필요합니다",message: "10자리 내로 다른 닉네임을 입력해 주세요",preferredStyle: UIAlertController.Style.alert)
        let ok = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(ok)
        present(alert,animated: true,completion: nil)
    }
}
