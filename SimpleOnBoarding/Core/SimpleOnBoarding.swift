//
//  SimpleOnBoarding.swift
//  DemoApp
//
//  Created by Leonardo Geus on 25/01/2018.
//  Copyright © 2018 Leonardo Geus. All rights reserved.
//

import UIKit


public enum WorkingMode {
    case Online
    case Offline
}

public class SimpleOnBoarding: NSObject {
    internal var jsonURLOnline:URL!
    internal var jsonURLOffline:URL!
    internal var mode:WorkingMode!
    internal var showLoadingScreenWhenOffline = true
    internal var nextViewController:UIViewController!
    internal var timeWithLoading = 2
    internal var layout:[OnBoardingLayout]!
    internal var loadingImage = UIImage()
    internal var progressBarLoadingColor = UIColor.black
    internal var backgroundColorLoading = UIColor.white
    internal var progressBarBackLoadingColor = UIColor.gray

    
    public init(mode:WorkingMode,configJsonURL:URL,whereNextViewControllerIs:UIViewController) {
        
        self.mode = mode
        switch mode {
        case .Offline:
            jsonURLOffline = configJsonURL
            break
        case .Online:
            jsonURLOnline = configJsonURL
            break
        }
        self.nextViewController = whereNextViewControllerIs
        self.layout = [OnBoardingLayout()]
    }
    
    public init(mode:WorkingMode,configJsonURL:URL,layout:OnBoardingLayout,whereNextViewControllerIs:UIViewController) {
        self.mode = mode
        switch mode {
        case .Offline:
            jsonURLOffline = configJsonURL
            break
        case .Online:
            jsonURLOnline = configJsonURL
            break
        }
        self.layout = [layout]
        self.nextViewController = whereNextViewControllerIs
    }
    
    public init(mode:WorkingMode,configJsonURL:URL,layout:[OnBoardingLayout],whereNextViewControllerIs:UIViewController) {
        self.mode = mode
        switch mode {
        case .Offline:
            jsonURLOffline = configJsonURL
            break
        case .Online:
            jsonURLOnline = configJsonURL
            break
        }
        self.layout = layout
        self.nextViewController = whereNextViewControllerIs
    }
    
    public func showLoadingScreenWhenOffline(_ bool:Bool, during:Int = 2) {
        self.showLoadingScreenWhenOffline = bool
        self.timeWithLoading = during
    }
    
    public func updateLoadingScreenView(image:UIImage,progressBarColor:UIColor,progressBarBackLoadingColor:UIColor = UIColor.gray,backgroundColor:UIColor = UIColor.white) {
        self.loadingImage = image
        self.progressBarLoadingColor = progressBarColor
        self.backgroundColorLoading = backgroundColor
        self.progressBarBackLoadingColor = progressBarBackLoadingColor
    }
    
    public func show() {
        if let app = UIApplication.shared.delegate, let window = app.window {
            let storyboard = UIStoryboard(name: "Load", bundle: Bundle(for: SimpleOnBoarding.self))
            let controller = storyboard.instantiateViewController(withIdentifier: "LoadViewController") as! LoadViewController
            controller.simpleOnBoarding = self
            if mode == .Online {
                controller.startOnline()
            } else if mode == .Offline {
                controller.startOffline()
            }
            window?.rootViewController = controller
            window?.makeKeyAndVisible()
        }
    }
    
    public func getInfo() -> [String: String] {
        var modeString = ""
        var url = ""
        switch mode! {
        case .Offline:
            modeString = "offline"
            url = jsonURLOffline.absoluteString
        case .Online:
            modeString = "online"
            url = jsonURLOnline.absoluteString
        }
        return ["mode":"\(modeString)","url":"\(url)","showLoadingScreenWhenOffline":"\(showLoadingScreenWhenOffline)","timeWithLoading":"\(timeWithLoading)"]
    }
}
