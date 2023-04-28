//
//  MarkerView.swift
//  MPCharts_Tutorial
//
//  Created by 김동주 on 2023/04/28.
//

import UIKit

import SnapKit
import Then
import Charts

class CustomMarkerView: MarkerView {
    let containerView = UIView().then {
        $0.backgroundColor = .systemPink
    }
    
    let stackView = UIStackView().then {
        $0.backgroundColor = .systemYellow
        $0.axis = .vertical
    }
    
    let dateLabel = UILabel().then {
        $0.text = "타이틀"
    }
    
    let studyTimeLabel = UILabel().then {
        $0.text = "서브타이틀"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureStyle()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureStyle() {
        self.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        self.backgroundColor = .orange
        self.layer.cornerRadius = 5
    }
    
    private func configureLayout() {
        self.addSubview(containerView)
        self.addSubview(stackView)
        
        stackView.addArrangedSubview(dateLabel)
        stackView.addArrangedSubview(studyTimeLabel)
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        containerView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(8)
            make.bottom.trailing.equalToSuperview().offset(-8)
        }
    }
}
