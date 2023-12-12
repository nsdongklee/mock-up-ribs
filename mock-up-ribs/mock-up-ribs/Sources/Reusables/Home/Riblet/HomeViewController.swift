//
//  HomeViewController.swift
//  mock-up-ribs
//
//  Created by dongkyulee on 2023/12/12.
//

import RIBs
import RxSwift
import UIKit

protocol HomePresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class HomeViewController: UIViewController, HomePresentable, HomeViewControllable {

    weak var listener: HomePresentableListener?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setupViews()
    }
      
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }

    private func setupViews() {
        view.backgroundColor = .systemGray6
        setupBarItems()
    }
    
    private func setupBarItems() {
        /// 탭 바 세팅
        tabBarItem = UITabBarItem(
            title: "홈",
            image: UIImage(
                systemName: TabbarIconType.home.systemName,
                withConfiguration: UIImage.SymbolConfiguration(pointSize: 18, weight: .regular)
            )?.withTintColor(.systemBlue, renderingMode: .alwaysOriginal),
            selectedImage: UIImage(
                systemName: TabbarIconType.homeFilled.systemName,
                withConfiguration: UIImage.SymbolConfiguration(pointSize: 18, weight: .regular)
            )?.withTintColor(.systemBlue, renderingMode: .alwaysOriginal)
        )
    }
}
