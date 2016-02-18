//
//  ViewController.swift
//  Calculator
//
//  Created by Hunter Lynch on 2/9/16.
//  Copyright © 2016 Hunter Lynch. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleOfTypingANumber = false
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            display.text = display.text! + digit
        } else {
            display.text = digit
            userIsInTheMiddleOfTypingANumber = true
        }
    }

    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        switch operation {
        case "×": preformOperation { $0 * $1 }
        case "÷": preformOperation { $0 / $1 }
        case "+": preformOperation { $0 + $1 }
        case "−": preformOperation { $1 - $0 }
        case "√": preformsOperation { sqrt($0) }
        case "sin": preformsOperation{ sin($0) }
        case "cos": preformsOperation{ cos($0) }
        //case "∏": preformsOperation{ M_PI($0) }
        default: break
        
            }
    }
    
    func preformOperation(operation: (Double,Double) -> Double) {
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    func preformsOperation(operation: Double -> Double) {
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }


    
    var operandStack = Array<Double>()
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        operandStack.append(displayValue)
    }

    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set{
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
        }
    }
}

