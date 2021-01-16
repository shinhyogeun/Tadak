//
//  ViewController.swift
//  Tadak_design
//
//  Created by Kang Minsang on 2020/12/31.
//

import UIKit
import Firebase

class StartViewController: UIViewController {
    
    var ref: DatabaseReference!
    let db = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Logout.tryLogout()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        //로그인이 이미 되어있는 경우라면 홈페이지로 이동한다.
        if Login.isAlreadyIn() {
            goMainView()
        }
    }
    //버튼 클릭시 다음화면으로 이동
    @IBAction func Button_Start(_ sender: UIButton) {
        goNextView()
    }
}



extension StartViewController {
    func goMainView() {
        print("Main")
        let vcName = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController")
        vcName?.modalPresentationStyle = .fullScreen
        vcName?.modalTransitionStyle = .crossDissolve
        self.present(vcName!, animated: true, completion: nil)
    }
    
    func goNextView() {
        let vcName = self.storyboard?.instantiateViewController(withIdentifier: "PhoneCheckViewController")
        vcName?.modalPresentationStyle = .fullScreen
        vcName?.modalTransitionStyle = .crossDissolve
        self.present(vcName!, animated: true, completion: nil)
    }
    
    func test_getData() {
        db.child("test").observeSingleEvent(of: .value) { (snapshot) in
            print("--> \(snapshot)")
        }
    }
}
