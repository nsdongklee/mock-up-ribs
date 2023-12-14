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
extension Jarvis {
    
    public func validate(id: String) -> Bool {
        let num = Int(id) ?? 0
        return (1 <= num && num <= 10)
    }
    
    public func validate(pw: String) -> Bool {
        return pw.count >= 5
    }
    
    public func addSpliter(containerHeight: CGFloat = CGFloat(3.5), lineHeight: CGFloat = CGFloat(0.8), offset: CGFloat? = nil) -> UIView {
        let containerView: UIView = {
            let v = UIView()
            v.backgroundColor = .white
            return v
        }()
        
        let lineView: UIView = {
            let v = UIView()
            v.backgroundColor = .systemGray4
            return v
        }()
        
        containerView.addSubview(lineView)
        containerView.snp.makeConstraints { make in
            make.height.equalTo(containerHeight)
        }
        
        if let offset = offset {
            lineView.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.left.equalToSuperview().offset(offset)
                make.right.equalToSuperview().offset(-offset)
                make.height.equalTo(lineHeight)
            }
        } else {
            lineView.snp.makeConstraints { make in
                make.width.centerY.equalToSuperview()
                make.height.equalTo(lineHeight)
            }
        }
        
        return containerView
    }
}


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

/// arrangedSubviews 전체 삭제
extension UIStackView {
    @discardableResult
    func removeAllArrangedSubviews() -> [UIView] {
        return arrangedSubviews.reduce([UIView]()) { $0 + [removeArrangedSubViewProperly($1)] }
    }

    func removeArrangedSubViewProperly(_ view: UIView) -> UIView {
        removeArrangedSubview(view)
        NSLayoutConstraint.deactivate(view.constraints)
        view.removeFromSuperview()
        return view
    }
}

//MARK: - 버튼 상태에 따라 백그라운드 컬러 변경
extension UIButton {
    func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
        UIGraphicsBeginImageContext(CGSize(width: 1.0, height: 1.0))
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setFillColor(color.cgColor)
        context.fill(CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0))
        
        let backgroundImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
         
        self.setBackgroundImage(backgroundImage, for: state)
    }
}
