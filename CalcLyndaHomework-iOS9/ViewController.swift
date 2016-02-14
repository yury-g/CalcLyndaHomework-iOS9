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
    case EQULS
}


class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    
    var labelString: String = "0"
    var currentMode: modes = modes.NOT_SET
    var savedNum: Int = 0
    var lastButtonWasMode: Bool = false
    
    @IBAction func tappedNumber(sender: UIButton) {
    
        if lastButtonWasMode {
            lastButtonWasMode = false
            labelString = "0"
        }
        
            let num = Int(sender.titleLabel!.text!)
            print("\(num!)")
            let myString = String(num!)
            labelString = labelString + myString
            savedNum = Int(labelString)!
            updateText()

    }
    
    
    
    @IBAction func tappedPlus(sender: UIButton) {
        changeMode(modes.ADD)
    }
    
    @IBAction func tappedMinus(sender: UIButton) {
        changeMode(modes.SUB)

    }
    
    @IBAction func tappedEQ(sender: AnyObject) {
        let num = Int(labelString)!
        
        
        if currentMode == modes.ADD{
            savedNum = savedNum + num
        }
        else if currentMode == modes.SUB{
            savedNum = savedNum - num
        }
        
        currentMode = modes.NOT_SET
        labelString = "\(savedNum)"
        updateText()
        lastButtonWasMode = true
    }
    
    func changeMode(newMode: modes){
        if savedNum == 0 {
            return
        }
        currentMode = newMode
        lastButtonWasMode = true
        
    }
    
    
    @IBAction func tappedCleared(sender: UIButton) {
        resetToDefaultCalc()
        updateText()
    }
    
    func resetToDefaultCalc(){
        labelString = "0"
        currentMode = modes.NOT_SET
        savedNum = 0
        lastButtonWasMode = false
    }
    
    
    func updateText(){
        
        let labelInt = Int(labelString)!
        //let myString = String(labelInt)
     
        if currentMode == modes.NOT_SET {
                    savedNum = labelInt
                  }
        let myFormatter = NSNumberFormatter()
        myFormatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
        let num = NSNumber(integer: labelInt)
         label.text = myFormatter.stringFromNumber(num)
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

