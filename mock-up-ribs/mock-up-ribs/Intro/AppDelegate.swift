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
    
    /// RIBs 의 루트 라우터
    private var launchRouter: LaunchRouting?
    
    /// URL 스키마 진입 핸들러
    /// AppDelegate -> RootInteractor 이동시켜서 처리
    private var urlHandler: URLHandler?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        return appInitialize(application)
    }

    /// 지원하는 앱 오리엔테이션
    func application(
        _ application: UIApplication,
        supportedInterfaceOrientationsFor window: UIWindow?
    ) -> UIInterfaceOrientationMask {
        return .portrait
    }
}

//MARK: - 초기화 로직
extension AppDelegate {
    
    /// 앱 부팅 > 초기화
    private func appInitialize(_ application: UIApplication) -> Bool {
        setupRootRiblet()
        return true
    }
    
    
    /// 루트 Scene 설정과 RIBs 트리의 루트 설정
    private func setupRootRiblet() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window

        window.overrideUserInterfaceStyle = .light
        window.backgroundColor = .white

        let router = RootBuilder(dependency: AppComponent()).build()
        self.launchRouter = router.launchRouter
        self.urlHandler = router.urlHandler
        
        launchRouter?.launch(from: window)
    }
}

//MARK: - 앱스키마 통신에 사용되는 핸들러
public protocol URLHandler: AnyObject {
    func handle(_ url: URL, in app: UIApplication)
}
