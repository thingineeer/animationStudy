//
//  PanGestureViewController.swift
//  AnimationStudy
//
//  Created by 이명진 on 5/10/24.
//

import UIKit
import Then
import SnapKit

class PanGestureViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setLayout()
        
    }
    
    private func setLayout() {
        self.view.addSubview(soptView)
        soptView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.height.equalTo(100)
        }
    }
    
    @objc private func didImageViewMoved(_ sender: UIPanGestureRecognizer) {
        let transition = sender.translation(in: soptView)
        let changedX = soptView.center.x + transition.x
        let changedY = soptView.center.y + transition.y
        
        self.soptView.center = .init(x: changedX,
                                     y: changedY)
        
        sender.setTranslation(.zero, in: self.soptView)
    }
    
    
    private lazy var soptView = UIImageView(image: UIImage(named: "thingjin")).then {
        let gesture = UIPanGestureRecognizer(target: self,
                                             action: #selector(didImageViewMoved(_:)))
        $0.addGestureRecognizer(gesture)
        $0.isUserInteractionEnabled = true
    }
    
}
