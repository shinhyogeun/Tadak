//
//  ViewController.swift
//  Tadak_design
//
//  Created by Kang Minsang on 2020/12/31.
//

import UIKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboard()
        // Do any additional setup after loading the view.
    }

    @IBAction func Button_Result(_ sender: UIButton) {
        let vcName = self.storyboard?.instantiateViewController(withIdentifier: "ResultViewController")
        vcName?.modalPresentationStyle = .fullScreen
        vcName?.modalTransitionStyle = .crossDissolve
        self.present(vcName!, animated: true, completion: nil)
    }
    
}

