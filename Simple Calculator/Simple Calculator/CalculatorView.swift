//
//  CalculatorView.swift
//  Simple Calculator
//  
//  A simple binary calculator that resembles the Apple default calculator app, but includes the mod function!
//
//  Created by Kyle Haptonstall on 1/7/16.
//  Copyright © 2016 Kyle Haptonstall. All rights reserved.
//

import Foundation
import UIKit

class CalculatorView: UIViewController{
    
    // MARK: - Class Variables
    var lhs: Double?
    
    var isTyping = true
    var decimalUsed = false
    
    
    enum Operators{
        case Add, Subtract, Multiply, Divide, Mod
    }
    var currentOperator: Operators?

    // MARK: - Display Label
    @IBOutlet weak var displayNumber: UILabel!
    
    
    // MARK: - Clearing
    
    /**
        Clears the current display and resets all class variables to defaults
    
        - parameter sender:     The clear button
    */
    @IBAction func clear(sender: UIButton) {
        displayNumber.text = "0"
        lhs = nil
        isTyping = true
        currentOperator = nil
        decimalUsed = false
    }
    
    /**
        Removes one character from the end of the display label
     
        - parameter sender:     The backspace button
     */
    @IBAction func backspace(sender: UIButton) {
        if displayNumber.text != "0" && displayNumber.text?.characters.count >= 2{
            displayNumber.text = String(displayNumber.text!.characters.dropLast())
        }
        else if displayNumber.text != "0" && displayNumber.text?.characters.count == 1{
            displayNumber.text = "0"
        }
    }
    
    
    // MARK: - Number Pad
    
    /**
        Appends the number pressed to the end of the current number display, limit of 9 digit numbers
    
        - parameter sender:     One of the number buttons from the number pad or the decimal button
    */
    @IBAction func numberPressed(sender: UIButton) {
        if sender.titleLabel?.text == "."{
            if decimalUsed == false{
                decimalUsed = true
                displayNumber.text = displayNumber.text! + (sender.titleLabel?.text!)!
            }
        }
        else if displayNumber.text == "0"{
         displayNumber.text = sender.titleLabel?.text
        }
        else if !isTyping{
            isTyping = true
            displayNumber.text = sender.titleLabel?.text
        }
        else{
            if displayNumber.text?.characters.count < 9{
                displayNumber.text = displayNumber.text! + (sender.titleLabel?.text!)!
            }
            
        }
    }
    
    
    // MARK: - Operators
    /**
        Sets the current operator to the one pressed. Sets the isTyping variable to false which allows
        the user to begin a new number on the next number pad press
    
        - parameter sender:     One of the operator buttons
    */
    @IBAction func operatorPressed(sender: UIButton) {
        let op = sender.titleLabel?.text
        
        if op == "+/-" && displayNumber.text != "0"{
            if displayNumber.text?.characters.first == "-"{
                displayNumber.text = String(displayNumber.text?.characters.dropFirst())
            }
            else{
                displayNumber.text = "-\(displayNumber.text)"
            }
        }
        else if op != "+/-" && currentOperator == nil{
            isTyping = false
            decimalUsed = false
            if lhs == nil {
                lhs = NSNumberFormatter().numberFromString(displayNumber.text!)?.doubleValue
            }
            
            switch op!{
            case "+":
                currentOperator = Operators.Add
            case "-":
                currentOperator = Operators.Subtract
            case "x":
                currentOperator = Operators.Multiply
            case "/":
                currentOperator = Operators.Divide
            case "%":
                currentOperator = Operators.Mod
            default:
                break
            }
        }
 
    }
    
    
    // MARK: - Equals
    @IBAction func equals(sender: AnyObject) {
        let rhs = NSNumberFormatter().numberFromString(displayNumber.text!)!.doubleValue
        var result: Double
        if currentOperator != nil{
            switch currentOperator!{
            case .Add:
                result = lhs! + rhs
            case .Subtract:
                result = lhs! - rhs
            case .Multiply:
                result = lhs! * rhs
            case .Divide:
                result = lhs! / rhs
            case .Mod:
                result = lhs! % rhs
            }
            displayNumber.text = String(result)
        }
    }
    

}