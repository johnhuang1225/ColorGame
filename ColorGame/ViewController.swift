//
//  ViewController.swift
//  ColorGame
//
//  Created by John Huang on 2016/1/9.
//  Copyright © 2016年 JohnHuang. All rights reserved.
//

import UIKit
import GameplayKit
import CoreData

class ViewController: UIViewController {

    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var questionColorLabel: UILabel!
    
    @IBOutlet weak var choiceLabel: UILabel!
    @IBOutlet weak var choiceColorLabel: UILabel!
 
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var button8: UIButton!
    @IBOutlet weak var button9: UIButton!
    @IBOutlet weak var button10: UIButton!
    @IBOutlet weak var button11: UIButton!
    @IBOutlet weak var button12: UIButton!
    @IBOutlet weak var button13: UIButton!
    @IBOutlet weak var button14: UIButton!
    @IBOutlet weak var button15: UIButton!
    @IBOutlet weak var button16: UIButton!
    @IBOutlet weak var button17: UIButton!
    @IBOutlet weak var button18: UIButton!
    @IBOutlet weak var button19: UIButton!
    @IBOutlet weak var button20: UIButton!
    @IBOutlet weak var button21: UIButton!
    @IBOutlet weak var button22: UIButton!
    @IBOutlet weak var button23: UIButton!
    @IBOutlet weak var button24: UIButton!
    @IBOutlet weak var button25: UIButton!

    @IBOutlet weak var correctCountLabel: UILabel!
    @IBOutlet weak var wrongCountLabel: UILabel!
    
    var correctCount: Int {
        return Int(correctCountLabel.text!)!
    }
    var wrongCount: Int {
        return Int(wrongCountLabel.text!)!
    }
    var score: Int {
        return correctCount - wrongCount
    }
    
    

    var questionColorArray: [String] = []
    
    lazy var buttonArray: [UIButton] = {
        var result:[UIButton] = []
        for i in 1...25 {
            if let btn = self.valueForKey("button\(i)") as? UIButton {
                result.append(btn)
            }
        }
        return result
    }()
    
    var correctAnsIndex: Int = 0
    
    // 剩餘時間
    var remainingSeconds = MY_SECONDS {
        didSet {
            remainingSecondsLabel.text = String(remainingSeconds)
        }
    }
    @IBOutlet weak var remainingSecondsLabel: UILabel!
    var timer: NSTimer?
    
    // Model
    var colors = ColorModel().colors
    

