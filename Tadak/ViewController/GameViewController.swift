//
//  ViewController.swift
//  Tadak_design
//
//  Created by Kang Minsang on 2020/12/31.
//

import UIKit
import Foundation
import Firebase

class GameViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var gameTitle: UILabel!
    @IBOutlet weak var upperAfterLabel: UILabel!
    @IBOutlet weak var afterLabel: UILabel!
    @IBOutlet weak var nowLabel: UILabel!
    @IBOutlet weak var beforeLabel: UILabel!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var ImageBackground: UIImageView!
    @IBOutlet weak var upperView: UIView!

    let LABEL = UIColor(named: "ColorLabel")
    let BLUE = UIColor(named: "blue")
    let RED = UIColor(named: "red")
    
    var isThisChangeOccuredFirstTime : Bool = true
    var endStatus : Bool = true
    var timeOver : Bool = false
    var timer : Timer = Timer()
    var second : Double = 00.00
    var calculate : Calculate = Calculate.init()
    var miss : Int = 0
    var beatNum: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboard()
        // Do any additional setup after loading the view.
//        makeBlurEffect()
        baseUISetUp()
        baseContentsSetUp()
        baseEventSetUp()
    }

    @IBAction func Button_Result(_ sender: UIButton) {
        goNextView()
    }
    
}



extension GameViewController {
    func goNextView() {
        let vcName = self.storyboard?.instantiateViewController(withIdentifier: "ResultViewController")
        vcName?.modalPresentationStyle = .fullScreen
        vcName?.modalTransitionStyle = .crossDissolve
        self.present(vcName!, animated: true, completion: nil)
    }
    
    func makeBlurEffect() -> Void {
        let blurView = CustomIntensityVisualEffectView(effect: UIBlurEffect(style: .light), intensity: 0.05)
        let underBlurView = CustomIntensityVisualEffectView(effect: UIBlurEffect(style: .light), intensity: 1)
        
        blurView.frame = self.view.bounds
        underBlurView.frame = self.view.bounds
        upperView.addSubview(blurView)
        upperView.sendSubviewToBack(blurView)
        ImageBackground.addSubview(underBlurView)
        ImageBackground.sendSubviewToBack(underBlurView)
    }
    
    func baseUISetUp () -> Void {
        self.hideKeyboard()
        inputTextField.keyboardType = .default
        navigationController?.isNavigationBarHidden = true
        self.beforeLabel.alpha = 1
    }
    
    func baseContentsSetUp () -> Void {
        gameTitle.text = GameContents.name
        beforeLabel.text = GameContents.body[GameContents.index]
        timeLabel.text = String(format: "%.2f",GameContents.time)
    }
    
    func baseEventSetUp() -> Void {
        inputTextField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
    }

    @objc func textFieldDidChange(textField: UITextField){
        let answer = GameContents.body[GameContents.index]
        
        if let input = textField.text{
            if isThisChangeOccuredFirstTime {
                return startGame()
            }
            changeTextColorAndAddTimeBaseOnMiss(answer, input, textField)
            
            if isItOKIfGoToNextSentence(answer, input) {
                goToNextSentenceAndShowIt()
            }
        }
    }
    
    func changeTextColorAndAddTimeBaseOnMiss(_ answer : String, _ input : String, _ textField : UITextField) -> Void {
        calculate.changeColor(nowLabel, whatYouHaveToWrite: answer, whatYouAlreadyWrite: input, textField: textField)
        miss = calculate.countMiss(input, whatYouHaveToWrite: answer, whatYouAlreadyWrite: input)
        timeLabel.text = String(format: "%.2f",GameContents.addTime(Double(miss)))
    }

    func isItOKIfGoToNextSentence (_ answer: String, _ input : String) -> Bool {
        return Array(answer) == Array(input) || Array(nowLabel.text!).count < Array(input).count
    }
    
    func goToNextSentenceAndShowIt() -> Void {
        calculate.resetMissArr()
        GameContents.updateIndex()
        showUpdatedContents()
    }
    
    //첫 실행시 타이머 작동 메소드
    func startGame() {
        //타이머를 시작한다.
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        isThisChangeOccuredFirstTime = false
        setTextFirst()
        UISetUp()
    }
    
    func UISetUp() {
        self.nowLabel.transform = CGAffineTransform(translationX: 0, y: 35)
        self.nowLabel.alpha = 0.5
        UIView.animate(withDuration: 0.3) {
            self.nowLabel.transform = CGAffineTransform(translationX: 0, y: 0)
            self.nowLabel.alpha = 1
        }

        self.beforeLabel.transform = CGAffineTransform(translationX: 0, y: 35)
        self.beforeLabel.alpha = 0
        UIView.animate(withDuration: 0.3) {
            self.beforeLabel.alpha = 0.3
            self.beforeLabel.transform = CGAffineTransform(translationX: 0, y: 0)
        }
    }
    
    @objc func updateCounter() {
        if GameContents.isTimeOver() {
            return endGame()
        }
        
        GameContents.updateTime()
        timeLabel.text = String(format: "%.2f",GameContents.time)
    }
    
