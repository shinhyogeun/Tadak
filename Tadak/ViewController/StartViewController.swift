//
//  ViewController.swift
//  Tadak_design
//
//  Created by Kang Minsang on 2020/12/31.
//

import UIKit
import Firebase

class StartViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //로그인이 이미 되어있는 경우라면 홈페이지로 이동한다.
        if Login.isAlreadyIn() {
            let vcName = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController")
            vcName?.modalPresentationStyle = .fullScreen
            vcName?.modalTransitionStyle = .crossDissolve
            self.present(vcName!, animated: true, completion: nil)
        }
    }

    @IBAction func Button_Start(_ sender: UIButton) {
        let vcName = self.storyboard?.instantiateViewController(withIdentifier: "PhoneCheckViewController")
        vcName?.modalPresentationStyle = .fullScreen
        vcName?.modalTransitionStyle = .crossDissolve
        self.present(vcName!, animated: true, completion: nil)
    }
    
}

