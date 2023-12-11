//
//  FirstVC.swift
//  AnimationStudy
//
//  Created by 이명진 on 12/7/23.
//

import UIKit

class FirstVC: UIViewController {
    
    private let testView : UIView = {
        let view = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
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
        //        UIView.animate(withDuration: 2.0, animations: { [self] in
        //            testView.frame.origin.x += 100 // frame은 상위뷰
        //            print(testView.frame.origin)
        //            testView.alpha = 0.3
        //        })
        
        //CGAffineTransform
        
        //        /// scale : 뷰의 넓이와 높이를 두 배(2.0)로 증가 시킵니다.
        //        UIView.animate(withDuration: 2.0) { [self] in
        //            testView.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
        //        }
        //        /// rotationAngle 사용 뷰를 180도 회전 시킵니다.
        //        UIView.animate(withDuration: 2.0) { [self] in
        //            testView.transform = CGAffineTransform(rotationAngle: .pi)
        //        }
        //        /// translationX 뷰의 위치를 X 200 Y 200 움직입니다.
        //        UIView.animate(withDuration: 2.0) { [self] in
        //            testView.transform = CGAffineTransform(translationX: 200, y: 200)
        //        }
        
        concatenationing()
        
        // 초기화
    }
    
    private func concatenationing() {
//        
//        UIView.animate(withDuration: 2.0) { [self] in
//            testView.backgroundColor = .gray
//            
//            let scale = CGAffineTransform(scaleX: 2.0, y: 2.0)
//            let rotate = CGAffineTransform(rotationAngle: .pi)
//            let move = CGAffineTransform(translationX: 200, y: 200)
//            
//            let combine = scale.concatenating(rotate).concatenating(move)
//            
//            testView.transform = combine
//        }
        
        UIView.animate(withDuration: 2.0, animations: { [self] in
            testView.backgroundColor = .gray
            
            let scale = CGAffineTransform(scaleX: 2.0, y: 2.0)
            let rotate = CGAffineTransform(rotationAngle: .pi)
            let move = CGAffineTransform(translationX: 200, y: 200)
            
            let combine = scale.concatenating(rotate).concatenating(move)
            
            testView.transform = combine
        }) { (_) in
            UIView.animate(withDuration: 2.0) {
                self.testView.transform = CGAffineTransform.identity
            }
        }

    }
}
