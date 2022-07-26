//
//  ViewController.swift
//  DatePicker_Tutorial


import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    
    var timer = Timer()
    var timerSeconds = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.datePickerMode = .countDownTimer
        
    }
    
    @IBAction func pickerValueChanged(_ sender: UIDatePicker) {
        let picker = sender
        timerSeconds = picker.countDownDuration
        timerLabel.text = String(Int(timerSeconds))
    }
    
    @IBAction func tappedStartButton(_ sender: UIButton) {
        print("Tapped Start Button - Start Timer !")
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
    }
    
    @IBAction func tappedCancelButton(_ sender: UIButton) {
        print("Tapped Cancel Button - Cancel Timer !")
        timer.invalidate()
    }
    
    @objc func fireTimer() {
        timerSeconds -= 1
        timerLabel.text = String(Int(timerSeconds))
        
        if( timerSeconds == 0 ) {
            timer.invalidate()
        }
    }
}















