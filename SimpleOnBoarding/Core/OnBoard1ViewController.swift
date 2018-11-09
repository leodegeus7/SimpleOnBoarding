//
//  OnBoardViewController.swift
//  TS-Project-Tracker
//
//  Created by Diogo Lessa on 28/12/16.
//  Copyright © 2016 T-Systems Brasil. All rights reserved.
//

import UIKit

internal class OnBoard1ViewController: UIViewController {

    // MARK: Variables
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var topImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var bottomButton: UIButton!
    @IBOutlet weak var logoImage: UIImageView!
    
    internal var simpleOnBoarding:SimpleOnBoarding!

    internal var onboarding = OnBoarding(titleLabel: "", logo: UIImage(), topImage: UIImage(), descriptionLabel: "", bottomButton: "", isLast: false)

    internal var pageIndex = -1
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = simpleOnBoarding.layout!
        let numberOfLayoutsIsPassed = layout.count
        let index = pageIndex % numberOfLayoutsIsPassed

        bottomButton.addTarget(self, action: #selector(self.bottomButtonAction), for: .touchUpInside)
        
        
        topImage.image = onboarding.topImage
        logoImage.image = onboarding.logoImage
        
        
        titleLabel.text = onboarding.titleLabel
        if let _ = layout[index].titleColor {
            titleLabel.textColor = layout[index].titleColor}
        if let _ = layout[index].titleColor {
            titleLabel.tintColor = layout[index].titleColor}
        if let _ = layout[index].titleFont {
            titleLabel.font = layout[index].titleFont}
        if let _ = layout[index].titleBackgroundColor {
            titleLabel.backgroundColor = layout[index].titleBackgroundColor}
        
        descriptionLabel.text = onboarding.descriptionLabel
        if let _ = layout[index].descriptionFont {
            descriptionLabel.font = layout[index].descriptionFont}
        if let _ = layout[index].descriptionColor {
            descriptionLabel.textColor = layout[index].descriptionColor}
        if let _ = layout[index].descriptionBackgroundColor {
            descriptionLabel.backgroundColor = layout[index].descriptionBackgroundColor}
        

        bottomButton.setTitle(onboarding.bottomButton, for: .normal)
        if let _ = layout[index].buttonFont {
            bottomButton.titleLabel?.font = layout[index].buttonFont}
        if let _ = layout[index].buttonColor {
            bottomButton.titleLabel?.textColor = layout[index].buttonColor}
        if let _ = layout[index].buttonBackgroundColor {
            bottomButton.backgroundColor = layout[index].buttonBackgroundColor}
        
        if let _ = layout[index].backgroundColor {
            self.view.backgroundColor = layout[index].backgroundColor}
    }

    
    
    @objc func bottomButtonAction() {
        if onboarding.isLast {
            if let app = UIApplication.shared.delegate, let window = app.window {
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    window?.rootViewController?.dismiss(animated: true, completion: nil)
                    window?.rootViewController = self.simpleOnBoarding.nextViewController
                    window?.makeKeyAndVisible()
                    
                }
            }
        } else {
            let parent = self.parent as! WelcomePageController
            let currentIndex = parent.pages.index(of: self)

            parent.setViewControllers([parent.pages[currentIndex! + 1]], direction: .forward, animated: true, completion: nil)
        }
    }

}
