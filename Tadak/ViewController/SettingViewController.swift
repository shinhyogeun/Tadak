//
//  ViewController.swift
//  Tadak_design
//
//  Created by Kang Minsang on 2020/12/31.
//

import UIKit
import Firebase

class SettingViewController: UIViewController {

    let ref = Database.database().reference()
    
    @IBOutlet weak var showName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getNickName()
    }

    @IBAction func changeNickName(_ sender: RoundButton) {
        changeNickName()
    }
    @IBAction func logout(_ sender: RoundButton) {
        logout()
    }
    
    @IBAction func deleteUser(_ sender: RoundButton) {
        deleteUser()
    }
    
    @IBAction func ADMIN(_ sender: UIButton) {
        ADMIN()
    }
}


extension SettingViewController {
    func goStartView() {
        let vcName = self.storyboard?.instantiateViewController(withIdentifier: "StartViewController")
        vcName?.modalPresentationStyle = .fullScreen
        vcName?.modalTransitionStyle = .crossDissolve
        self.present(vcName!, animated: true, completion: nil)
    }
    
    func getNickName() {
        ref.child("users")
            .child(Auth.auth().currentUser!.uid)
            .child("nickname")
            .child("nickname")
            .observeSingleEvent(of: .value) { (snapshot) in
                let getName = snapshot.value as? String ?? ""
                print(getName)
                self.showName.text = getName
            }
    }
    
    func ADMIN() {
        let vcName = self.storyboard?.instantiateViewController(withIdentifier: "ADMINViewController")
        vcName?.modalPresentationStyle = .fullScreen
        vcName?.modalTransitionStyle = .crossDissolve
        self.present(vcName!, animated: true, completion: nil)
    }
    
    func logout() {
        print("logout")
        let alert = UIAlertController(title:"로그아웃 하시겠습니까?",message: "",preferredStyle: UIAlertController.Style.alert)
        let cancle = UIAlertAction(title: "취소", style: .default, handler: nil)
        let ok = UIAlertAction(title: "확인", style: .destructive, handler: {
            action in
            Logout.tryLogout()
            self.goStartView()
        })
        alert.addAction(cancle)
        alert.addAction(ok)
        present(alert,animated: true,completion: nil)
    }
    
    func deleteUser() {
        print("deleteUser")
        let alert = UIAlertController(title:"계정을 삭제하시겠습니까?",message: "",preferredStyle: UIAlertController.Style.alert)
        let cancle = UIAlertAction(title: "취소", style: .default, handler: nil)
        let ok = UIAlertAction(title: "확인", style: .destructive, handler: {
            action in
            //일단은 로그아웃 기능과 동일
            Logout.tryLogout()
            self.goStartView()
        })
        alert.addAction(cancle)
        alert.addAction(ok)
        present(alert,animated: true,completion: nil)
    }
    
    func changeNickName() {
        print("changeNickName")
        let alert = UIAlertController(title: showName.text, message: "10자리 내의 새로운 닉네임을 입력해주세요", preferredStyle: .alert)
        let cancle = UIAlertAction(title: "취소", style: .default, handler: nil)
        let ok = UIAlertAction(title: "확인", style: .destructive, handler: {
            action in
            print(alert.textFields?[0].text ?? "")
        })
        alert.addTextField { (inputNewNickName) in
            inputNewNickName.placeholder = "새로운 닉네임 입력"
            inputNewNickName.textAlignment = .center
            inputNewNickName.font = UIFont(name: "NanumSquareRoundR", size: 17)
        }
        alert.addAction(cancle)
        alert.addAction(ok)
        present(alert,animated: true,completion: nil)
    }
}
