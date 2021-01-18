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

    @IBAction func logout(_ sender: RoundButton) {
        Logout.tryLogout()
        goStartView()
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
}
