//
//  ViewController.swift
//  MPCharts_Tutorial
//
//  Created by 김동주 on 2023/04/27.
//

import UIKit

import SnapKit
import Then
import Charts

class ViewController: UIViewController {
    // MARK: UIViews
    private let infoView = UIView().then {
        $0.backgroundColor = .black
    }
    
    private lazy var tabbarContainerView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    private var barchartView = BarChartView().then {
        $0.noDataText = "Empty Data"
        $0.noDataFont = .systemFont(ofSize: 20)
        $0.noDataTextColor = .lightGray
        $0.backgroundColor = .systemGreen
    }
    
    private var infoView2 = UIView().then {
        $0.backgroundColor = .systemMint
    }
    
    // MARK: Properties
    let chartTabView: TabManViewController = TabManViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureStyle()
        configureLayout()
    }
    
    //MARK: - Configure Charts
    
}

//MARK: - Configure
extension ViewController {
    private func configureStyle() {
        view.backgroundColor = .white
    }
    
    private func configureLayout() {
        self.view.addSubview(infoView)
        addChild(chartTabView)
        self.view.addSubview(chartTabView.view)
        self.view.addSubview(barchartView)
        self.view.addSubview(infoView2)
        
        infoView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(infoView.snp.width).multipliedBy(0.1)
        }
        
        chartTabView.view.snp.makeConstraints { make in
            make.top.equalTo(infoView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(infoView2.snp.top)
        }
        
        infoView2.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(infoView2.snp.width).multipliedBy(0.6)
        }
    }
}

