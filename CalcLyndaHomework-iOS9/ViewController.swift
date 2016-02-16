//
//  ViewController.swift
//  CalcLyndaHomework-iOS9
//
//  Created by yodyodsmall on 2/14/16.
//  Copyright © 2016 yuryg. All rights reserved.
//

import UIKit
import AVFoundation


enum modes{
    case NOT_SET
    case ADD
    case SUB
    case MULTI
}


class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{
    
    // MARK: Calc Function Related
    // Calc Related  Based on Lynda.com Programming for Non-Programmers: iOS 9.  Thanks!
    
    // Default State Of Calc
    var labelString: String = "0"
    var currentMode: modes = modes.NOT_SET
    var newNum: Int = 0
    var savedNum: Int = 0
    var totalNum: Int = 0
    var lastButtonWasMode: Bool = false
    
    
    
    // MARK: - ViewController Class-Wide Variables
    // MARK: Speach Related
    let mySpeechSynth = AVSpeechSynthesizer()
    var myRate: Float = 0.50
    var myPitch: Float = 1.15
    var myVolume: Float = 0.92
    var currentLang = ("en-US", "English","United States","American English ","🇺🇸")
    

    
    
    
   
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
    @IBAction func tappedMulti(sender: UIButton) {
        changeMode(modes.MULTI)
        print("labelString \(labelString)   newNum \(newNum)  savedNum \(savedNum)  current mode  \(currentMode)")
        
        
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
        
        if currentMode == modes.SUB{
            totalNum = savedNum - num
            print("savedNum \(savedNum) - num \(num)")
            print("= \(totalNum)")
            
            
        }
        
        if currentMode == modes.MULTI{
                totalNum = (savedNum * num)
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


    
    //MARK:   UIPickerView Outlets
    @IBOutlet weak var myLangPicker: UIPickerView!
    
    //MARK: - Speaking Machine
    
    @IBAction func Speak(sender: UIButton) {
    
//     Trigger Equals Mode, that is yet to exist. 
        
        if totalNum == 0 && savedNum == 0 {
            speakThisString(String(newNum))
           
           }
        
        if totalNum == 0 && savedNum != 0  && newNum != savedNum {
            
            speakThisString(String(savedNum))
            
        }
        
        if totalNum != 0 {
        speakThisString(String(totalNum))
        }

    }
    
    
    func speakThisString(passedString: String){
        
        mySpeechSynth.stopSpeakingAtBoundary(AVSpeechBoundary.Immediate)
        
        let myUtterance = AVSpeechUtterance(string: passedString)
        myUtterance.rate = myRate
        myUtterance.pitchMultiplier = myPitch
        myUtterance.volume = myVolume
        myUtterance.voice = AVSpeechSynthesisVoice(language: currentLang.0)
        mySpeechSynth.speakUtterance(myUtterance)
        
        
        
    }

    
    //MARK: - Langugage UIPickerView Methods
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return langCodeAll38.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        
        pickerView.showsSelectionIndicator = true
        
        let myString = "\(langCodeAll38[row].4) \(langCodeAll38[row].3)"
        
        return myString
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currentLang = langCodeAll38[row]
        speakThisString(currentLang.3)
    }
    

    
    
    //MARK: - Data Model
    
    // current lang array has known typos, to fix in future.
    var langCodeAll38 = [
        ("en-US",  "English", "United States", "American English","🇺🇸"),
        ("ar-SA","Arabic","Saudi Arabia","العربية","🇸🇦"),
        ("cs-CZ", "Czech", "Czech Republic","český","🇨🇿"),
        ("da-DK", "Danish","Denmark","Dansk","🇩🇰"),
        ("de-DE",       "German", "Germany", "Deutsche","🇩🇪"),
        ("el-GR",      "Modern Greek",        "Greece","ελληνική","🇬🇷"),
        ("en-AU",     "English",     "Australia","Aussie","🇦🇺"),
        ("en-GB",     "English",     "United Kingdom", "Queen's English","🇬🇧"),
        ("en-IE",      "English",     "Ireland", "Gaeilge","🇮🇪"),
        ("en-ZA",       "English",     "South Africa", "South African English","🇿🇦"),
        ("es-ES",       "Spanish",     "Spain", "Español","🇪🇸"),
        ("es-MX",       "Spanish",     "Mexico", "Español de México","🇲🇽"),
        ("fi-FI",       "Finnish",     "Finland","Suomi","🇫🇮"),
        ("fr-CA",       "French",      "Canada","Français du Canada","🇨🇦" ),
        ("fr-FR",       "French",      "France", "Français","🇫🇷"),
        ("he-IL",       "Hebrew",      "Israel","עברית","🇮🇱"),
        ("hi-IN",       "Hindi",       "India", "हिन्दी","🇮🇳"),
        ("hu-HU",       "Hungarian",    "Hungary", "Magyar","🇭🇺"),
        ("id-ID",       "Indonesian",    "Indonesia","Bahasa Indonesia","🇮🇩"),
        ("it-IT",       "Italian",     "Italy", "Italiano","🇮🇹"),
        ("ja-JP",       "Japanese",     "Japan", "日本語","🇯🇵"),
        ("ko-KR",       "Korean",      "Republic of Korea", "한국어","🇰🇷"),
        ("nl-BE",       "Dutch",       "Belgium","Nederlandse","🇧🇪"),
        ("nl-NL",       "Dutch",       "Netherlands", "Nederlands","🇳🇱"),
        ("no-NO",       "Norwegian",    "Norway", "Norsk","🇳🇴"),
        ("pl-PL",       "Polish",      "Poland", "Polski","🇵🇱"),
        ("pt-BR",       "Portuguese",      "Brazil","Portuguese","🇧🇷"),
        ("pt-PT",       "Portuguese",      "Portugal","Portuguese","🇵🇹"),
        ("ro-RO",       "Romanian",        "Romania","Română","🇷🇴"),
        ("ru-RU",       "Russian",     "Russian Federation","русский","🇷🇺"),
        ("sk-SK",       "Slovak",      "Slovakia", "Slovenčina","🇸🇰"),
        ("sv-SE",       "Swedish",     "Sweden","Svenska","🇸🇪"),
        ("th-TH",       "Thai",        "Thailand","ภาษาไทย","🇹🇭"),
        ("tr-TR",       "Turkish",     "Turkey","Türkçe","🇹🇷"),
        ("zh-CN",       "Chinese",     "China","漢語/汉语","🇨🇳"),
        ("zh-HK",       "Chinese",   "Hong Kong","漢語/汉语","🇭🇰"),
        ("zh-TW",       "Chinese",     "Taiwan","漢語/汉语","🇹🇼")
    ]
    
    
}

