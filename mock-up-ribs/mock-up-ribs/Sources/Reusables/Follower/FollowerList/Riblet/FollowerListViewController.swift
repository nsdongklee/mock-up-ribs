//
//  FollowerListViewController.swift
//  mock-up-ribs
//
//  Created by dongkyulee on 2023/12/13.
//

import RIBs
import RxSwift
import RxCocoa
import UIKit
import SnapKit

protocol FollowerListPresentableListener: AnyObject {
    func didTapBackButton()
    func didTapCell(id: Int?)
}

final class FollowerListViewController: UIViewController, FollowerListPresentable, FollowerListViewControllable {
    
    private let disposeBag = DisposeBag()
    
    var viewModel: UserViewModel = UserViewModel()

    weak var listener: FollowerListPresentableListener?
    
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
        s.layoutMargins = .init(top: 8, left: 16, bottom: 8, right: 16)
        s.isLayoutMarginsRelativeArrangement = true
        return s
    }()
    
    init(dismissButtonType: DismissButtonType) {
        super.init(nibName: nil, bundle: nil)
        setupViews()
        setupNavigationItem(with: dismissButtonType, target: self, action: #selector(didTapBackButton))
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupViews() {
        title = "팔로워"
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
        
        bind()
    }
    
    private func bind() {
        viewModel.followersRx
            .bind { [weak self] model in
                self?.update(by: model)
            }
            .disposed(by: disposeBag)
    }
    
    private func update(by model: [UserModel]?) {
        containerStackView.removeAllArrangedSubviews()
        
        model?.forEach({ m in
            let cell = FollowerCell(id: m.id, name: m.name, userName: m.username, email: m.email)
            cell.delegate = self
            cell.snp.makeConstraints { make in
                make.height.equalTo(78)
            }
            containerStackView.addArrangedSubview(cell)
        })
    }
    
    @objc private func didTapBackButton(_ sender: UIButton) {
        listener?.didTapBackButton()
    }
}


//MARK: - 셀 델리게이트
extension FollowerListViewController: FollowerCellDelegate {
    
    func didTapCell(id: Int?) {
        listener?.didTapCell(id: id)
    }
}
