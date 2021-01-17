//
//  ViewController.swift
//  Tadak_design
//
//  Created by Kang Minsang on 2020/12/31.
//

import UIKit

class ResultViewController: UIViewController {

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var result: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showResult()
    }

    
    @IBAction func reGame(_ sender: RoundButton) {
        GameContents.index = 0
        GameContents.time = 00.00
        goGameView()
    }
    @IBAction func mainButton(_ sender: RoundButton) {
        GameContents.reset()
        goMainView()
    }
}


extension ResultViewController {
    func goMainView() {
        let vcName = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController")
        vcName?.modalPresentationStyle = .fullScreen
        vcName?.modalTransitionStyle = .crossDissolve
        self.present(vcName!, animated: true, completion: nil)
    }
    
    func goGameView() {
        let vcName = self.storyboard?.instantiateViewController(withIdentifier: "GameViewController")
        vcName?.modalPresentationStyle = .fullScreen
        vcName?.modalTransitionStyle = .crossDissolve
        self.present(vcName!, animated: true, completion: nil)
    }
    
    func showResult() {
        titleLabel.text = GameContents.name
        
        if GameContents.time == -1 {
            result.text = "시간초과!"
        } else{
            result.text = String(format: "%.2f", GameContents.time)
        }
    }
}
