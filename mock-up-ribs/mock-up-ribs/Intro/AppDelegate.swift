//
//  AppDelegate.swift
//  mock-up-ribs
//
//  Created by dongkyulee on 2023/12/12.
//

import UIKit
import RIBs
import MockupKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    /// SceneDelegate 를 없애고 RIBs 가 Scene 을 통제
    var window: UIWindow?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    /// 지원하는 앱 오리엔테이션
    func application(
        _ application: UIApplication,
        supportedInterfaceOrientationsFor window: UIWindow?
    ) -> UIInterfaceOrientationMask {
        return .portrait
    }
}

