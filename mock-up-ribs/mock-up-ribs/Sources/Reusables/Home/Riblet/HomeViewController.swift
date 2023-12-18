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
    func didTapLogin()
}

final class HomeViewController: UIViewController, HomePresentable, HomeViewControllable {

    private let loginableEmptyView = LoginableEmptyView()
    
    private var myProfileView: MyProfileView? = nil
    
    private let disposeBag = DisposeBag()
    
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
        addonEmptyView()
        bind()
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
    
    private func addonEmptyView() {
        view.addSubview(loginableEmptyView)
        
        loginableEmptyView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func bind() {
        loginableEmptyView.delegate = self
        
        LoginGlobalRepository.shared.subscribableUserInfo
            .bind { [weak self] myInfo in
                self?.configureLoggedIn(with: myInfo)
            }
            .disposed(by: disposeBag)
    }
    
    private func configureLoggedIn(with model: UserModel?) {
        if let model = model {
            if self.myProfileView != nil { return }
            let myProfile = MyProfileView(myInfo: model)
            myProfile.eventDelegate = self
            self.myProfileView = myProfile
            view.addSubview(myProfile)
            myProfile.snp.makeConstraints { make in
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
                make.left.right.equalToSuperview()
                make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            }
            self.loginableEmptyView.isHidden = true
            self.myProfileView?.isHidden = false
            title = "내 정보"
        } else {
            if self.myProfileView == nil { return }
            self.myProfileView?.removeFromSuperview()
            self.myProfileView = nil
            self.loginableEmptyView.isHidden = false
            title = ""
        }
    }
}


//MARK: - 로그인 시도 델리게이트
extension HomeViewController: LoginableEmptyViewDelegate {
    
    func didTapLogin() {
        listener?.didTapLogin()
    }
}

//MARK: - 프로필 델리게이트
extension HomeViewController: MyProfileViewDelegate {
    
    func didTapFollowers() {
        listener?.didTapFollowers()
    }
}
