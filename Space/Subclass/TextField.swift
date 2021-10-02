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

        if let placeholderText = self.placeholder {
            self.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [NSAttributedString.Key.foregroundColor : UIColor(named: "gray02")])
        }
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
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 0)
        }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
        }
}
