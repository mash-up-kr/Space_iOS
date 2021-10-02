//
//  SplashViewController.swift
//  Space
//
//  Created by lina on 2021/10/02.
//

import UIKit

final class SplashViewController: UIViewController {
    
    @IBOutlet private weak var background: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // TODO: splash 시간
        sleep(1)
        pushLoginView()
    }
    
    private func setUpUI() {
        guard let firstColor = UIColor(named: "purple01"),
              let secondColor = UIColor(named: "purple02") else {
            return
        }
        background.setGradient(color1: firstColor, color2: secondColor)
    }
    
    private func pushLoginView() {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let loginViewController = storyboard.instantiateViewController(withIdentifier: "Login")
        loginViewController.modalPresentationStyle = .fullScreen
        loginViewController.navigationController?.setNavigationBarHidden(true, animated: false)
        present(loginViewController, animated: false, completion: nil)
    }
}
