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
        static let listPadding = EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0)
    }

    // MARK: - ViewModel

    @ObservedObject var viewModel: HomeViewModel

    // MARK: - Init

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }

    // MARK: - View

    var body: some View {
        switch viewModel.state {
        case .loading:
            loadingView()
        case .error(let error):
            errorView(error: error)
        case .loaded:
            loadedView()
        }
    }

    func loadingView() -> some View {
        ProgressView()
            .task {
                await self.viewModel.fetchLocations()
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

                } label: {
                    Text("Add custom location")
                }

            }
        }
        .padding(Constants.listPadding)
        .refreshable {
            await self.viewModel.fetchLocations()
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
