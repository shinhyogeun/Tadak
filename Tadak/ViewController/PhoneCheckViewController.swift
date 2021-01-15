//
//  ViewController.swift
//  Tadak_design
//
//  Created by Kang Minsang on 2020/12/31.
//

import UIKit

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
        // Do any additional setup after loading the view.
        InputPhoneNumber.keyboardType = .numberPad
        inputCheckNumber.keyboardType = .numberPad
        
        setView.alpha = 0
        inputCheckNumber.alpha = 0
        reSend.alpha = 0
    }

    
    @IBAction func Button_check(_ sender: RoundButton) {
        if(checked == false) {
            UIView.animate(withDuration: 0.5, animations: {
                self.setView.alpha = 1
                self.inputCheckNumber.alpha = 1
                self.reSend.alpha = 1
            })
            checked = true
            send.setTitle("인증하기", for: UIControl.State.normal)
        }
        else {
            let vcName = self.storyboard?.instantiateViewController(withIdentifier: "NicknameViewController")
            vcName?.modalPresentationStyle = .fullScreen
            vcName?.modalTransitionStyle = .crossDissolve
            self.present(vcName!, animated: true, completion: nil)
        }
    }
    
}

