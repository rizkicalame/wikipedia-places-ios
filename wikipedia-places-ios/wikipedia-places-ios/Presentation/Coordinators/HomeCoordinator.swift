//
//  HomeCoordinator.swift
//  wikipedia-places-ios
//
//  Created by Rizki Calame on 22/08/2024.
//

import UIKit
import SwiftUI

class HomeCoordinator: CoordinatorInterface {

    // MARK: - Properties

    private let navigationController: UINavigationController

    // MARK: - Home

    private var homeViewController: UIViewController?
    private var homeViewModel: HomeViewModel?

    // MARK: - Init

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: - CoordinatorInterface

    @MainActor 
    func start() {
        self.homeViewController = makeHomeViewController()
        self.navigationController.setViewControllers([homeViewController!], animated: false)
    }

    // MARK: - Private

    @objc
    private func dismissNavigationController() {
        self.navigationController.dismiss(animated: true)
    }

    // MARK: - Home

    @MainActor
    private func makeHomeViewController() -> UIViewController {
        let apiClient = APIClient(baseURL: try! Configuration.value(for: "API_URL"))
        let repository = LocationsRepository(apiClient: apiClient)
        let getLocationsUseCase = GetLocationsUseCase(repository: repository)
        let addCustomLocationUseCase = AddCustomLocationUseCase(repository: repository)
        homeViewModel = HomeViewModel(getLocationsUseCase: getLocationsUseCase,
                                      addCustomLocationUseCase: addCustomLocationUseCase)
        homeViewModel?.delegate = self
        let view = HomeView(viewModel: homeViewModel!)
        return UIHostingController(rootView: view)
    }

    @MainActor
    private func refreshHomeViewController() async {
       await homeViewModel?.refreshLocations()
    }

    // MARK: - AddCustomLocation

    private func presentAddCustomLocationView() {
        let viewController = makeAddCustomLocationViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        viewController.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Close", style: .done, target: self, action: #selector(dismissNavigationController))
        self.navigationController.present(navigationController, animated: true)
    }

    private func makeAddCustomLocationViewController() -> UIViewController {
        let apiClient = APIClient(baseURL: try! Configuration.value(for: "API_URL"))
        let repository = LocationsRepository(apiClient: apiClient)
        let useCase = AddCustomLocationUseCase(repository: repository)
        let viewModel = AddCustomLocationViewModel(useCase: useCase)
        viewModel.delegate = self
        let view = AddCustomLocationView(viewModel: viewModel)
        return UIHostingController(rootView: view)
    }
}

// MARK: - HomeViewModelDelegate

extension HomeCoordinator: HomeViewModelDelegate {
    func didTapAddCustomLocation(sender: HomeViewModel) {
        presentAddCustomLocationView()
    }
}

// MARK: - AddCustomLocationViewModelDelegate

extension HomeCoordinator: AddCustomLocationViewModelDelegate {
    func didAddCustomLocation(sender: AddCustomLocationViewModel) {
        // Dismiss prior to refreshing
        self.navigationController.dismiss(animated: true)

        Task {
            await refreshHomeViewController()
        }
    }
}
