//
//  HomeViewModel.swift
//  wikipedia-places-ios
//
//  Created by Rizki Calame on 21/08/2024.
//

import Foundation

@MainActor
final class HomeViewModel: ObservableObject {

    // MARK: - Properties

    private let getLocationsUseCase: GetLocationsUseCaseInterface

    // MARK: - Init

    init(getLocationsUseCase: GetLocationsUseCaseInterface) {
        self.getLocationsUseCase = getLocationsUseCase
    }

    // MARK: - Internal

    func fetchLocations() async {
        do {
            let locations = try await getLocationsUseCase.getLocations()
            handleLocations(locations)
        } catch {
            handleError(error)
        }
    }

    // MARK: - Private

    private func handleLocations(_ locations: [LocationDomainModel]) {
        print(locations)
    }

    private func handleError(_ error: Error) {
        print(error)
    }
}
