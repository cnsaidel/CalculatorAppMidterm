//
//  ViewController.swift
//  buttonTest
//
//  Created by Charles Saidel on 10/28/15.
//  Copyright (c) 2015 Charles Saidel. All rights reserved.
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

    
    
    
    @IBOutlet weak var myButton: UIButton!
    
    
    @IBAction func touchDown(sender: UIButton) {
    
        sender.backgroundColor = UIColor.greenColor()

        
    }
    
    
    
    
    @IBAction func touchUp(sender: UIButton) {
        
        sender.backgroundColor = UIColor.blueColor()
        
    }
    

}

