//
//  ViewController.swift
//  PopUpView_Tutorial
//
//  Created by Ekko on 2022/07/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var popUpButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    @IBAction func didTapPopUpButton(_ sender: Any) {
        print("Button Tapped")
        
        let popUpViewController = PopUpViewController()
        
        popUpViewController.modalPresentationStyle = .overCurrentContext
        present(popUpViewController, animated: true, completion: nil)
        
    }
    
    @IBAction func didTapPopButton2(_ sender: Any) {
        print("Button2 Tapped")
        
        let popUpViewController = SecondPopUpViewController()
        popUpViewController.modalPresentationStyle = .overCurrentContext
        present(popUpViewController, animated: true,completion: nil)
    }
    
}

