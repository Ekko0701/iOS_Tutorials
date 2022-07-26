//
//  SecondPopUpViewController.swift
//  PopUpView_Tutorial
//
//  Created by Ekko on 2022/07/24.
//

import UIKit

class SecondPopUpViewController: ViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var popUpView: UIView!
    
    var time: String = "0 : 0"
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.7)

    }
    @IBAction func dismissButton(_ sender: Any) {
        print("Dismiss Button Tapped !")
        dismiss(animated: true, completion: nil)
    }
    @IBAction func ApplyButton(_ sender: Any) {
        print("Apply Button Tapped !")
        print("Apply Button: \(time)")
        dismiss(animated: true, completion: nil)
    }
    @IBAction func pickerAction(_ sender: UIDatePicker) {
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = .none
        dateformatter.timeStyle = .short
        time = dateformatter.string(from: datePicker.date)
        print(time)
    }
    
}
//어제 누워가지고 어쩌구
//ㅇㅇㅇ
//근데 ?
//피가 있잔ㅇㅎ아 순환이 안돼 ㅇㅇ
//그래서 어쩌구 저쩌구 쏼라쏼라