    func showUpdatedContents() {
        //화면에 내용을 보이는 코드
        self.nowLabel.textColor = UIColor.white
        if(GameContents.index == 1) {
            setTextSecond()
            self.afterLabel.transform = CGAffineTransform(translationX: 0, y: 35)
            self.afterLabel.alpha = 1
            UIView.animate(withDuration: 0.3) {
                self.afterLabel.alpha = 0.3
                self.afterLabel.transform = CGAffineTransform(translationX: 0, y: 0)
            }
            self.nowLabel.transform = CGAffineTransform(translationX: 0, y: 35)
            self.nowLabel.alpha = 0.2
            UIView.animate(withDuration: 0.3) {
                self.nowLabel.transform = CGAffineTransform(translationX: 0, y: 0)
                self.nowLabel.alpha = 1
            }
            self.beforeLabel.transform = CGAffineTransform(translationX: 0, y: 35)
            self.beforeLabel.alpha = 0
            UIView.animate(withDuration: 0.3) {
                self.beforeLabel.alpha = 0.3
                self.beforeLabel.transform = CGAffineTransform(translationX: 0, y: 0)
            }
            
            inputTextField.text = ""
        } else if GameContents.index >= 2 && GameContents.index <= GameContents.body.count - 2 {
            setTextNomal()
            self.upperAfterLabel.transform = CGAffineTransform(translationX: 0, y: 35)
            self.upperAfterLabel.alpha = 0.3
            UIView.animate(withDuration: 0.3) {
                self.upperAfterLabel.alpha = 0
                self.upperAfterLabel.transform = CGAffineTransform(translationX: 0, y: 0)
            }
            self.afterLabel.transform = CGAffineTransform(translationX: 0, y: 35)
            self.afterLabel.alpha = 1
            UIView.animate(withDuration: 0.3) {
                self.afterLabel.alpha = 0.3
                self.afterLabel.transform = CGAffineTransform(translationX: 0, y: 0)
            }
            self.nowLabel.transform = CGAffineTransform(translationX: 0, y: 35)
            self.nowLabel.alpha = 0.2
            UIView.animate(withDuration: 0.3) {
                self.nowLabel.transform = CGAffineTransform(translationX: 0, y: 0)
                self.nowLabel.alpha = 1
            }
            self.beforeLabel.transform = CGAffineTransform(translationX: 0, y: 35)
            self.beforeLabel.alpha = 0
            UIView.animate(withDuration: 0.3) {
                self.beforeLabel.alpha = 0.3
                self.beforeLabel.transform = CGAffineTransform(translationX: 0, y: 0)
            }
            
            inputTextField.text = ""
        } else if GameContents.index == GameContents.body.count - 1 {
            setTextLast()
            self.upperAfterLabel.transform = CGAffineTransform(translationX: 0, y: 35)
            self.upperAfterLabel.alpha = 0.3
            UIView.animate(withDuration: 0.3) {
                self.upperAfterLabel.alpha = 0
                self.upperAfterLabel.transform = CGAffineTransform(translationX: 0, y: 0)
            }
            self.afterLabel.transform = CGAffineTransform(translationX: 0, y: 35)
            self.afterLabel.alpha = 1
            UIView.animate(withDuration: 0.3) {
                self.afterLabel.alpha = 0.3
                self.afterLabel.transform = CGAffineTransform(translationX: 0, y: 0)
            }
            self.nowLabel.transform = CGAffineTransform(translationX: 0, y: 35)
            self.nowLabel.alpha = 0.2
            UIView.animate(withDuration: 0.3) {
                self.nowLabel.transform = CGAffineTransform(translationX: 0, y: 0)
                self.nowLabel.alpha = 1
            }

            inputTextField.text = ""
        } else if GameContents.index > GameContents.body.count - 1 {
            setTextEnd()
            endGame()
            self.upperAfterLabel.transform = CGAffineTransform(translationX: 0, y: 35)
            self.upperAfterLabel.alpha = 0.3
            UIView.animate(withDuration: 0.3) {
                self.upperAfterLabel.alpha = 0
                self.upperAfterLabel.transform = CGAffineTransform(translationX: 0, y: 0)
            }
            
            self.afterLabel.transform = CGAffineTransform(translationX: 0, y: 35)
            self.afterLabel.alpha = 1
            UIView.animate(withDuration: 0.3) {
                self.afterLabel.alpha = 0.5
                self.afterLabel.transform = CGAffineTransform(translationX: 0, y: 0)
            }
            
            self.nowLabel.transform = CGAffineTransform(translationX: 0, y: 35)
            nowLabel.alpha = 0
            UIView.animate(withDuration: 0.3) {
                self.nowLabel.transform = CGAffineTransform(translationX: 0, y: 0)
                self.nowLabel.alpha = 1
            }
        }
    }
    
    func endGame() {
        timer.invalidate()
        inputTextField.isHidden = true
        endStatus = false
        
        if(GameContents.isTimeOver()) {
            GameContents.time = -1
        } else {
//            Recode.updateRecode()
        }
        
        self.view.endEditing(true)
        goNextView()
    }
    
    func setTextFirst() {
        nowLabel.text = GameContents.body[GameContents.index]
        beforeLabel.text = GameContents.body[GameContents.index + 1]
    }
    
    func setTextSecond() {
        afterLabel.text = GameContents.body[GameContents.index - 1]
        nowLabel.text = GameContents.body[GameContents.index]
        beforeLabel.text = GameContents.body[GameContents.index + 1]
    }
    
    func setTextNomal() {
        upperAfterLabel.text = GameContents.body[GameContents.index - 2]
        afterLabel.text = GameContents.body[GameContents.index - 1]
        nowLabel.text = GameContents.body[GameContents.index]
        beforeLabel.text = GameContents.body[GameContents.index + 1]
    }
    
    func setTextLast() {
        upperAfterLabel.text = GameContents.body[GameContents.index - 2]
        afterLabel.text = GameContents.body[GameContents.index - 1]
        nowLabel.text = GameContents.body[GameContents.index]
        beforeLabel.text = ""
    }
    
    func setTextEnd() {
        upperAfterLabel.text = GameContents.body[GameContents.index - 2]
        afterLabel.text = GameContents.body[GameContents.index - 1]
        nowLabel.text = "게임이 종료되었습니다."
        beforeLabel.text = ""
    }
}
