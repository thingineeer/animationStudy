//
//  FirstVC.swift
//  AnimationStudy
//
//  Created by 이명진 on 12/7/23.
//

import UIKit

class FirstVC: UIViewController {
    
    private var testView : UIView = {
        let view = UIView(frame: CGRect(x: 150, y: 200, width: 50, height: 50))
        view.backgroundColor = .systemPink
        return view
    }()
    
    private let testButton : UIButton = {
        let button = UIButton(frame: CGRect(x: 150, y: 600, width: 200, height: 50))
        button.setTitle("버튼", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17)
        button.titleLabel?.textColor = .brown
        button.layer.backgroundColor = UIColor.black.cgColor
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        didMoveTap()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        addTarget()
    }
    
    
    private func setUI() {
        view.backgroundColor = .white
        view.addSubviews(testView, testButton)
    }
    
    private func addTarget() {
        testButton.addTarget(self, action: #selector(didMoveTap), for: .touchUpInside)
    }
    
    @objc private func didMoveTap() {
        
        //animate 기본
        UIView.animate(withDuration: 2.0, animations: { [self] in
            testView.frame.origin.x += 100 // frame은 상위뷰
            print(testView.frame.origin)
            testView.alpha = 0.3
        })
        
        //CGAffineTransform /// 움직일때 추가적으로 변하는 것들?
//        UIView.animate(withDuration: 2.0) { [self] in
//            testView.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
//        }
//        UIView.animate(withDuration: 2.0) { [self] in
//            testView.transform = CGAffineTransform(rotationAngle: .pi)
//        }
//        UIView.animate(withDuration: 2.0) { [self] in
//            testView.transform = CGAffineTransform(translationX: 200, y: 200)
//        }
        
        
        self.testView.frame = CGRect(x: 150, y: 200, width: 50, height: 50)
        // 초기화
    }
}
