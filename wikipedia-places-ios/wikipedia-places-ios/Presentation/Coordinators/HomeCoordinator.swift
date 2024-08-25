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

    private func deeplinkToWikipedia(location: LocationDomainModel) {
        guard let url = URL(string: WikipediaDeeplinkHelper.getCoordinatesDeeplinkURL(location: location)) else {
            return
        }

        UIApplication.shared.open(url) { success in
            if !success {
                // Error handling
                let alertController = UIAlertController(title: "Oops! Deeplinking failed.", message: "We weren't able to deeplinking to the Wikipedia app.", preferredStyle: .alert)
                let action = UIAlertAction(title: "Close", style: .cancel)
                alertController.addAction(action)
                self.navigationController.present(alertController, animated: true)
            }
        }
    }

    // MARK: - Home


    @MainActor
    /// Bootstrap dependencies for `Home`.
    /// Could be moved into a factory method or using dependency containers.
    /// - Returns: UIViewController for home
    private func makeHomeViewController() -> UIViewController {
        let apiClient = APIClient(baseURL: Configuration.value(for: .apiURL))
        let repository = LocationsRepository(apiClient: apiClient)
        let getLocationsUseCase = GetLocationsUseCase(repository: repository)
        homeViewModel = HomeViewModel(getLocationsUseCase: getLocationsUseCase)
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

    /// Bootstrap dependencies for `AddCustomLocations`.
    /// Could be moved into a factory method or using dependency containers.
    /// - Returns: UIViewController for `AddCustomLocations`
    private func makeAddCustomLocationViewController() -> UIViewController {
        let apiClient = APIClient(baseURL: Configuration.value(for: .apiURL))
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

    func didTapLocation(location: LocationDomainModel, sender: HomeViewModel) {
        deeplinkToWikipedia(location: location)
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
