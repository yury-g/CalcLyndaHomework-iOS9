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
    case MULTI
}


class ViewController: UIViewController {
    
    // Default State Of Calc
    var labelString: String = "0"
    var currentMode: modes = modes.NOT_SET
    var newNum: Int = 0
    var savedNum: Int = 0
    var totalNum: Int = 0
    var lastButtonWasMode: Bool = false
   
    @IBOutlet weak var label: UILabel!
    
    @IBAction func tappedNumber(sender: UIButton) {

        if lastButtonWasMode {
            lastButtonWasMode = false
            labelString = "0"
        }
        
        let onScreenNum = Int(sender.titleLabel!.text!)
        newNum = onScreenNum!
        
        print("newNum is \(newNum)")
        
        
        let myString = String(newNum)
        labelString = labelString + myString
        newNum = Int(labelString)!  // My Code
        
        
       print("savedNum\(savedNum)"+"     current mode  \(currentMode)  newNum \(newNum)  total \(totalNum)  ")
        updateText(newNum)
       
    }
    
    @IBAction func tappedPlus(sender: UIButton) {
        print("labelString \(labelString)"+"  modes  ?"+"  savedNum  \(savedNum)"+"     current mode  \(currentMode)" + "  LastButtonWasMode")

        changeMode(modes.ADD)
        
    }
    
    @IBAction func tappedMinus(sender: UIButton) {
        changeMode(modes.SUB)
        print("labelString \(labelString)"+"  modes  ?"+"  savedNum  \(savedNum)"+"     current mode  \(currentMode)" + "  LastButtonWasMode")


    }
    
    @IBAction func tappedEQ(sender: AnyObject) {
        print("labelString \(labelString)  savedNum\(savedNum)"+"     current mode  \(currentMode)" + "  newNum\(newNum)")

        let num = newNum
        
        if currentMode == modes.NOT_SET || lastButtonWasMode{
            return   // exits func tappedEQ()
        }
        
        
        if currentMode == modes.ADD{
            totalNum = savedNum + num
            print("savedNum \(savedNum) + num \(num)")
            print("= \(totalNum)")
            
        }
        else if currentMode == modes.SUB{
            totalNum = savedNum - num
            print("savedNum \(savedNum) - num \(num)")
            print("= \(totalNum)")
            
            
        } else if currentMode == modes.MULTI{
                totalNum = savedNum * num
                print("savedNum \(savedNum) * num \(num)")
                print("= \(totalNum)")
            
            }
        
      
        currentMode = modes.NOT_SET
        labelString = "\(totalNum)"
        updateText(totalNum)
        lastButtonWasMode = true

        print("labelString \(labelString)  savedNum\(savedNum)"+"     current mode  \(currentMode)  newNum \(newNum)  total \(totalNum)  ")

    }
    
    func changeMode(newMode: modes){
        if newNum == 0 {
            return
        }
        savedNum = newNum
        currentMode = newMode
        lastButtonWasMode = true
        
        print("newNum \(newNum)  \(currentMode) savedNum \(savedNum)   ")

    }
    
    
    @IBAction func tappedCleared(sender: UIButton) {
        resetToDefaultCalc()
        updateText(0)
    }
    
    func resetToDefaultCalc(){
        savedNum = 0
        newNum = 0
        totalNum = 0
        labelString = "0"
        label.text = "0"
        currentMode = modes.NOT_SET
        lastButtonWasMode = false
    }
    
    func updateText(passedInt: Int){
        
        let labelInt = passedInt
     
        if currentMode == modes.NOT_SET {
                    newNum = labelInt
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

