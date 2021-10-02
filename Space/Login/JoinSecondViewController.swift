//
//  JoinSecondViewController.swift
//  Space
//
//  Created by lina on 2021/10/03.
//

import UIKit

class JoinSecondViewController: UIViewController {

    @IBOutlet var numberTextFieldArray: [TextField]! {
        didSet {
            for textField in numberTextFieldArray {
                textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
            }
        }
    }
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var nextButton: Button!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backButtonTitle = ""
    }
    
    private lazy var isTextFieldValid = Array(repeating: false, count: numberTextFieldArray.count)
    
    @IBAction func touchUpResendButton(_ sender: Any) {
        // TODO: 인증번호 재전송하기, 재전송 버튼 밑줄
        debugPrint("재전송")
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func textFieldDidChange(_ textField: TextField) {
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
    }
    
    // TODO: textField에 한글자만 들어가고, 다음 포커스로 넘기기
    private func isVaildNumber(text: String?) -> Bool {
        guard let text = text, text.count == 1,
           let intText = Int(text), intText >= 0, intText <= 9 else {
            return false
        }
        return true
    }
}
