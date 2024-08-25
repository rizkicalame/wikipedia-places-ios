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
            case .error:
                errorView()
            case .loaded:
                loadedView()
            }
        }
        .navigationTitle(viewModel.navigationTitle)
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
                    Text(viewModel.addCustomLocationButtonTitle)
                }

            }
        }
        .refreshable {
            await self.viewModel.refreshLocations()
        }
    }

    func errorView() -> some View {
        Text(viewModel.errorText)
    }
}
