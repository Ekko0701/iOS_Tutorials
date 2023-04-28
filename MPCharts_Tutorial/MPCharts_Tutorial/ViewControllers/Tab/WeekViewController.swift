//
//  WeekViewController.swift
//  MPCharts_Tutorial
//
//  Created by 김동주 on 2023/04/27.
//

import UIKit

import SnapKit
import Then

class WeekViewController: UIViewController {

    private let topLabel = UILabel().then {
        $0.text = "상단"
    }
    
    private let bottomLabel = UILabel().then {
        $0.text = "하단"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGreen
        
        configureStyle()
        configureLayout()
    }
    
    private func configureStyle() {
        
    }
    
    private func configureLayout() {
        view.addSubview(topLabel)
        view.addSubview(bottomLabel)
        
        topLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.leading.trailing.equalToSuperview()
        }
        
        bottomLabel.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview()
        }
    }

}
