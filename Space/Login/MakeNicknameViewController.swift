//
//  MakeNicknameViewController.swift
//  Space
//
//  Created by lina on 2021/10/03.
//

import UIKit

final class MakeNicknameViewController: UIViewController {
    
    @IBOutlet private weak var nicknameTextField: TextField! {
        didSet {
            nicknameTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
            nicknameTextField.becomeFirstResponder()
        }
    }
    @IBOutlet private weak var nicknameCountLabel: UILabel!
    @IBOutlet private weak var explainLabel: UILabel! // TODO: 중복 확인해서 중복되면 isHidden == false, 중복 안되면 다시 hidden
    @IBOutlet private weak var errorImageView: UIImageView! // 이것도 같이!
    @IBOutlet private weak var nextButton: Button!
    
    var isResetProcess: Bool = false
    
    @objc private func textFieldDidChange(_ textField: TextField) {
        guard let textCount = nicknameTextField.text?.count else {
            nextButton.setEnabled(isEnabled: false)
            return
        }
        nicknameCountLabel.text = "\(textCount)/10"
        if textCount > 0, textCount <= 10 {
            nextButton.setEnabled(isEnabled: true)
            nicknameTextField.changeStatus(status: .vaild)
        } else {
            nextButton.setEnabled(isEnabled: false)
            nicknameTextField.changeStatus(status: .unvalid)
        }
    }
    
    @IBAction private func didTapCancelButton(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func touchUpNextButton(_ sender: Any) {
        guard let emailLoginViewController = self.storyboard?.instantiateViewController(identifier: "emailLogin") else {
            return
        }
        navigationController?.popToRootViewController(animated: true)
        navigationController?.pushViewController(emailLoginViewController, animated: true)
    }
}
