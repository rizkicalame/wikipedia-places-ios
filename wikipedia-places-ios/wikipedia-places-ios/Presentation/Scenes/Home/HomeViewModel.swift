//
//  HomeViewModel.swift
//  wikipedia-places-ios
//
//  Created by Rizki Calame on 21/08/2024.
//

import Foundation
import UIKit

protocol HomeViewModelDelegate: AnyObject {
    func didTapAddCustomLocation(sender: HomeViewModel)
}

@MainActor
final class HomeViewModel: ObservableObject {

    // MARK: - State

    enum State {
        case error(Error)
        case loading
        case loaded
    }

    // MARK: - Publishable objects

    @Published var locations: [LocationDomainModel] = []
    @Published var state: State = .loading

    // MARK: - Properties

    private let getLocationsUseCase: GetLocationsUseCaseInterface
    private let addCustomLocationUseCase: AddCustomLocationUseCase

    weak var delegate: HomeViewModelDelegate?

    // MARK: - Init

    init(getLocationsUseCase: GetLocationsUseCaseInterface,
         addCustomLocationUseCase: AddCustomLocationUseCase) {
        self.getLocationsUseCase = getLocationsUseCase
        self.addCustomLocationUseCase = addCustomLocationUseCase
    }

    // MARK: - Internal

    func refreshLocations() async {
        do {
            let locations = try await getLocationsUseCase.getLocations()
            handleLocations(locations)
        } catch {
            handleError(error)
        }
    }

    func onRowTapped(location: LocationDomainModel) {
        let url = URL(string: "wikipedia://places/?WMFPlacesCoordinates=\(location.latitude),\(location.longitude)")!
        UIApplication.shared.open(url)
    }

    func onAddCustomLocationTapped() {
        delegate?.didTapAddCustomLocation(sender: self)
    }

    // MARK: - Private

    private func handleLocations(_ locations: [LocationDomainModel]) {
        state = .loaded
        self.locations = locations
    }

    private func handleError(_ error: Error) {
        state = .error(error)
    }
}
