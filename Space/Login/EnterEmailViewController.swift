//
//  EnterEmailViewController.swift
//  Space
//
//  Created by lina on 2021/10/02.
//

import UIKit

// TODO: 이메일 데이터 넘기기, textField 키보드 영어만뜨게?, 페이지 넘어갈때 이메일에 인증번호 넘겨달라고 해야겠찌
final class EnterEmailViewController: UIViewController {
    
    @IBOutlet private weak var viewTitleLabel: UILabel! {
        didSet {
            if isResetProcess {
                viewTitleLabel.text = "가입한 이메일 주소를 입력하세요"
            }
        }
    }
    @IBOutlet private weak var nextButton: Button!
    @IBOutlet private weak var checkImageView: UIImageView!
    @IBOutlet private weak var explainLabel: UILabel!
    @IBOutlet private weak var emailTextField: TextField! {
        didSet {
            emailTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
            emailTextField.becomeFirstResponder()
        }
    }
    
    var isResetProcess: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backButtonTitle = ""
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        // 올바른 이메일인지 체크
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let authenticationView = segue.destination as? AuthenticationViewController else {
            return
        }
        authenticationView.isResetProcess = isResetProcess
    }
    
    @IBAction private func didTapCancelButton(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
}
