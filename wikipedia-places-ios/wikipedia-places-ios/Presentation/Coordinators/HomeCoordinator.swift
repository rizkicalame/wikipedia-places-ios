//
//  HomeCoordinator.swift
//  wikipedia-places-ios
//
//  Created by Rizki Calame on 22/08/2024.
//

import UIKit
import SwiftUI

final class HomeCoordinator: CoordinatorInterface {

    // MARK: - Properties

    private let navigationController: UINavigationController
    private let baseDependencies: any BaseDependenciesInterface

    private var homeViewModel: HomeViewModel?
    private weak var presentingNavigationController: UINavigationController?

    // MARK: - Init

    init(baseDependencies: BaseDependenciesInterface,
         navigationController: UINavigationController) {
        self.baseDependencies = baseDependencies
        self.navigationController = navigationController
    }

    // MARK: - CoordinatorInterface

    func start() {
        let homeViewController = makeHomeViewController()
        navigationController.setViewControllers([homeViewController], animated: false)
    }

    // MARK: - Private

    @objc
    private func onCloseTapped() {
        dismissFlow(onCompletion: nil)
    }

    private func dismissFlow(onCompletion: (() -> Void)?) {
        presentingNavigationController?.dismiss(animated: true) {
            onCompletion?()
        }
        presentingNavigationController = nil
    }

    private func deeplinkToWikipedia(location: LocationDomainModel) {
        let wikiCoordinator = WikipediaCoordinator(location: location,
                                                   navigationController: self.navigationController,
                                                   urlOpener: baseDependencies.urlOpener,
                                                   errorHandler: baseDependencies.errorHandler)
        wikiCoordinator.start()
    }

    // MARK: - Home

    /// Bootstrap dependencies for `Home`.
    /// Could be moved into a factory method or using dependency containers.
    /// - Returns: UIViewController for home
    private func makeHomeViewController() -> UIViewController {
        let repository = LocationsRepository(apiClient: baseDependencies.apiClient,
                                             customLocationsCache: baseDependencies.customLocationsCache)
        let getLocationsUseCase = GetLocationsUseCase(repository: repository)
        let viewModel = HomeViewModel(getLocationsUseCase: getLocationsUseCase)
        self.homeViewModel = viewModel

        homeViewModel?.onAddCustomLocationTapped = { [weak self] in
            self?.presentAddCustomLocationView()
        }

        homeViewModel?.onLocationTapped = { [weak self] location in
            self?.deeplinkToWikipedia(location: location)
        }

        let view = HomeView(viewModel: viewModel)
        return UIHostingController(rootView: view)
    }

    private func refreshHomeViewController() {
        Task {
           await homeViewModel?.refreshLocations()
        }
    }

    // MARK: - AddCustomLocation

    private func presentAddCustomLocationView() {
        let viewController = makeAddCustomLocationViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        viewController.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Close", style: .done, target: self, action: #selector(onCloseTapped))
        self.navigationController.present(navigationController, animated: true)

        presentingNavigationController = self.navigationController
    }

    /// Bootstrap dependencies for `AddCustomLocations`.
    /// Could be moved into a factory method or using dependency containers.
    /// - Returns: UIViewController for `AddCustomLocations`
    private func makeAddCustomLocationViewController() -> UIViewController {
        let repository = LocationsRepository(apiClient: baseDependencies.apiClient,
                                             customLocationsCache: baseDependencies.customLocationsCache)
        let useCase = AddCustomLocationUseCase(repository: repository)
        let viewModel = AddCustomLocationViewModel(useCase: useCase)

        viewModel.onAddCustomLocationTapped = { [weak self] in
            self?.dismissFlow {
                self?.refreshHomeViewController()
            }
        }

        let view = AddCustomLocationView(viewModel: viewModel)
        return UIHostingController(rootView: view)
    }
}
