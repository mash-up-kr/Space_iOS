//
//  EmailLoginViewController.swift
//  Space
//
//  Created by lina on 2021/11/13.
//

import UIKit

final class EmailLoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: TextField! {
        didSet {
            emailTextField.becomeFirstResponder()
            emailTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        }
    }
    @IBOutlet weak var passwordTextField: TextField! {
        didSet {
            passwordTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backButtonTitle = ""
    }
    
    @objc private func textFieldDidChange(_ textField: TextField) {
        if textField.text?.isEmpty == false {
            textField.changeStatus(status: .vaild)
        } else {
            textField.changeStatus(status: .unSelected)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let enterEmailView = segue.destination as? EnterEmailViewController else {
            return
        }
        if segue.identifier == "reset" {
            enterEmailView.isResetProcess = true
        }
    }
    
    @IBAction private func didTapCancelButton(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func touchUpNextButton(_ sender: Any) {
        let mainTabBarController = MainTabBarController.storyboardInstance()
        self.view.window?.rootViewController = mainTabBarController
    }
}
