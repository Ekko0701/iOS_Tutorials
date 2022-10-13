//
//  ViewController.swift
//  Sheet_Tutorial
//
//  Created by Ekko on 2022/10/13.
//

import UIKit
import PhotosUI

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, PHPickerViewControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Custom Sheet"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showImagePicker))
    }
    
    @objc
    func showImagePicker() {
        var configuration = PHPickerConfiguration()
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        
        // Get a sheet
        if let sheet = picker.sheetPresentationController {
            //Customize the sheet
            sheet.detents = [
                .medium(),
                .large(),
            ]
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.largestUndimmedDetentIdentifier = .medium
            sheet.prefersGrabberVisible = true // grabber visible
            sheet.preferredCornerRadius = 24.0 // set corner Radius
        }
        present(picker, animated: true)
    }
    
    // 이미지 선택을 종료했을때 호출
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        if let sheet = picker.sheetPresentationController {
            sheet.animateChanges {
                sheet.selectedDetentIdentifier = .medium
            }
        }
    }
    
    // Cancel 버튼 선택시 호출
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}


class SheetViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
    }
}



