//
//  FollowerListBuilder.swift
//  mock-up-ribs
//
//  Created by dongkyulee on 2023/12/13.
//

import RIBs

protocol FollowerListDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class FollowerListComponent: Component<FollowerListDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol FollowerListBuildable: Buildable {
    func build(withListener listener: FollowerListListener) -> FollowerListRouting
}

final class FollowerListBuilder: Builder<FollowerListDependency>, FollowerListBuildable {

    override init(dependency: FollowerListDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: FollowerListListener) -> FollowerListRouting {
        let component = FollowerListComponent(dependency: dependency)
        let viewController = FollowerListViewController(dismissButtonType: .close)
        let interactor = FollowerListInteractor(presenter: viewController)
        interactor.listener = listener
        return FollowerListRouter(interactor: interactor, viewController: viewController)
    }
}
