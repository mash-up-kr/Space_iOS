//
//  JoinThirdViewController.swift
//  Space
//
//  Created by lina on 2021/10/03.
//

import UIKit

// TODO: isTextFieldValid 사용할때 매직넘버 사용
final class JoinThirdViewController: UIViewController {

    @IBOutlet private weak var passwordTextField: TextField! {
        didSet {
            passwordTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
            passwordTextField.isSecureTextEntry = true
        }
    }
    @IBOutlet private weak var checkPasswordTextField: TextField! {
        didSet {
            checkPasswordTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
            checkPasswordTextField.isSecureTextEntry = true
        }
    }
    @IBOutlet private weak var passwordCheckImage: UIImageView!
    @IBOutlet private weak var checkPasswordCheckImage: UIImageView!
    @IBOutlet private weak var nextButton: Button!
    
    private lazy var isTextFieldValid = Array(repeating: false, count: 2)

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backButtonTitle = ""
    }

    @objc private func textFieldDidChange(_ textField: TextField) {
        if textField == passwordTextField {
            setPasswordTextFieldStatus(isVaild: isValidPassword(text: textField.text))
            if checkPasswordTextField.text?.isEmpty == false {
                setCheckPasswordTextFieldStatus(isVaild: isSamePassword())
            }
        } else {
            let isVaild = isValidPassword(text: textField.text) && isSamePassword()
            setCheckPasswordTextFieldStatus(isVaild: isVaild)
        }
        
        if isTextFieldValid.contains(false) == false && isSamePassword() {
            nextButton.setEnabled(isEnabled: true)
        } else {
            nextButton.setEnabled(isEnabled: false)
        }
    }
    
    private func setPasswordTextFieldStatus(isVaild: Bool) {
        if isVaild {
            passwordTextField.changeStatus(status: .vaild)
            passwordCheckImage.image = UIImage(named: "checkCircle")
            isTextFieldValid[0] = true
        } else {
            passwordTextField.changeStatus(status: .unvalid)
            passwordCheckImage.image = UIImage(named: "errorCircle")
            isTextFieldValid[0] = false
        }
    }
    
    private func setCheckPasswordTextFieldStatus(isVaild: Bool) {
        if isVaild {
            checkPasswordTextField.changeStatus(status: .vaild)
            checkPasswordCheckImage.image = UIImage(named: "checkCircle")
            isTextFieldValid[1] = true
        } else {
            checkPasswordTextField.changeStatus(status: .unvalid)
            checkPasswordCheckImage.image = UIImage(named: "errorCircle")
            isTextFieldValid[1] = false
        }
    }
    
    private func isValidPassword(text: String?) -> Bool {
        guard let text = text else {
            return false
        }
        return text.count >= 8
    }
    
    private func isSamePassword() -> Bool {
        return passwordTextField.text == checkPasswordTextField.text
    }
    
    @IBAction private func cancelButton(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
}