    @IBAction func buttonPressed(sender: UIButton) {
        if sender.tag == correctAnsIndex {
            if let correctCount = Int(correctCountLabel.text!) {
                correctCountLabel.text = "\(correctCount + 1)"
                setUp()
                hidden()
                show()
            }
            
            choiceLabel.hidden = true
            choiceColorLabel.hidden = true
            
        } else {
            if let wrongCount = Int(wrongCountLabel.text!) {
                wrongCountLabel.text = "\(wrongCount + 1)"
            }
            
            choiceLabel.hidden = false
            choiceColorLabel.hidden = false
            
            choiceColorLabel.text = String(colors[sender.tag])
            choiceColorLabel.textColor = UIColor.init(hex: "\(colors[sender.tag])")
//            showColorName(sender.tag)
        }
    }
    
    
    func showColorName(index: Int) {
        let alertController = UIAlertController(title: "您選的顏色", message: "\(colors[index])", preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(okAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    
    // 打亂顏色
    func shuffle() {
        colors = GKRandomSource.sharedRandom().arrayByShufflingObjectsInArray(colors) as! [String]
    }
    
    // 設定按鈕
    func setColor() {
        
        if questionColorArray.count > 0 {
            questionColorArray.removeAll(keepCapacity: true)
        }
        
        // 取出打亂顏色的前25個顏色當題目
        for i in 0...buttonArray.count - 1 {
            let color = UIColor.init(hex: colors[i])
            buttonArray[i].backgroundColor = color
            buttonArray[i].tag = i
            // 設定圓角
            buttonArray[i].clipsToBounds = true
            buttonArray[i].layer.cornerRadius = buttonArray[i].frame.size.width / 2
            // 設定邊框
            buttonArray[i].layer.borderWidth = 0.8
            buttonArray[i].layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.9).CGColor
            // 問題陣列
            questionColorArray.append(colors[i])
        }
        
        // 設定背景
        backgroundView.backgroundColor = UIColor.init(hex: colors.last)
        print(questionColorArray)
        
        remainingSecondsLabel.textColor = UIColor.init(hex: colors[colors.count-2])
        print("remainingSecondsLabel:\(colors[colors.count-2])")
    }
    
    func setCorrectAnswer() {
        correctAnsIndex = myRandom(25)
        print("correctAnsIndex:\(correctAnsIndex)")
        questionColorLabel.text = questionColorArray[correctAnsIndex]
    }
    
    func myRandom(max: Int) -> Int {
        return Int(arc4random() % UInt32(max))
    }
    
    func setUp() {
        // 打亂所有顏色陣列
        shuffle()
        // 設定按鈕
        setColor()
        // 設定顏色答案
        setCorrectAnswer()
        // 設定倒數時間
        remainingSecondsLabel.text = String(remainingSeconds)
        // 隱藏
        choiceLabel.hidden = true
        choiceColorLabel.hidden = true
        
    }
    
    // MARK: - Animation Function
    func hidden() {
        for i in 0...buttonArray.count-1 {
            buttonArray[i].alpha = 0
        }
    }
    
    func show() {
        UIView.animateWithDuration(1, animations: { () -> Void in
            for i in 0...self.buttonArray.count-1 {
                self.buttonArray[i].alpha = 1
            }
            }, completion: nil)
    }
    
    func countdown() {
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "updateTimer:", userInfo: nil, repeats: true)
    }
    
    func updateTimer(timer: NSTimer) {
        remainingSeconds -= 1
        if remainingSeconds == 0 {
            timer.invalidate()
            alert()
        }
    }
    
    // 遊戲結束時呼叫
    func alert() {
        
        var message: String = ""
        if score > 0 {
            message = "是否保存紀錄？"
        }
        
        let alertController = UIAlertController(title: "您的分數：\(score)", message: message, preferredStyle: .Alert)
        
        // 分數大於零有保存選項,小於零則改為回到主畫面
        if score > 0 {
            var usernameTextField: UITextField?
            let saveAction = UIAlertAction(title: "保存紀錄", style: .Default) { (action) -> Void in
                if let username = usernameTextField?.text {
                    print(username)
                    self.saveRecord(username, score: "\(self.score)")
                    self.navigationController?.popViewControllerAnimated(true)
                }
            }
            
            alertController.addTextFieldWithConfigurationHandler { (txtUsername) -> Void in
                usernameTextField = txtUsername
                usernameTextField?.placeholder = "請輸入姓名"
            }
            alertController.addAction(saveAction)
        } else {
            let backAction = UIAlertAction(title: "回到主畫面", style: .Default) { (action) -> Void in
                self.navigationController?.popViewControllerAnimated(true)
            }
            alertController.addAction(backAction)
        }
        
        let restartAction = UIAlertAction(title: "重新開始", style: .Default) { (action) -> Void in
            self.setUp()
            self.countdown()
            self.hidden()
            self.show()
            self.remainingSeconds = MY_SECONDS
            self.correctCountLabel.text = "\(0)"
            self.wrongCountLabel.text = "\(0)"
        }
        alertController.addAction(restartAction)
        

        
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    
    // MARK: - Core Data
    func saveRecord(name: String, score: String) {
        // 取得context
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = appDelegate.managedObjectContext
        
        // 建立Entity物件
        let record = NSEntityDescription.insertNewObjectForEntityForName("Record", inManagedObjectContext: context) as! Record
        
        record.name = name
        record.score = score
        
        appDelegate.saveContext()
    }
    
    override func performSegueWithIdentifier(identifier: String, sender: AnyObject?) {
        print("test")
        if identifier == "score" {
            print("score")
        }
    }
    

    // MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 初始化設定
        setUp()
        // 倒數計時
        countdown()
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        hidden()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        show()
    }


}

