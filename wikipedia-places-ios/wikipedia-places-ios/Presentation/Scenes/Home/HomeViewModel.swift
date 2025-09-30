//
//  HomeViewModel.swift
//  wikipedia-places-ios
//
//  Created by Rizki Calame on 21/08/2024.
//

import Foundation
import UIKit

@MainActor
final class HomeViewModel: ObservableObject {

    // MARK: - Events

    var onAddCustomLocationTapped: (() -> Void)?
    var onLocationTapped: ((LocationDomainModel) -> Void)?

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

    // MARK: - Init

    init(getLocationsUseCase: GetLocationsUseCaseInterface) {
        self.getLocationsUseCase = getLocationsUseCase
    }

    // MARK: - Internal

    /// Refreshes the locations
    func refreshLocations() async {
        do {
            let locations = try await getLocationsUseCase.getLocations()
            handleLocations(locations)
        } catch {
            handleError(error)
        }
    }

    func onRowTapped(location: LocationDomainModel) {
        onLocationTapped?(location)
    }

    func addCustomLocation() {
        onAddCustomLocationTapped?()
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
