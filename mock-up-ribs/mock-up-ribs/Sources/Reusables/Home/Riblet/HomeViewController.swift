//
//  HomeViewController.swift
//  mock-up-ribs
//
//  Created by dongkyulee on 2023/12/12.
//

import RIBs
import RxSwift
import UIKit
import SnapKit

protocol HomePresentableListener: AnyObject {
    func didTapFollowers()
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
        
        addonFollowerButton()
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
    
    /// 임의의 팔로워 리스트 확인
    private func addonFollowerButton() {
        let btn: UIButton = {
            let b = UIButton()
            b.setTitle("팔로워", for: .normal)
            b.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
            b.setTitleColor(.white, for: .normal)
            b.backgroundColor = .systemBlue
            b.addTarget(self, action: #selector(didTapFollowerButton), for: .touchUpInside)
            b.roundCorners()
            return b
        }()
        
        view.addSubview(btn)
        
        btn.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(30)
            make.width.equalTo(60)
        }
    }
    
    @objc private func didTapFollowerButton(_ sender: UIButton) {
        listener?.didTapFollowers()
    }
}
