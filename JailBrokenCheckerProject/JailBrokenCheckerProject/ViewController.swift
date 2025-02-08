//
//  ViewController.swift
//  JailBrokenCheckerProject
//
//  Created by amr on 11/16/17.
//  Copyright © 2017 KarmaAdam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func checkAndCloseBtnPressed(_ sender: Any) {
        
        let isClearDevice = JailBrokenChecker.isDeviceJailbroken(true)
        
        var msg :String
        if !isClearDevice {
             msg = "Clean Device"
        }else{
             msg = "Jail broken Device"
        }
        
        let alert = UIAlertController(title: "Alert", message: msg, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
                
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
                
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func checkBtnPressed(_ sender: Any) {
        
        let isClearDevice = JailBrokenChecker.isDeviceJailbroken()
        
        var msg :String
        if !isClearDevice {
            msg = "Clean Device"
        }else{
            msg = "Your Device is jailbroken, Application will be Exit"
        }
        
        let alert = UIAlertController(title: "Alert", message: msg, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
                //Comment: to terminate app, do not use exit(0) bc that is logged as a crash.
                UIControl().sendAction(#selector(URLSessionTask.suspend), to: UIApplication.shared, for: nil)
            
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
                
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
 }
