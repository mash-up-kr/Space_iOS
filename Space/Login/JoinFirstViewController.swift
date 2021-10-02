//
//  LoginViewController.swift
//  Space
//
//  Created by lina on 2021/10/02.
//

import UIKit

// TODO: 이메일 데이터 넘기기, textField 키보드 영어만뜨게?, 페이지 넘어갈때 이메일에 인증번호 넘겨달라고 해야겠찌
final class JoinFirstViewController: UIViewController {
    
    @IBOutlet private weak var nextButton: Button!
    @IBOutlet private weak var checkImageView: UIImageView!
    @IBOutlet private weak var explainLabel: UILabel!
    @IBOutlet private weak var emailTextField: TextField! {
        didSet {
            emailTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
    }
    
    private func setUpNavigationBar() {
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()

        // TODO: backButtonTitle 매번 하는거 바꿀수없나
        navigationItem.backButtonTitle = ""
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        if isValidEmail(text: textField.text) {
            nextButton.setEnabled(isEnabled: true)
            emailTextField.changeStatus(status: .vaild)
            checkImageView.image = UIImage(named: "checkCircle")
            explainLabel.text = "입력한 이메일로 인증번호가 전송됩니다."
            explainLabel.textColor = UIColor(named: "gray02")
        } else {
            nextButton.setEnabled(isEnabled: false)
            emailTextField.changeStatus(status: .unvalid)
            checkImageView.image = UIImage(named: "errorCircle")
            explainLabel.text = "올바른 이메일 형식을 입력해주세요.\n 예시) Appilogue@gmail.com"
            explainLabel.textColor = UIColor(named: "red01")
        }
    }
    
    private func isValidEmail(text: String?) -> Bool {
        let emailRegularExpression = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegularExpression)
        return emailTest.evaluate(with: text)
    }
    
    @IBAction private func cancelButton(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
}
