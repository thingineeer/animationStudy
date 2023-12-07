//
//  UIView+.swift
//  AnimationStudy
//
//  Created by 이명진 on 12/7/23.
//

import UIKit

extension UIView {
    func addSubviews (_ views: UIView...){
        views.forEach { self.addSubview($0) }
    }
}
