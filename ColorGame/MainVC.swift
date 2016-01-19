//
//  MainVC.swift
//  ColorGame
//
//  Created by John Huang on 2016/1/13.
//  Copyright © 2016年 JohnHuang. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    
    func backgroundAnimation() {
//        UIView.animateWithDuration(1.0, animations: { () -> Void in
//            self.backgroundView.backgroundColor = UIColor.blackColor()
//            }) { (Bool) -> Void in
//                UIView.animateWithDuration(1.0, animations: { () -> Void in
//                    self.view.backgroundColor = UIColor.greenColor()
//                    }, completion: { (Bool) -> Void in
//                        UIView.animateWithDuration(1.0, animations: { () -> Void in
//                            self.view.backgroundColor = UIColor.grayColor()
//                            }, completion: { (Bool) -> Void in
//                                UIView.animateWithDuration(1.0, animations: { () -> Void in
//                                    self.view.backgroundColor = UIColor.redColor()
//                                    }, completion:nil)
//                        })
//                })
//        }
        
        UIView.animateWithDuration(2, delay: 0.0, options:[UIViewAnimationOptions.Repeat, UIViewAnimationOptions.Autoreverse], animations: {
            self.view.backgroundColor = UIColor.blackColor()
            self.view.backgroundColor = UIColor.greenColor()
            self.view.backgroundColor = UIColor.redColor()
            }, completion: nil)
    }
    

    @IBAction func startGameBtnPressed(sender: AnyObject) {
//        
//        let vc = self.storyboard!.instantiateViewControllerWithIdentifier("ViewController") as! ViewController
//
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func scoreBtnPressed(sender: AnyObject) {
        
//        self.navigationController?.pushViewController(RecordTVC(), animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        backgroundAnimation()
        
        

    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
