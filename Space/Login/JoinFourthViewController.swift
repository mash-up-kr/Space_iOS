//
//  JoinFourthViewController.swift
//  Space
//
//  Created by lina on 2021/10/03.
//

import UIKit

final class JoinFourthViewController: UIViewController {

    @IBOutlet private weak var nicknameTextField: TextField! {
        didSet {
            nicknameTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        }
    }
    @IBOutlet private weak var nicknameCountLabel: UILabel!
    @IBOutlet private weak var nextButton: Button!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backButtonTitle = ""
    }
    
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
    
    @IBAction private func cancelButton(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }

    @IBAction func touchUpNextButton(_ sender: Any) {
        let mainTabBarController = MainTabBarController.storyboardInstance()
        self.view.window?.rootViewController = mainTabBarController
    }
}
