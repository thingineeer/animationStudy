//
//  FirstVC.swift
//  AnimationStudy
//
//  Created by 이명진 on 12/7/23.
//

import UIKit

class FirstVC: UIViewController {
    
    private var testView : UIView = {
        let view = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        view.backgroundColor = .systemPink
        return view
    }()
    
    private let testButton : UIButton = {
        let button = UIButton(frame: CGRect(x: 150, y: 400, width: 200, height: 50))
        button.setTitle("짠!", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17)
        button.titleLabel?.textColor = .brown
        button.layer.backgroundColor = UIColor.black.cgColor
        //        button.addTarget(self, action: #selector(didMoveTap), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    private func setUI() {
        view.backgroundColor = .white
    }
    
}
