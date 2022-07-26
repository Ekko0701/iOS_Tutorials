//
//  PopUpViewController.swift
//  PopUpView_Tutorial
//
//  Created by Ekko on 2022/07/24.
//

import UIKit

final class PopUpViewController: ViewController {

    private let popUpView = UIView()
    private let dismissButton = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()

        // SetUp View
        view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        
        // SetUp PopUpView
        popUpView.backgroundColor = UIColor.yellow
        view.addSubview(popUpView)
        
        // SetUpDismiss Button
                dismissButton.setTitleColor(UIColor.blue, for: .normal)
                dismissButton.setTitle("Dismiss", for: .normal)
                dismissButton.addTarget(self, action: #selector(didTapDismissButton(_:)), for: .touchUpInside)
                popUpView.addSubview(dismissButton)
                
                // PopUpView AutoLayout
                popUpView.translatesAutoresizingMaskIntoConstraints = false
                popUpView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
                popUpView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
                popUpView.widthAnchor.constraint(equalToConstant: 200).isActive = true
                popUpView.heightAnchor.constraint(equalToConstant: 200).isActive = true
                
                // DismissButton AutoLayout
                dismissButton.translatesAutoresizingMaskIntoConstraints = false
                dismissButton.bottomAnchor.constraint(equalTo: popUpView.bottomAnchor).isActive = true
                dismissButton.leadingAnchor.constraint(equalTo: popUpView.leadingAnchor).isActive = true
                dismissButton.trailingAnchor.constraint(equalTo: popUpView.trailingAnchor).isActive = true
                dismissButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    @objc func didTapDismissButton(_ sender: UIButton) {
            dismiss(animated: true, completion: nil)
        }
}
