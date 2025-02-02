//
//  NotificationDispatch-Extension.swift
//  Notification Agent
//
//  Created by Simone Martorelli on 5/27/21.
//  Copyright © 2021 IBM Inc. All rights reserved
//  SPDX-License-Identifier: Apache2.0
//

import Foundation
import Cocoa

extension NotificationDispatch {
    /// Handle the received notification and send the notification object to the correct controller.
    /// - Parameter notification: the received notification.
    @objc
    func receivedNotification(_ notification: Notification) {
        guard let object = notification.userInfo?["object"] as? NotificationObject else { return }
        guard let pages = object.payload?.pages else { return }
        let onboardingViewController = OnboardingViewController(with: pages)
        let window = NSWindow(contentViewController: onboardingViewController)
        window.styleMask.remove(.resizable)
        if object.forceLightMode ?? false {
            window.appearance = NSAppearance(named: .aqua)
        }
        window.title = ""
        window.titlebarAppearsTransparent = true
        window.center()
        window.delegate = onboardingViewController
        window.makeKeyAndOrderFront(self)
    }
}
