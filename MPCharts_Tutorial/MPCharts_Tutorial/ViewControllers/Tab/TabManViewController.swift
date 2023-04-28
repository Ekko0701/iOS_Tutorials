//
//  TabManViewController.swift
//  MPCharts_Tutorial
//
//  Created by 김동주 on 2023/04/27.
//

import UIKit

import SnapKit
import Then
import Tabman
import Pageboy

class TabManViewController: TabmanViewController {

    var tabbarContainer = UIView().then {
        $0.backgroundColor = .clear
    }
    
    private var viewControllers: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTab()
        configureLayout()
        
        self.dataSource = self
        

        // create bar
        let bar = TMBar.ButtonBar()
        bar.layout.transitionStyle = .snap // 커스텀 해보자
        bar.layout.contentMode = .fit // bar item을 fit하게 만든다
        
        // indicator
        bar.indicator.weight = .light
        bar.indicator.tintColor = .black
        bar.indicator.overscrollBehavior = .compress
        
        bar.backgroundView.style = .blur(style: .regular)
        bar.layout.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        // add to view
        addBar(bar, dataSource: self, at: .custom(view: tabbarContainer, layout: nil))
        //addBar(bar, dataSource: self, at: .top)
    }
    
    private func configureTab() {
        let yesterdayViewController = YesterdayViewController()
        let weekViewController = WeekViewController()
        let monthViewController = MonthViewController()
        
        viewControllers.append(yesterdayViewController)
        viewControllers.append(weekViewController)
        viewControllers.append(monthViewController)
    }
}

extension TabManViewController {
    private func configureLayout() {
        view.addSubview(tabbarContainer)
        
        tabbarContainer.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview()
        }
    }
}

extension TabManViewController: PageboyViewControllerDataSource, TMBarDataSource {
    func numberOfViewControllers(in pageboyViewController: Pageboy.PageboyViewController) -> Int {
        return viewControllers.count
    }
    
    func viewController(for pageboyViewController: Pageboy.PageboyViewController, at index: Pageboy.PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: Pageboy.PageboyViewController) -> Pageboy.PageboyViewController.Page? {
        return nil
    }
    
    func barItem(for bar: Tabman.TMBar, at index: Int) -> Tabman.TMBarItemable {
        switch index {
        case 0:
            return TMBarItem(title: "어제")
        case 1:
            return TMBarItem(title: "1주")
        case 2:
            return TMBarItem(title: "1달")
        default:
            let title = "Page \(index)"
            return TMBarItem(title: title)
        }
    }
}
    
