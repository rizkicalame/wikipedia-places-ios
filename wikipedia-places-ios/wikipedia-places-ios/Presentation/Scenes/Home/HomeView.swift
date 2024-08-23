//
//  ContentView.swift
//  wikipedia-places-ios
//
//  Created by Rizki Calame on 21/08/2024.
//

import SwiftUI

struct HomeView: View {

    // MARK: - Constants

    enum Constants {

    }

    // MARK: - ViewModel

    @ObservedObject var viewModel: HomeViewModel

    // MARK: - Init

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }

    // MARK: - View

    var body: some View {
        Group {
            switch viewModel.state {
            case .loading:
                loadingView()
            case .error(let error):
                errorView(error: error)
            case .loaded:
                loadedView()
            }
        }
        .navigationTitle("Locations")
    }

    func loadingView() -> some View {
        ProgressView()
            .task {
                await self.viewModel.refreshLocations()
            }
    }

    func loadedView() -> some View {
        List {
            Section {
                ForEach(self.viewModel.locations, id: \.id) { location in
                    LocationCellView(name: location.presentedName, 
                                     coordinates: location.presentedCoordinates) {
                        self.viewModel.onRowTapped(location: location)
                    }
                }
            }

            Section {
                Button {
                    self.viewModel.onAddCustomLocationTapped()
                } label: {
                    Text("Add custom location")
                }

            }
        }
        .refreshable {
            await self.viewModel.refreshLocations()
        }
    }

    func errorView(error: Error) -> some View {
        Text("Error: \(error)")
    }
}
//
//#Preview {
//    HomeView(viewModel: HomeViewModel(getLocationsUseCase: GetLocationsUseCase(repository: LocationsRepository(apiClient: APIClient(baseURL: ""))), addCustomLocationUseCase: AddCustomLocationUseCase(repository: LocationsRepository(apiClient: APIClient(baseURL: "")))))
//}
