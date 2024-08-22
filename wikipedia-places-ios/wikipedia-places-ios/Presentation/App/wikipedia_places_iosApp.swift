//
//  wikipedia_places_iosApp.swift
//  wikipedia-places-ios
//
//  Created by Rizki Calame on 21/08/2024.
//

import SwiftUI

@main
struct wikipedia_places_iosApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView(viewModel: makeHomeViewModel())
        }
    }

    @MainActor
    private func makeHomeViewModel() -> HomeViewModel {
        let apiClient = APIClient(baseURL: try! Configuration.value(for: "API_URL"))
        let repository = LocationsRepository(apiClient: apiClient)
        let useCase = GetLocationsUseCase(repository: repository)
        let viewModel = HomeViewModel(getLocationsUseCase: useCase)
        return viewModel
    }
}
