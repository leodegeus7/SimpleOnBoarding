//
//  OnBoardingLayout.swift
//  DemoApp
//
//  Created by Leonardo Geus on 25/01/2018.
//  Copyright © 2018 Leonardo Geus. All rights reserved.
//

import UIKit

public class OnBoardingLayout: NSObject {
    public var titleFont:UIFont!
    public var descriptionFont:UIFont!
    public var buttonFont:UIFont!
    
    public var titleColor:UIColor!
    public var descriptionColor:UIColor!
    public var buttonColor:UIColor!

    public var titleBackgroundColor:UIColor!
    public var descriptionBackgroundColor:UIColor!
    public var buttonBackgroundColor:UIColor!
    
    public var backgroundColor:UIColor!
    
    internal var customNib:OnBoard1ViewController!
    public var customNibName:String!
    public var customBundle:Bundle!
    
    public override init() {
        super.init()
        createDefault()
    }
    
    public convenience init(customNibName: String, bundle:Bundle, useCustomLayoutClass:Bool = false) {
        self.init()
        customNib = OnBoard1ViewController(nibName: customNibName, bundle: bundle)
        if useCustomLayoutClass {
            createDefault()
        } else {
            titleFont = nil
            descriptionFont = nil
            buttonFont = nil
            titleColor = nil
            descriptionColor = nil
            buttonColor = nil
            titleBackgroundColor = nil
            descriptionBackgroundColor = nil
            buttonBackgroundColor = nil
            backgroundColor = nil
        }
        self.customNibName = customNibName
        self.customBundle = bundle
    }
    
    internal func createDefault() {
        titleFont = UIFont.systemFont(ofSize: 26, weight: .regular)
        descriptionFont = UIFont.systemFont(ofSize: 16, weight: .regular)
        buttonFont = UIFont.systemFont(ofSize: 17, weight: .regular)
        titleColor = UIColor.black
        descriptionColor = UIColor.black
        buttonColor = UIColor.white
        titleBackgroundColor = UIColor.clear
        descriptionBackgroundColor = UIColor.clear
        buttonBackgroundColor = UIColor.black
        backgroundColor = UIColor.white
        customNib = OnBoard1ViewController(nibName: "OnBoardingView", bundle: Bundle(for: WelcomePageController.self))
        self.customNibName = "OnBoardingView"
        self.customBundle = Bundle(for: WelcomePageController.self)
    }
}
