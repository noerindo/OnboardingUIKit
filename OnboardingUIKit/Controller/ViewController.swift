//
//  ViewController.swift
//  OnboardingUIKit
//
//  Created by Indah Nurindo on 24/07/2566 BE.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onBoardingBtn(_ sender: Any) {
        let welcomeVC = storyboard?.instantiateViewController(identifier: "SwipeViewController") as! SwipeViewController
        self.present(welcomeVC, animated: true)
    }
}

//Mengecek user baru


