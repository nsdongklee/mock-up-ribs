//
//  FollowerDetailBuilder.swift
//  mock-up-ribs
//
//  Created by dongkyulee on 2023/12/13.
//

import RIBs

protocol FollowerDetailDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class FollowerDetailComponent: Component<FollowerDetailDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol FollowerDetailBuildable: Buildable {
    func build(withListener listener: FollowerDetailListener) -> FollowerDetailRouting
}

final class FollowerDetailBuilder: Builder<FollowerDetailDependency>, FollowerDetailBuildable {

    override init(dependency: FollowerDetailDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: FollowerDetailListener) -> FollowerDetailRouting {
        let component = FollowerDetailComponent(dependency: dependency)
        let viewController = FollowerDetailViewController()
        let interactor = FollowerDetailInteractor(presenter: viewController)
        interactor.listener = listener
        return FollowerDetailRouter(interactor: interactor, viewController: viewController)
    }
}
