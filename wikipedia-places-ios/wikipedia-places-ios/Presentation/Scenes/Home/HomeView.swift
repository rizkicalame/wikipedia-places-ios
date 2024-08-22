//
//  ContentView.swift
//  wikipedia-places-ios
//
//  Created by Rizki Calame on 21/08/2024.
//

import SwiftUI

struct HomeView: View {

    @ObservedObject var viewModel: HomeViewModel

    // MARK: - Init

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack {
            Button("Open Wiki") {
                let url = URL(string: "wikipedia://places/?WMFPlacesCoordinates=52.3547498,4.8339215")!
                UIApplication.shared.open(url)
            }
        }
        .padding()
        .task {
            await viewModel.fetchLocations()
        }
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel(getLocationsUseCase: GetLocationsUseCase()))
}
