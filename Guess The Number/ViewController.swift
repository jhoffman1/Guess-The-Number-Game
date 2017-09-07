//
//  ViewController.swift
//  Guess The Number
//
//  Created by Jessica Hoffman on 9/5/17.
//  Copyright © 2017 Jessica Hoffman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var guessLabel: UILabel!
    @IBOutlet weak var guessTextField: UITextField!
    @IBOutlet weak var guessButton: UIButton! //how to delete this?
    
    
    let lowerBound = 1
    let upperBound = 100
    var numberToGuess: Int! //pretend that everytime i use this value that it has a value even though I'm not giving it right now
    var numberOfGuesses = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        numberToGuess = generateRandomNumber() //now assigning value
    }

    func generateRandomNumber() -> Int { //no parameters, returns an int
        return Int(arc4random_uniform(UInt32(upperBound))) + lowerBound //random number in swift between 1 and 100, by default gives 0 and 99
    }

    @IBAction func buttonPressed(_ sender: Any) {
        
        if let guess = guessTextField.text { //if it's not nil assign to guess
            if let numberGuess = Int(guess) {
                numberOfGuesses += 1
                print(guess)
                validateGuess(numberGuess)
            }
        }
        guessTextField.text = ""
    }
    
    func validateGuess(_ guess:Int) { //argument label is first, parameter label is second, return type third
        // explain underscore again?
        if guess < lowerBound || guess > upperBound {
            guessLabel.text = "Guess out of range"
        } else if guess < numberToGuess {
            guessLabel.text = "Guess Higher! ⬆️" //control-command space for emojis
        } else if guess > numberToGuess {
            guessLabel.text = "Guess Lower! ⬇️"
        } else {
            showWinAlert()
        }
    }
    
    func showWinAlert() {
        let alert = UIAlertController(title: "Congrats! 👏", message: "You won after only \(numberOfGuesses) guesses.", preferredStyle: .alert)
        let action = UIAlertAction(title: "Play Again", style: .default, handler: { _ in
            
            self.guessLabel.text = "Guess the Number"
            self.numberOfGuesses = 0
            self.numberToGuess = self.generateRandomNumber()
        
        }) //could also make the handler self.alertHandler too
        
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil) //saying completion nil says go away after complete
        
    }
    
    func alertHandler(action: UIAlertAction) -> Void {
        print("action pressed")
    }

}

