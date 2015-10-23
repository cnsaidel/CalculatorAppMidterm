//
//  ViewController.swift
//  Calculator
//
//  Created by Charles Saidel on 10/16/15.
//  Copyright (c) 2015 LDC. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    
    //Speech to Text Class
    let mySpeechSynth = AVSpeechSynthesizer()
    
    
    //Used to hold numeric values entered
    var total:Int = 0
    
    //Holds whether user is adding, subtracting, multiplying or dividing
    var mode:Int = 0
    
    
    //Language Counter
    var langChosen:Int = 0
    
    
    //Use to check if equal button has been pressed
    var totalEquals:Bool = false
    
    //this variable has the possibility of being null (no value)
    //The string version of the total
    var valueString:String! = ""
    
    
    
    var currentLang = ("en-US", "English","United States","American English ","🇺🇸")
    
    
    
    
    //Stores if mode button (+/-) was last button pressed
    var lastButtonWasMode:Bool = false
    @IBOutlet weak var label: UILabel!
    

    
    //MARK - Data Model
    
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
    

    //MARK - UIPickerView Methods

    
    //Language Picker (Change Languages)
    
    //Add in LangCode38 here
    @IBOutlet weak var pickerView: UIPickerView!

    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return langCodeAll38.count
    }
    
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        let myString = "\(langCodeAll38[row].4) \(langCodeAll38[row].3)"
        
        return myString
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currentLang = langCodeAll38[row]
        speakThisPhrase(currentLang.3)
    }
    
    
    
    
    
    
    
    //Day and Night button

 
        

        
        
    @IBOutlet weak var mySwitcher: UISwitch!
        
        
    @IBAction func myDay(sender: AnyObject) {
        
                println("Switched")
                changeBackground()
        
        
    }
    
    
    

    
    
    //problem not switching back to day
    func changeBackground() {
        if mySwitcher.on {
            self.view.backgroundColor = UIColor.whiteColor()
            return
        }
        else
        {
            self.view.backgroundColor = UIColor.blackColor()
            return
        }
        
     
        
    }
    
    

    
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pickerView.dataSource = self;
        self.pickerView.delegate = self;
        
        // Welcome message
        let welcome = AVSpeechUtterance(string:    "blah, blah blah, blah, blah blah")
        welcome.voice = AVSpeechSynthesisVoice(language: "en-GB")
        mySpeechSynth.speakUtterance(welcome)
 
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Speaking Function
    // Pass a String, This Function Speaks it.
    func speakThisPhrase(passedString: String){
        let myUtterance = AVSpeechUtterance(string: passedString)
        myUtterance.rate = 0.2
        myUtterance.pitchMultiplier = 0.9
//        myUtterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
        myUtterance.voice = AVSpeechSynthesisVoice(language: currentLang.0)
        mySpeechSynth.speakUtterance(myUtterance)
    
    }
    

    
    
    @IBAction func tappedNumber(sender: UIButton) {
        
    
        
        sender.backgroundColor.blueColor()
        
        
        //edge case.
        //NEVER EVER EVER PUT THIS AT THE END. IT WONT WORK
        if totalEquals {
            totalEquals = false;
            valueString = ""
        }
        
        
        
        //accessing the label that contains the text in the button
        //using sender.titelLabel.text
        var str:String! = sender.titleLabel!.text
        
        //converting text to number
        //! = implicitly unwrapped optional (Technical Term)
        var num:Int! = str.toInt()
        if (num == 0 && total == 0)
        {
            return
        }
        if (lastButtonWasMode)
        {
            lastButtonWasMode = false
            valueString = ""
        }
        valueString = valueString.stringByAppendingString(str)
        
        let formatter:NSNumberFormatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
        let n:NSNumber = formatter.numberFromString(valueString)!
        
        label.text = formatter.stringFromNumber(n)
        
        if(total == 0){
            
            total = valueString.toInt()!
            
        }
        
        speakThisPhrase(valueString);
        
    }
    
    //MARK: - Math Operators
    @IBAction func tappedPlus(sender: AnyObject) {
        self.setModeOne(1)
        speakThisPhrase("plus")
    }
    
    @IBAction func tappedMinus(sender: AnyObject) {
        self.setModeOne(-1)
        speakThisPhrase("minus")
    }

    @IBAction func tappedMultiply(sender: AnyObject) {
        self.setModeOne(2)
        speakThisPhrase("times")
    }
    
    @IBAction func tappedEquals(sender: AnyObject) {
        if (mode == 0)
        {
            return
        }
        var iNum:Int = valueString.toInt()!
        //check to see if mode is equal to 1 (Plus button)
        if(mode == 1){
            total += iNum
            
        }
        //check to see if mode is equal to -1 (Minus button)
        
        if( mode == -1){
            total -= iNum
            
        }
        
        
        //check to see if mode is equal to 2 (Multiply button)
        
        if( mode == 2){
            total *= iNum
            
        }
        
        valueString = "\(total)"
        let formatter:NSNumberFormatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
        let n:NSNumber = formatter.numberFromString(valueString)!
        
        label.text = formatter.stringFromNumber(n)
        mode = 0
        
        
        if (total > 100000000) {
            speakThisPhrase("dude that's way too big")
        } else {
            speakThisPhrase("equals" + valueString)
        }
        
        totalEquals = true;
    }
    
    @IBAction func tappedClear(sender: AnyObject) {
        total = 0
        mode = 0
        valueString = ""
        label.text = "0"
        lastButtonWasMode = false
    }
    
    //MARK: - Set Mode
    //Set mode to addtion or subtraction
    func setModeOne(m:Int){
        //check if total is equal to 0
        
        if(total == 0){
            return
        }
        
        //sets mode to -1 or 1
        mode = m
        lastButtonWasMode = true
        total = valueString.toInt()!
        
    }
}

