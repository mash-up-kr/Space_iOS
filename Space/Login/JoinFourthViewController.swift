//
//  JoinFourthViewController.swift
//  Space
//
//  Created by lina on 2021/10/03.
//

import UIKit

class JoinFourthViewController: UIViewController {

    @IBOutlet weak var nicknameTextField: TextField! {
        didSet {
            nicknameTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        }
    }
    @IBOutlet weak var nicknameCountLabel: UILabel!
    @IBOutlet weak var nextButton: Button!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backButtonTitle = ""
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func textFieldDidChange(_ textField: TextField) {
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
}
