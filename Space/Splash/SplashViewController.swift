//
//  SplashViewController.swift
//  Space
//
//  Created by lina on 2021/10/02.
//

import UIKit

class SplashViewController: UIViewController {

    @IBOutlet weak var background: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        background.setGradient(color1: UIColor(red: 0.715, green: 0.54, blue: 1, alpha: 1), color2: UIColor(red: 0.495, green: 0.413, blue: 1, alpha: 1))
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        self.view.window?.rootViewController = MainTabBarController.storyboardInstance()
    }
}

extension UIView{
    func setGradient(color1:UIColor,color2:UIColor){
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = [color1.cgColor,color2.cgColor]
        gradient.locations = [0 , 1]
        gradient.startPoint = CGPoint(x: 0.25, y: 0.5)
        gradient.endPoint = CGPoint(x: 0.75, y: 0.5)
        gradient.frame = bounds
        layer.addSublayer(gradient)
        
        gradient.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0.93, b: 0.97, c: -0.97, d: 0.29, tx: 0.48, ty: -0.15))

        gradient.bounds = self.bounds.insetBy(dx: -0.5*self.bounds.size.width, dy: -0.5*self.bounds.size.height)

        gradient.position = self.center

        self.layer.addSublayer(gradient)
    }
}

