//
//  FollowerBuilder.swift
//  mock-up-ribs
//
//  Created by dongkyulee on 2023/12/13.
//

import RIBs

protocol FollowerDependency: Dependency {
    var FollowerViewController: ViewControllable { get }
}

final class FollowerComponent:
    Component<FollowerDependency>,
    FollowerListDependency,
    FollowerDetailDependency
{

    // TODO: Make sure to convert the variable into lower-camelcase.
    fileprivate var FollowerViewController: ViewControllable {
        return dependency.FollowerViewController
    }

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol FollowerBuildable: Buildable {
    func build(withListener listener: FollowerListener) -> FollowerRouting
}

final class FollowerBuilder: Builder<FollowerDependency>, FollowerBuildable {

    override init(dependency: FollowerDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: FollowerListener) -> FollowerRouting {
        let component = FollowerComponent(dependency: dependency)
        let interactor = FollowerInteractor()
        interactor.listener = listener
        
        let followerListBuilder = FollowerListBuilder(dependency: component)
        let followerDetailBuilder = FollowerDetailBuilder(dependency: component)
        
        return FollowerRouter(
            interactor: interactor,
            viewController: component.FollowerViewController,
            followerListBuildable: followerListBuilder,
            followerDetailBuildable: followerDetailBuilder
        )
    }
}
