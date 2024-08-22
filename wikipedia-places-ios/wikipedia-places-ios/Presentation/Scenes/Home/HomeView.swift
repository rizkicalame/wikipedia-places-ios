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

    var body: some View {
        switch viewModel.state {
        case .loading:
            ProgressView()
                .task {
                    await self.viewModel.fetchLocations()
                }
        case .error(let error):
            errorView(error: error)
        case .loaded:
            loadedView()
        }
    }

    func loadedView() -> some View {
        List(viewModel.locations) { location in
            Button(action: {
                self.viewModel.onRowTapped(location: location)
            }, label: {
                VStack(alignment: .leading) {
                    Text(location.presentedName)
                    Text(location.presentedCoordinates)
                }
            })
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

#Preview {
    HomeView(viewModel: HomeViewModel(getLocationsUseCase: GetLocationsUseCase(repository: LocationsRepository(apiClient: APIClient(baseURL: "")))))
}
