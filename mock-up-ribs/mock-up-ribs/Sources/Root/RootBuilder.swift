//
//  RootBuilder.swift
//  mock-up-ribs
//
//  Created by dongkyulee on 2023/12/12.
//

import RIBs

protocol RootDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class RootComponent:
    Component<RootDependency>,
    HomeDependency
{

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol RootBuildable: Buildable {
    /// 루트여서 리스너 파라미터 제거
    func build() -> (launchRouter: LaunchRouting, urlHandler: URLHandler)
}

final class RootBuilder: Builder<RootDependency>, RootBuildable {

    override init(dependency: RootDependency) {
        super.init(dependency: dependency)
    }

    func build() -> (launchRouter: LaunchRouting, urlHandler: URLHandler) {
        let tabBarViewController = RootTabBarController()
        let component = RootComponent(dependency: dependency)
        let interactor = RootInteractor(presenter: tabBarViewController)
        
        //interactor.listener = listener -> 루트는 리스닝하고 있는 상위 리블렛이 없음.
        
        let homeBuilder = HomeBuilder(dependency: component)
        
        let router = RootRouter(
            interactor: interactor,
            viewController: tabBarViewController,
            homeBuildable: homeBuilder
        )
        
        return (router, interactor)
    }
}
