//
//  ViewController.swift
//  Tadak_design
//
//  Created by Kang Minsang on 2020/12/31.
//

import UIKit
import Firebase

class PhoneCheckViewController: UIViewController {

    var checked: Bool = false
    @IBOutlet weak var InputPhoneNumber: UITextField!
    @IBOutlet weak var setView: UIImageView!
    @IBOutlet weak var reSend: RoundButton!
    @IBOutlet weak var inputCheckNumber: UITextField!
    @IBOutlet weak var send: RoundButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboard()
        settingView()
    }

    //확인 버튼
    @IBAction func Button_check(_ sender: RoundButton) {
        //버튼 처음 클릭시
        if(checked == false) {
            //입력된 폰번호 체크
            let phoneNumber = changePhoneNumber(Input: InputPhoneNumber.text!)
            checkPhoneNumber(phoneNumber: phoneNumber)
        }
        //두번째 인증 : 문자가 보내진 후 인증번호 확인
        else {
            if let text = inputCheckNumber.text {
                Login.tryLogin(verificationCode: text) { (isNewUser) in
                    //새로운 사람의 경우 닉네임생성 화면으로 이동
                    if isNewUser {
                        self.goNextView()
                    }
                    //기존 유저의 경우 메인화면으로 이동
                    self.goMainView()
                }
            }
            //인증번호 미 입력시
            else {
                return print("인증번호를 입력하지 않았습니다.")
            }
        }
    }
}



extension PhoneCheckViewController {
    func settingView() {
        InputPhoneNumber.keyboardType = .numberPad
        inputCheckNumber.keyboardType = .numberPad
        
        setView.alpha = 0
        inputCheckNumber.alpha = 0
        reSend.alpha = 0
    }
    
    func showAnimation() {
        UIView.animate(withDuration: 0.5, animations: {
            self.setView.alpha = 1
            self.inputCheckNumber.alpha = 1
            self.reSend.alpha = 1
        })
        send.setTitle("인증하기", for: UIControl.State.normal)
    }
    
    func changePhoneNumber(Input: String) -> String {
        let result: String = "+8210" + Input.dropFirst(3)
        print(result)
        return result
    }
    
    func goNextView() {
        let vcName = self.storyboard?.instantiateViewController(withIdentifier: "NicknameViewController")
        vcName?.modalPresentationStyle = .fullScreen
        vcName?.modalTransitionStyle = .crossDissolve
        self.present(vcName!, animated: true, completion: nil)
    }
    
    func goMainView() {
        let vcName = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController")
        vcName?.modalPresentationStyle = .fullScreen
        vcName?.modalTransitionStyle = .crossDissolve
        self.present(vcName!, animated: true, completion: nil)
    }
    
    func checkPhoneNumber(phoneNumber: String) {
        Login.ifSucceseSendingMessage(phoneNumber: phoneNumber) {
            self.showAnimation()
            self.checked = true
        }
    }
}
