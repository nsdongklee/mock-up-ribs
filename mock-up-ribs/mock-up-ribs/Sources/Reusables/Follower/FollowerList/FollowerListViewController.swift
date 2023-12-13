//
//  FollowerListViewController.swift
//  mock-up-ribs
//
//  Created by dongkyulee on 2023/12/13.
//

import RIBs
import RxSwift
import UIKit
import SnapKit

protocol FollowerListPresentableListener: AnyObject {
    func didTapBackButton()
}

final class FollowerListViewController: UIViewController, FollowerListPresentable, FollowerListViewControllable {
    
    private let disposeBag = DisposeBag()
    
    var viewModel: UserViewModel = UserViewModel()

    weak var listener: FollowerListPresentableListener?
    
    private let scrollView: UIScrollView = {
        let s = UIScrollView()
        s.showsVerticalScrollIndicator = false
        return s
    }()
    
    private let containerStackView: UIStackView = {
        let s = UIStackView()
        s.axis = .vertical
        s.alignment = .fill
        s.distribution = .fill
        s.spacing = 0
        s.backgroundColor = .white
        return s
    }()
    
    init(dismissButtonType: DismissButtonType) {
        super.init(nibName: nil, bundle: nil)
        setupViews()
        setupNavigationItem(with: dismissButtonType, target: self, action: #selector(didTapBackButton))
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    private func setupViews() {
        title = "팔로워"
        view.backgroundColor = .white
        
        bind()
    }
    
    private func bind() {
        //viewModel.followersRx
            //.bind(to: <#T##[UserModel]?...##[UserModel]?#>)
            //.disposed(by: disposeBag)
    }
    
    @objc private func didTapBackButton(_ sender: UIButton) {
        listener?.didTapBackButton()
    }
}
