//
//  ViewController.swift
//  Tadak_design
//
//  Created by Kang Minsang on 2020/12/31.
//

import UIKit

class SelectViewController: UIViewController {
    
    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var gameTableView: UITableView!
    
    var nameArr : [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        baseSetup()
    }

    @IBAction func Button_SampleGame(_ sender: UIButton) {
        goNextView()
    }
    
    @IBAction func Button_back(_ sender: UIButton) {
        goBackView()
    }
}



extension SelectViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GameList.body.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.gameTableView.dequeueReusableCell(withIdentifier: "gameCell", for: indexPath) as! gameTableViewCell
        cell.gameLabel.text = GameList.body[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        GameContents.getContentsAndThen(indexPathRow: indexPath.row) {
            self.goNextView()
        }
    }
    
    func goBackView() {
        let vcName = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController")
        vcName?.modalPresentationStyle = .fullScreen
        vcName?.modalTransitionStyle = .crossDissolve
        self.present(vcName!, animated: true, completion: nil)
    }
    
    func goNextView() {
        let vcName = self.storyboard?.instantiateViewController(withIdentifier: "GameViewController")
        vcName?.modalPresentationStyle = .fullScreen
        vcName?.modalTransitionStyle = .crossDissolve
        self.present(vcName!, animated: true, completion: nil)
    }
    
    func baseSetup() ->Void {
        self.gameTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        mainTitle.text = GameList.name
        gameTableView.delegate = self
        gameTableView.dataSource = self
        self.gameTableView.register(UINib(nibName: "gameTableViewCell", bundle: nil), forCellReuseIdentifier: "gameCell")
        gameTableView.rowHeight = 90
        navigationController?.isNavigationBarHidden = true
    }
}
