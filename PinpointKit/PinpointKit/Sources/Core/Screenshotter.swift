//
//  Screenshotter.swift
//  PinpointKit
//
//  Created by Matthew Bischoff on 2/19/16.
//  Copyright © 2016 Lickability. All rights reserved.
//

import UIKit

/// A class responsible for generating a screenshot image of all windows shown by a `UIApplication` on a given `UIScreen`.
open class Screenshotter {

    /**
     Takes and returns a screenshot of all of an application’s windows displayed on a given screen.

     - parameter application: The application to screenshot.
     - parameter screen:      The screen to determine the screenshot size.

     - returns: A screenshot as a `UIImage`.
     */
    public static func takeScreenshot(of application: UIApplication = UIApplication.shared, on screen: UIScreen = UIScreen.main) -> UIImage {
        guard let window = application.windows.first(where: { $0.isKeyWindow }) else {
            preconditionFailure("This application has no key window.")
        }

        UIGraphicsBeginImageContextWithOptions(window.layer.bounds.size, false, screen.scale);
        window.layer.render(in: UIGraphicsGetCurrentContext()!)

        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            preconditionFailure("`UIGraphicsGetImageFromCurrentImageContext()` should never return `nil` as we satisify the requirements of having a bitmap-based current context created with `UIGraphicsBeginImageContextWithOptions(_:_:_:)`")
        }

        UIGraphicsEndImageContext()

        return image
    }
}
