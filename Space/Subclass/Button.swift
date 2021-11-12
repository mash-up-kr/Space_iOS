//
//  Button.swift
//  Space
//
//  Created by lina on 2021/10/02.
//

import UIKit

// TODO: 버튼 자체에서 글씨체랑 크기랑 굵기 해주기
class Button: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpUI()
    }
    
    private func setUpUI() {
        self.layer.cornerRadius = 10
        self.tintColor = .white
        
        setEnabled(isEnabled: self.isEnabled)
    }
    
    func setEnabled(isEnabled: Bool) {
        self.isEnabled = isEnabled
        if self.isEnabled {
            self.backgroundColor = UIColor(named: "purple01")
        } else {
            self.backgroundColor = UIColor(named: "gray01")
        }
    }
}
