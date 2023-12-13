//
//  Utils+Additions.swift
//  mock-up-ribs
//
//  Created by dongkyulee on 2023/12/12.
//

import UIKit

public final class Jarvis {
    
    //MARK: 싱글톤 클래스 선언
    public static let shared: Jarvis = Jarvis()
    
    //init 으로 instance 생성하는 것을 막는 용도. (init() 함수 접근 제어자를 private로 지정)
    private init() { }
}


//MARK: - 전역으로 사용할 헬퍼 메소드 구현
extension Jarvis { }


//MARK: - 유틸리티
extension UIView {
    func roundCorners(_ radius: CGFloat = 8) {
        self.layer.cornerCurve = .continuous
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
}

enum DismissButtonType {
    case back, close
    
    var systemIconName: String {
        switch self {
        case .back: return "chevron.backward"
        case .close: return "xmark"
        }
    }
}

enum TabbarIconType {
    case home
    case homeFilled
    
    var systemName: String {
        switch self {
        case .home: return "house"
        case .homeFilled:return "house.fill"
        }
    }
}

extension CALayer {
    // Sketch 스타일의 그림자를 생성하는 유틸리티 함수
    func applyShadow(
        color: UIColor = .black,
        alpha: Float = 0.5,
        x: CGFloat = 0,
        y: CGFloat = 2,
        blur: CGFloat = 4
    ) {
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
    }
}

extension UITabBar {
    /// 기본 그림자 스타일을 초기화해야 커스텀 스타일을 적용할 수 있다.
    static func clearShadow() {
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().backgroundColor = UIColor.white
    }
}

extension UIViewController {
    /// leftBarButtonItem 세팅해주는 유틸리티
    func setupNavigationItem(with buttonType: DismissButtonType, target: Any?, action: Selector?) {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(
                systemName: buttonType.systemIconName,
                withConfiguration: UIImage.SymbolConfiguration(pointSize: 18, weight: .regular))?.withTintColor(.black, renderingMode: .alwaysOriginal),
            style: .plain,
            target: target,
            action: action
        )
    }
}
