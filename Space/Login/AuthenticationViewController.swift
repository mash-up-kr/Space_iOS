//
//  AuthenticationViewController.swift
//  Space
//
//  Created by lina on 2021/10/03.
//

import UIKit

final class AuthenticationViewController: UIViewController {
    
    @IBOutlet private var numberTextFieldArray: [TextField]! {
        didSet {
            for textField in numberTextFieldArray {
                textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
            }
            numberTextFieldArray.first?.becomeFirstResponder()
        }
    }
    @IBOutlet private weak var explainLabel: UILabel!
    @IBOutlet private weak var timerLabel: UILabel!
    @IBOutlet private weak var nextButton: Button!
    @IBOutlet private weak var resendButton: UIButton!
    
    private lazy var isTextFieldValid = Array(repeating: false, count: numberTextFieldArray.count)
    
    private var timer: Timer?
    private var timeCount = 0
    
    var isResetProcess: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backButtonTitle = ""
        setUpResendButton()
        startTimer()
    }
    
    private func setUpResendButton() {
        guard let text = resendButton.titleLabel?.text else {
            return
        }
        let textRange = NSRange(location: 0, length: text.count)
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttribute(.underlineStyle,
                                    value: NSUnderlineStyle.single.rawValue,
                                    range: textRange)
        resendButton.setAttributedTitle(attributedText, for: .normal)
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self else {
                return
            }
            self.timeCount += 1
            DispatchQueue.main.async {
                self.timerLabel.text = self.makeTimeLabel(count: self.timeCount)
            }
        }
    }
    
    private func makeTimeLabel(count: Int) -> String {
        let totalTime = 10 * 60 - count
        let minute = totalTime / 60
        let second = totalTime % 60
        
        return "0\(minute):\(second)"
    }
    
    @objc private func textFieldDidChange(_ textField: TextField) {
        // 숫자가 1개 올바르게 입력되었는지 확인
        if isVaildNumber(text: textField.text) {
            textField.changeStatus(status: .vaild)
            isTextFieldValid[textField.tag] = true
            if isTextFieldValid.contains(false) == false {
                nextButton.setEnabled(isEnabled: true)
            }
        } else {
            textField.changeStatus(status: .unvalid)
            isTextFieldValid[textField.tag] = false
            nextButton.setEnabled(isEnabled: false)
        }
        
        // 1글자만 입력되고, 다음 textFiled로 넘기도록 변경
        if let textCount = textField.text?.count {
            if textCount >= 2 {
                textField.deleteBackward()
            } else if textCount == 1 {
                numberTextFieldArray[safe: textField.tag + 1]?.becomeFirstResponder()
            }
        }
        
        // 텍스트 필드의 내용이 전부 올바른지, 잘못된것이 있는지
        checkAllTextField()
    }
    
    private func isVaildNumber(text: String?) -> Bool {
        guard let text = text, text.count == 1,
              let intText = Int(text), intText >= 0, intText <= 9 else {
            return false
        }
        return true
    }
    
    private func checkAllTextField() {
        var isValid = true
        
        for textField in numberTextFieldArray {
            if textField.status == .unvalid {
                isValid = false
                break
            }
        }
        
        if isValid {
            explainLabel.text = "전송된 인증번호는 10분 안에 인증이 만료됩니다."
            explainLabel.textColor = UIColor(named: "gray02")
        } else {
            explainLabel.text = "올바른 인증번호가 아닙니다."
            explainLabel.textColor = UIColor(named: "red01")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let setPasswordView = segue.destination as? SetPasswordViewController else {
            return
        }
        setPasswordView.isResetProcess = isResetProcess
    }
    
    @IBAction private func touchUpResendButton(_ sender: Any) {
        // TODO: 인증번호 재전송하기
        timeCount = 0
    }
    
    @IBAction private func didTapCancelButton(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
}
