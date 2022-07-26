//
//  ViewController.swift
//  Activity_Ring_Animation_Tutorial
//
//  Created by Ekko on 2022/07/21.
//

import UIKit

class ViewController: UIViewController {

    let shape = CAShapeLayer()
    var timer: Int = 0
    var animationIsRunning = false
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "0"
        label.font = .systemFont(ofSize: 36, weight: .light)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.sizeToFit()
        view.addSubview(label)
        label.center = view.center
        
        //Create Circle
        let circlePath = UIBezierPath(arcCenter: view.center,
                                      radius: 150,
                                      startAngle: -(.pi / 2),
                                      endAngle: .pi * 2,
                                      clockwise: true)
        
        let trackShape = CAShapeLayer()
        trackShape.path = circlePath.cgPath
        trackShape.fillColor = UIColor.clear.cgColor
        trackShape.lineWidth = 15
        trackShape.strokeColor = UIColor.lightGray.cgColor
        view.layer.addSublayer(trackShape) // add layer
        
        
        shape.path = circlePath.cgPath
        shape.lineWidth = 15 // border line
        shape.strokeColor = UIColor.blue.cgColor
        
        shape.strokeEnd = 0
        
        shape.fillColor = UIColor.clear.cgColor
        
        view.layer.addSublayer(shape) // add layer
        
        let button = UIButton(frame: CGRect(x: 20, y: view.frame.size.height - 70, width: view.frame.size.width - 40, height: 50))
        view.addSubview(button)
        button.setTitle("Animate", for: .normal)
        button.backgroundColor = .systemGreen
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
        let button2 = UIButton(frame: CGRect(x: 20, y: view.frame.size.height - 130, width: view.frame.size.width - 40, height: 50))
        view.addSubview(button2)
        button2.setTitle("Pause & Restart", for: .normal)
        button2.backgroundColor = .systemRed
        button2.addTarget(self, action: #selector(pauseAnimation), for: .touchUpInside)
        
                            
                              
                              
    }
    //https://yungsoyu.medium.com/core-animation%EC%9D%98-%EA%B8%B0%EB%B3%B8-cabasicanimation-%ED%8A%9C%ED%86%A0%EB%A6%AC%EC%96%BC-b9f8a3b41cf7
    @objc func didTapButton () {
        //Animaite
        timer = 0
        animationIsRunning = true
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue = 1
        animation.duration = 3
        animation.isRemovedOnCompletion = false // Animation이 끝나도 사라지지 않도록 한다.
        animation.fillMode = .forwards // Animation의 마지막 프레임을 화면에 유지한다.
        
        shape.add(animation,forKey: "animation")
        
    }
    
    //https://gist.github.com/nazywamsiepawel/e462193f299187d0fc8e
    @objc func pauseAnimation() {
        if animationIsRunning {
            print("Pause the Animation")
            let pausedTime = shape.convertTime(CACurrentMediaTime(), from: nil)
            shape.speed = 0.0
            shape.timeOffset = pausedTime
            
            animationIsRunning = false
        } else {
            print("Restart the Animation")
            let pausedTime = shape.timeOffset
            shape.speed = 1.0
            shape.timeOffset = 0.0
            shape.beginTime = 0.0
            let timeSincePause = shape.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
            shape.beginTime = timeSincePause
            animationIsRunning = true
        }
        
    }
    
    @objc func resumeAnimation() {
        let pausedTime = shape.timeOffset
        shape.speed = 1.0
        shape.timeOffset = 0.0
        shape.beginTime = 0.0
        let timeSincePause = shape.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        shape.beginTime = timeSincePause
    }


}

