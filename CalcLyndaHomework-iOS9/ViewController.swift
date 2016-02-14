//
//  ViewController.swift
//  CalcLyndaHomework-iOS9
//
//  Created by yodyodsmall on 2/14/16.
//  Copyright © 2016 yuryg. All rights reserved.
//

import UIKit

enum modes{
    case NOT_SET
    case ADD
    case SUB
}


class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    
    var labelString: String = "0"
    var currentMode: modes = modes.NOT_SET
    var savedNum: Int = 0
    var lastButtonWasMode: Bool = false
    
    @IBAction func tappedNumber(sender: UIButton) {
          let theTappedNum = Int(sender.titleLabel!.text!)
        
        savedNum = theTappedNum!
        print("savedNum=\(savedNum)")
        
        }
    
    
    @IBAction func tappedPlus(sender: UIButton) {
    }
    @IBAction func tappedMinus(sender: UIButton) {
    }
    @IBAction func tappedEQ(sender: AnyObject) {
    }
    
    @IBAction func tappedCleared(sender: UIButton) {
    }
    func tappedNumberUser
(num: Int){
        
    }
    
    func updateText(){
        labelString = String("\(savedNum)")
        label.text = labelString
    }
    
    func changeMode(newMode: modes){
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

