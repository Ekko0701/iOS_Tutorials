//
//  YesterdayViewController.swift
//  MPCharts_Tutorial
//
//  Created by 김동주 on 2023/04/27.
//

import UIKit

import SnapKit
import Then
import Charts

class YesterdayViewController: UIViewController, ChartViewDelegate {
    // MARK: UIViews
    private let barSpaceView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    private let totalInfoView = UIView().then {
        $0.backgroundColor = .systemGray
    }
    
    private let infoLabel = UILabel().then {
        $0.text = "인포메이션 입니다."
    }
    
    private let chartView = BarChartView().then {
        $0.noDataText = "데이터가 없습니다."
        $0.noDataFont = .systemFont(ofSize: 20)
        $0.noDataTextColor = .lightGray
        $0.backgroundColor = .clear
    }
    
    let customMarkerView = CustomMarkerView()
    
    // MARK: Properties
    let dayData: [String] = ["그저께", "어제"]
    let studyData: [Double] = [95.0, 130.0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureStyle()
        configureLayout()
        configureChart()
        configureMarker()
        
        self.setBarData(barChartView: self.chartView, barChartDataEntries: self.entryData(dayData: dayData, values: studyData))
    }

    /**
     Entry 생성 함수
     */
    func entryData(dayData: [String], values: [Double]) -> [BarChartDataEntry] {
        var barDataEntries: [BarChartDataEntry] = []
        for i in 0 ..< values.count {
            let barDataEntry = BarChartDataEntry(x: Double(i), y: values[i])
            barDataEntries.append(barDataEntry)
        }
        return barDataEntries
    }
    
    /**
     데이터 설정
     */
    func setBarData(barChartView: BarChartView, barChartDataEntries: [BarChartDataEntry]) {
        let barChartdataSet = BarChartDataSet(entries: barChartDataEntries, label: "분")
        
        // 차트 색상 설정
        barChartdataSet.colors = [.systemPurple]
        // 막대 선택 설정
        //barChartdataSet.highlightEnabled = false
        // 막대 선택시 줌 설정
        //chartView.doubleTapToZoomEnabled = false
        
        // 데이터 삽입
        let barChartData = BarChartData(dataSet: barChartdataSet)
        barChartView.data = barChartData
    }
    
    // Options
    func configureChart() {
        chartView.delegate = self
        
        // Highlight
        chartView.highlightPerTapEnabled = true
        chartView.highlightFullBarEnabled = true
        chartView.highlightPerDragEnabled = false
        
        // disable zoom function
        chartView.pinchZoomEnabled = false
        chartView.setScaleEnabled(false)
        chartView.highlightPerDragEnabled = false
        
        // Bar, Grid Line, Background
        chartView.drawBarShadowEnabled = false // 그래프에 빈 공간에 그림자 추가
        chartView.drawGridBackgroundEnabled = false // 배경에 그림자 추가
        
        // Legend
        chartView.legend.enabled = false
        
        // Chart Offset
        chartView.setExtraOffsets(left: 10, top: 0, right: 20, bottom: 50)
        
        // Animation
        chartView.animate(yAxisDuration: 2, easingOption: .easeInOutCubic)
        
        // Setup X axis
        let xAxis = chartView.xAxis
        xAxis.labelPosition = .bottom
        xAxis.drawAxisLineEnabled = true
        xAxis.drawGridLinesEnabled = true
        //xAxis.granularityEnabled = true
        xAxis.labelRotationAngle = -25
        xAxis.setLabelCount(studyData.count, force: false) // 라벨 갯수 설정
        xAxis.valueFormatter = IndexAxisValueFormatter(values: dayData) // x측 라벨 포멧 변경
        //xAxis.axisMaximum = Double(dayData.count)
        xAxis.axisLineColor = .systemGreen
        xAxis.labelTextColor = .systemRed
        
        // Setup left axis
        let leftAxis = chartView.leftAxis
        leftAxis.drawTopYLabelEntryEnabled = true
        leftAxis.drawAxisLineEnabled = true
        leftAxis.drawGridLinesEnabled = false
        leftAxis.granularityEnabled = false
        leftAxis.axisLineColor = .systemBlue
        leftAxis.labelTextColor = .systemYellow
        
        leftAxis.setLabelCount(6, force: true)
        leftAxis.axisMinimum = 0
        leftAxis.axisMaximum = 250
        
        // Remove right axis
        let rightAxis = chartView.rightAxis
        rightAxis.enabled = false
        
        // Setup replacement rate line
        let replacementScore = 80.0
        
        let replacementRateLine = ChartLimitLine()
        replacementRateLine.limit = replacementScore
        replacementRateLine.lineColor = .systemMint
        replacementRateLine.valueTextColor = .systemRed
        replacementRateLine.label = "Population Replacement Rate: \(replacementScore)"
        replacementRateLine.labelPosition = .leftTop
        leftAxis.addLimitLine(replacementRateLine)
        
        // Setup high income average line
        let highInComeAbg = 150.0
        
        let highIncomeAverageLine = ChartLimitLine()
        highIncomeAverageLine.limit = highInComeAbg
        highIncomeAverageLine.lineColor = .systemGreen
        highIncomeAverageLine.valueTextColor = .systemGreen
        highIncomeAverageLine.label = "Average (High Income): \(highInComeAbg)"
        highIncomeAverageLine.labelPosition = .leftBottom
        leftAxis.addLimitLine(highIncomeAverageLine)
    }
    
    // MARK: - Chart Delegate Methods
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        guard let dataSet = chartView.data?.dataSets[highlight.dataSetIndex] else { return }
        let entryIndex = dataSet.entryIndex(entry: entry)
        
        //customMarkerView.dateLabel.text = "\(dayData[entryIndex])"
        //customMarkerView.studyTimeLabel.text = "\(studyData[entryIndex])"
        customMarkerView.dateLabel.text = "냠냠"
        customMarkerView.studyTimeLabel.text = "옴뇸뇸"
        print("Chart bar is selected")
    }
}

extension YesterdayViewController {
    private func configureMarker() {
        customMarkerView.chartView = chartView
        chartView.marker = customMarkerView
    }
}

extension YesterdayViewController {
    private func configureStyle() {
        
    }
    
    private func configureLayout() {
        self.view.addSubview(barSpaceView)
        self.view.addSubview(totalInfoView)
        totalInfoView.addSubview(infoLabel)
        self.view.addSubview(chartView)
        
        barSpaceView.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        totalInfoView.snp.makeConstraints { make in
            make.top.equalTo(barSpaceView.snp.bottom)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
        }
        
        infoLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        chartView.snp.makeConstraints { make in
            make.top.equalTo(totalInfoView.snp.bottom)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.bottom.equalToSuperview().offset(-48)
        }
    }
}

