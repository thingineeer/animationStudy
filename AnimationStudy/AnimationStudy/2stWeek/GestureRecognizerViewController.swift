//
//  GestureRecognizerViewController.swift
//  AnimationStudy
//
//  Created by 이명진 on 5/10/24.
//


import UIKit
import SnapKit

import Then

class GestureRecognizerViewController: UIViewController {
    
    //점수
    var score: Int = 0
    
    //타이머
    var timer: Timer? = nil
    var isPause: Bool = true
    
    private lazy var chocoCat = UIImageView()
    private let topEnemy = UIImageView(image: UIImage(named: "thingjin"))
    private let bottomEnemy = UIImageView(image: UIImage(named: "thingjin"))
    private let leadingEnemy = UIImageView(image: UIImage(named: "thingjin"))
    private let trailingEnemy = UIImageView(image: UIImage(named: "thingjin"))
    private let scoreLabel = UILabel().then {
        $0.textAlignment = .center
    }
    
    private lazy var restartButton = UIButton().then {
        $0.setTitle("Restart Game", for: .normal)
        $0.backgroundColor = .blue
        $0.addTarget(self, action: #selector(restartGame), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        setStyle()
        setLayout()
        makeEnemy()
        startTimer()
        
    }
    deinit {
        stopTimer() // 해당 뷰 컨트롤러가 메모리에서 해제될 때 타이머 중지
    }
    
    open func startTimer() {
        guard timer == nil else { return }
        self.timer = Timer.scheduledTimer(timeInterval: 0.04,
                                          target: self,
                                          selector: #selector(self.enemyMove),
                                          userInfo: nil,
                                          repeats: true)
    }
    
    open func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    
    func setStyle() {
        chocoCat.do {
            $0.image = UIImage(resource: .thingjin)
            $0.isUserInteractionEnabled = true
            //w제스처 추가
            let gesture = UIPanGestureRecognizer(target: self, action: #selector(didImageViewMoved(_:)))
            $0.addGestureRecognizer(gesture)
        }
    }
    
    @objc func restartGame() {
        score = 0
        scoreLabel.text = "Score: \(score)"
        
        // Reset positions of chocoCat and enemies
        chocoCat.center = self.view.center
        setupInitialEnemyPositions()
        
        if timer == nil {
            startTimer()
        }
    }
    
    func setLayout() {
        [chocoCat, scoreLabel, restartButton].forEach { [weak self] view in
            guard let self = self else { return }
            self.view.addSubview(view)
        }
        chocoCat.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.height.equalTo(100)
        }
        scoreLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(20)
        }
        restartButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-20)
            $0.width.equalTo(120)
            $0.height.equalTo(50)
        }
        
        setupInitialEnemyPositions()
    }
    
    func setupInitialEnemyPositions() {
        topEnemy.center = CGPoint(x: self.view.center.x, y: 0)
        bottomEnemy.center = CGPoint(x: self.view.center.x, y: self.view.bounds.height)
        leadingEnemy.center = CGPoint(x: 0, y: self.view.center.y)
        trailingEnemy.center = CGPoint(x: self.view.bounds.width, y: self.view.center.y)
    }
    
    @objc 
    private func enemyMove() {
        
        let random =  CGFloat(Int.random(in: 1...25))
        
        var topEnemyY = self.topEnemy.frame.origin.y + random
        if topEnemyY > self.view.bounds.height {
            topEnemyY = -self.topEnemy.frame.height  // Reset position to top
        }
        
        var topEnemyX = self.topEnemy.frame.origin.x  + random
        if topEnemyX > self.view.bounds.width {
            topEnemyX = -self.topEnemy.frame.width
        }
//        print(topEnemyX)
        self.topEnemy.frame.origin.y = topEnemyY
        self.topEnemy.frame.origin.x = topEnemyX
        
        
        
        
        
        
        var bottomEnemyY = self.bottomEnemy.frame.origin.y - 10
        if bottomEnemyY < -self.bottomEnemy.frame.height {
            bottomEnemyY = self.view.bounds.height  // Reset position to bottom
        }
        
        var bottomEnemyX = self.bottomEnemy.frame.origin.x + random
        
        if bottomEnemyX > self.view.bounds.width {
            bottomEnemyX = -self.bottomEnemy.frame.width
        }
        self.bottomEnemy.frame.origin.y = bottomEnemyY
        self.bottomEnemy.frame.origin.x = bottomEnemyX
        
        
        
        var leadingEnemyX = self.leadingEnemy.frame.origin.x + random
        if leadingEnemyX > self.view.bounds.width {
            leadingEnemyX = -self.leadingEnemy.frame.width  // Reset position to left
        }
        
        var leadingEnemyY = self.bottomEnemy.frame.origin.y - random
        if leadingEnemyY < -self.bottomEnemy.frame.height {
            leadingEnemyY = self.view.bounds.height  // Reset position to bottom
        }
        
        self.leadingEnemy.frame.origin.x = leadingEnemyX
        self.leadingEnemy.frame.origin.y = leadingEnemyY
        
        
        
        
        var trailingEnemyX = self.trailingEnemy.frame.origin.x - random
        if trailingEnemyX < -self.trailingEnemy.frame.width {
            trailingEnemyX = self.view.bounds.width  // Reset position to right
        }
        
        var trailingEnemyY = self.bottomEnemy.frame.origin.y - random
        if trailingEnemyY < -self.bottomEnemy.frame.height {
            trailingEnemyY = self.view.bounds.height  // Reset position to bottom
        }
        self.trailingEnemy.frame.origin.x = trailingEnemyX
        self.trailingEnemy.frame.origin.y = trailingEnemyY
        
        self.calculatePositionReached()
    }
    
    @objc 
    private func didImageViewMoved(_ sender: UIPanGestureRecognizer) {
        let transition = sender.translation(in: chocoCat)
        let changedX = chocoCat.center.x + transition.x
        let changedY = chocoCat.center.y + transition.y
        
        self.chocoCat.center = .init(x: changedX, y: changedY)
        //추가해줘~
        sender.setTranslation(.zero, in: self.chocoCat)
    }
    
    private func calculatePositionReached() {
        if self.chocoCat.frame.minX <= self.topEnemy.frame.minX &&
            self.chocoCat.frame.maxX >= self.topEnemy.frame.maxX &&
            self.chocoCat.frame.minY <= self.topEnemy.frame.minY &&
            self.chocoCat.frame.maxY >= self.topEnemy.frame.maxY
        {
            self.scoreLabel.text = "Game End, Score:\(self.score)"
            self.stopTimer()
        } else {
            self.score += 10
        }
        
        if self.chocoCat.frame.minX <= self.leadingEnemy.frame.minX &&
            self.chocoCat.frame.maxX >= self.leadingEnemy.frame.maxX &&
            self.chocoCat.frame.minY <= self.leadingEnemy.frame.minY &&
            self.chocoCat.frame.maxY >= self.leadingEnemy.frame.maxY
        {
            self.scoreLabel.text = "Game End, Score:\(self.score)"
            self.stopTimer()
        } else {
            self.score += 10
        }
        
        if self.chocoCat.frame.minX <= self.trailingEnemy.frame.minX &&
            self.chocoCat.frame.maxX >= self.trailingEnemy.frame.maxX &&
            self.chocoCat.frame.minY <= self.trailingEnemy.frame.minY &&
            self.chocoCat.frame.maxY >= self.trailingEnemy.frame.maxY
        {
            self.scoreLabel.text = "Game End, Score:\(self.score)"
            self.stopTimer()
        } else {
            self.score += 10
        }
        
        if self.chocoCat.frame.minX <= self.bottomEnemy.frame.minX &&
            self.chocoCat.frame.maxX >= self.bottomEnemy.frame.maxX &&
            self.chocoCat.frame.minY <= self.bottomEnemy.frame.minY &&
            self.chocoCat.frame.maxY >= self.bottomEnemy.frame.maxY
        {
            self.scoreLabel.text = "Game End, Score:\(self.score)"
            self.stopTimer()
        } else {
            self.score += 10
        }
    }
    
    private func makeEnemy() {
        self.view.addSubview(topEnemy)
        self.view.addSubview(bottomEnemy)
        self.view.addSubview(leadingEnemy)
        self.view.addSubview(trailingEnemy)
        
        topEnemy.snp.makeConstraints {
            $0.top.centerX.equalToSuperview()
            $0.width.height.equalTo(50)
        }
        leadingEnemy.snp.makeConstraints {
            $0.leading.centerY.equalToSuperview()
            $0.width.height.equalTo(50)
        }
        trailingEnemy.snp.makeConstraints {
            $0.trailing.centerY.equalToSuperview()
            $0.width.height.equalTo(50)
        }
        bottomEnemy.snp.makeConstraints {
            $0.bottom.centerX.equalToSuperview()
            $0.width.height.equalTo(50)
        }
    }
    
    
}

