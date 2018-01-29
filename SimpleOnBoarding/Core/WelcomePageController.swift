//
//  WelcomePageController.swift
//  TS-Project-Tracker
//
//  Created by Dilermando on 04/01/17.
//  Copyright © 2017 T-Systems Brasil. All rights reserved.
//

import Foundation
import UIKit

class WelcomePageController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {

    var pages = [OnBoard1ViewController]()
    var welcomeViewsInfo = [OnBoarding]()
    var simpleOnBoarding:SimpleOnBoarding!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white

        self.delegate = self
        self.dataSource = self
        
        for view in self.view.subviews {
            if let scrollView = view as? UIScrollView {
                scrollView.bounces = false
            }
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        var count = 0
        for welcomeView in welcomeViewsInfo {
            let layouts = simpleOnBoarding.layout!
            let numberOfLayoutsIsPassed = layouts.count
            let index = count % numberOfLayoutsIsPassed
            let layout = layouts[index]
            let vc = OnBoard1ViewController(nibName: layout.customNibName, bundle: layout.customBundle)
            vc.simpleOnBoarding = simpleOnBoarding
            vc.pageIndex = count
            vc.onboarding = welcomeView
            pages.append(vc)
            count += 1
        }
        
        setViewControllers([pages.first!], direction: .forward, animated: true, completion: nil)
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {

        let index = pages.index(of: viewController as! OnBoard1ViewController)!
        if index > 0 {
            return pages[index-1]
        }

        return nil

    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {

        let index = pages.index(of: viewController as! OnBoard1ViewController)!
        if index < pages.count - 1 {
            return pages[index+1]
        }

        return nil

    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        for view in view.subviews {
            if view is UIScrollView {
                view.frame = UIScreen.main.bounds // Why? I don't know.
            } else if view is UIPageControl {
                view.backgroundColor = UIColor.clear
            }
        }
    }
    
}
