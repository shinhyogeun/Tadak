//
//  ADMINViewController.swift
//  Tadak
//
//  Created by Kang Minsang on 2021/01/18.
//

import UIKit
import Firebase

class ADMINViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboard()

    }
    

    @IBAction func backButton(_ sender: UIButton) {
        backtoMainView()
    }
}



extension ADMINViewController {
    func backtoMainView() {
        let vcName = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController")
        vcName?.modalPresentationStyle = .fullScreen
        vcName?.modalTransitionStyle = .crossDissolve
        self.present(vcName!, animated: true, completion: nil)
    }
}
