//
//  HomeBuilder.swift
//  mock-up-ribs
//
//  Created by dongkyulee on 2023/12/12.
//

import RIBs

protocol HomeDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class HomeComponent:
    Component<HomeDependency>,
    FollowerDependency
{
    var FollowerViewController: ViewControllable
    
    init(dependency: HomeDependency, FollowerViewController: ViewControllable) {
        self.FollowerViewController = FollowerViewController
        super.init(dependency: dependency)
    }
}

// MARK: - Builder

protocol HomeBuildable: Buildable {
    func build(withListener listener: HomeListener) -> HomeRouting
}

final class HomeBuilder: Builder<HomeDependency>, HomeBuildable {

    override init(dependency: HomeDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: HomeListener) -> HomeRouting {
        let viewController = HomeViewController()
        let component = HomeComponent(dependency: dependency, FollowerViewController: viewController)
        let interactor = HomeInteractor(presenter: viewController)
        interactor.listener = listener
        
        let followerBuilder = FollowerBuilder(dependency: component)
        
        return HomeRouter(
            interactor: interactor,
            viewController: viewController,
            followerBuildable: followerBuilder
        )
    }
}
