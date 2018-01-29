//
//  OnBoarding.swift
//  Mobile-Reports
//
//  Created by DILERMANDO BARBOSA JR on 27/03/17.
//  Copyright © 2017 T-Systems Brasil. All rights reserved.
//

import Foundation
import UIKit

class OnBoarding: NSObject {

    let titleLabel: String?
    var logoImage = UIImage()
    var topImage = UIImage()
    var descriptionLabel = String()
    var bottomButton = String()
    var isLast = Bool()

    init(titleLabel: String, logo: UIImage, topImage: UIImage, descriptionLabel: String, bottomButton: String, isLast: Bool) {
        self.titleLabel = titleLabel
        self.logoImage = logo
        self.topImage = topImage
        self.descriptionLabel = descriptionLabel
        self.bottomButton = bottomButton
        self.isLast = isLast
    }

}
