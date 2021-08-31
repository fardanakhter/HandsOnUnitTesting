//
//  ViewController.swift
//  HandsOnUnitTesting
//
//  Created by Fardan Akhter on 8/28/21.
//

import UIKit


// This sample project is prepared by studying this link from Raywander Rich:
// https://www.raywenderlich.com/21020457-ios-unit-testing-and-ui-testing-tutorial#toc-anchor-017


class ViewController: UIViewController {
    
    var defaults: UserDefaults! = UserDefaults.standard
    
    // DataModel Example
    var counterValue: Int {
        get{
            defaults.integer(forKey: "counterValue")
        }
        set{
            defaults.setValue(newValue, forKey: "counterValue")
        }
    }
    
    @IBOutlet weak var counterLbl: UILabel?
   
    @IBOutlet weak var pressBtn: UIButton!
    
    @objc @IBAction func pressButton(_ sender: Any) {
        counterValue += 1
        mapValueToUI()
    }
    
    func mapValueToUI(){
        counterLbl?.text = "\(counterValue)"
    }
    
    func resetData(){
        counterValue = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetData()
        mapValueToUI()
    }
}

