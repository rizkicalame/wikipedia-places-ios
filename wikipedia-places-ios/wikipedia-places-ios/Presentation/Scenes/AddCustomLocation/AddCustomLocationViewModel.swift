//
//  AddCustomLocationViewModel.swift
//  wikipedia-places-ios
//
//  Created by Rizki Calame on 23/08/2024.
//

import Foundation

@MainActor
final class AddCustomLocationViewModel: ObservableObject {

    // MARK: - Events

    var onAddCustomLocationTapped: (() -> Void)?

    // MARK: - State

    enum State: Equatable {
        case unknownError
        case error(AddCustomLocationUseCase.ValidationErrors)
        case idle
    }

    // MARK: - Published variables

    @Published var nameOfLocation: String = ""
    @Published var latitude: String = ""
    @Published var longitude: String = ""
    @Published var state: State = .idle

    // MARK: - Computed

    var shouldDisplayErrorMessage: Bool {
        return state != .idle
    }

    // MARK: - Properties

    private let useCase: AddCustomLocationUseCaseInterface

    // MARK: - Init

    init(useCase: AddCustomLocationUseCaseInterface) {
        self.useCase = useCase
    }

    // MARK: - Internal

    func onSubmitTapped() {
        addCustomLocation()
    }

    // MARK: - Private

    private func addCustomLocation() {
        Task {
            do {
                try await useCase.addCustomLocation(name: nameOfLocation,
                                              latitude: latitude,
                                              longitude: longitude)
                onAddCustomLocationTapped?()
            } catch {
                guard let error = error as? AddCustomLocationUseCase.ValidationErrors else {
                    return state = .unknownError
                }

                state = .error(error)
            }
        }
    }
}
