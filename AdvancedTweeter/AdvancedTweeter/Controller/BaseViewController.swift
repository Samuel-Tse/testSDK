//
//  BaseViewController.swift
//  AdvancedTweeter
//
//  Created by Samuel Tse on 14/4/19.
//  Copyright © 2019 Samuel Tse. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setBackgroundColor()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadTwitterSplashAnimation()
    }
    
    func loadTwitterSplashAnimation() -> Void {
        let splashView = SplashView(iconImage: UIImage(named: "tweeter")!,iconInitialSize: CGSize(width: 70, height: 70), backgroundColorTop: UIColor(rgb: 0x67B1BD), backgroundColorBottom: UIColor(rgb: 0x67B1BD))
        self.view.addSubview(splashView)
        splashView.duration = 2.0
        splashView.animationType = AnimationType.heartBeat
        splashView.iconColor = UIColor.red
        splashView.useCustomIconColor = false
        splashView.startAnimation(){
            [unowned self ] in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "LoginViewControllerID")
            viewController.modalTransitionStyle = .crossDissolve
            viewController.modalPresentationStyle = .fullScreen
            self.present(viewController, animated: true, completion: nil)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
            splashView.finishHeartBeatAnimation()
        })
    }
}
