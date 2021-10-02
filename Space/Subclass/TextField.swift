//
//  TextField.swift
//  Space
//
//  Created by lina on 2021/10/02.
//

import UIKit

class TextField: UITextField {
    enum Status {
        case unSelected
        case vaild
        case unvalid
    }
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
        changeStatus(status: .unSelected)
    }
    
    func changeStatus(status: Status) {
        switch status {
        case .unSelected:
            self.layer.borderWidth = 0
        case .vaild:
            self.layer.borderWidth = 2
            self.layer.borderColor = UIColor(named: "purple01")?.cgColor
        case .unvalid:
            self.layer.borderWidth = 2
            self.layer.borderColor = UIColor(named: "red01")?.cgColor
        }
    }
}
