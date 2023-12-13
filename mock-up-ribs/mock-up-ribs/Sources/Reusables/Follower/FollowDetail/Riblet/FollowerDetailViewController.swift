//
//  FollowerDetailViewController.swift
//  mock-up-ribs
//
//  Created by dongkyulee on 2023/12/13.
//

import RIBs
import RxSwift
import UIKit

protocol FollowerDetailPresentableListener: AnyObject {
    func didTapBackButton()
}

final class FollowerDetailViewController: UIViewController, FollowerDetailPresentable, FollowerDetailViewControllable {

    weak var listener: FollowerDetailPresentableListener?
    
    private let scrollView: UIScrollView = {
        let s = UIScrollView()
        s.backgroundColor = .systemGray6
        s.showsVerticalScrollIndicator = false
        return s
    }()
    
    private let containerStackView: UIStackView = {
        let s = UIStackView()
        s.axis = .vertical
        s.alignment = .fill
        s.distribution = .fill
        s.spacing = 8
        s.backgroundColor = .systemGray6
        s.layoutMargins = .init(top: 56, left: 16, bottom: 8, right: 16)
        s.isLayoutMarginsRelativeArrangement = true
        return s
    }()
    
    private let userInfo: UserModel
    
    init(dismissButtonType: DismissButtonType, userInfo: UserModel) {
        self.userInfo = userInfo
        super.init(nibName: nil, bundle: nil)
        setupViews()
        setupNavigationItem(with: dismissButtonType, target: self, action: #selector(didTapBackButton))
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupViews() {
        title = "프로필"
        view.backgroundColor = .systemGray6
        
        view.addSubview(scrollView)
        scrollView.addSubview(containerStackView)
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        containerStackView.snp.makeConstraints { make in
            make.top.equalTo(scrollView.contentLayoutGuide.snp.top)
            make.bottom.equalTo(scrollView.contentLayoutGuide.snp.bottom)
            make.width.centerX.equalToSuperview()
        }
        
        configure()
    }
    
    private func configure() {
        let cell = FollowerCell(
            id: self.userInfo.id,
            name: self.userInfo.name,
            userName: self.userInfo.username,
            email: self.userInfo.email
        )
        
        cell.snp.makeConstraints { make in
            make.height.equalTo(78)
        }
        
        containerStackView.addArrangedSubview(cell)
        
        let detail = UserDetailCell(
            addr: self.userInfo.address,
            company: self.userInfo.company,
            phone: self.userInfo.phone,
            website: self.userInfo.website
        )
        
        containerStackView.addArrangedSubview(detail)
    }
    
    @objc private func didTapBackButton(_ sender: UIButton) {
        listener?.didTapBackButton()
    }
}
