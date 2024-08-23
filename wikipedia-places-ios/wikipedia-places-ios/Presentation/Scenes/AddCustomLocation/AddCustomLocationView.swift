//
//  AddCustomLocationView.swift
//  wikipedia-places-ios
//
//  Created by Rizki Calame on 22/08/2024.
//

import SwiftUI

protocol AddCustomLocationViewModelDelegate: AnyObject {
    func didAddCustomLocation(sender: AddCustomLocationViewModel)
}

struct AddCustomLocationView: View {
    @ObservedObject var viewModel: AddCustomLocationViewModel

    var body: some View {

        Form {
            Section {
                FormInputLabel(title: viewModel.locationFormTitle)
                FormInputField(placeholder: viewModel.locationPlaceholder,
                               textBinding: $viewModel.nameOfLocation)

                FormInputLabel(title: viewModel.latitudeFormTitle)
                FormInputField(placeholder: viewModel.latitudePlaceholder,
                               textBinding: $viewModel.latitude)


                FormInputLabel(title: viewModel.longitudeFormTitle)
                FormInputField(placeholder: viewModel.longitudePlaceholder,
                               textBinding: $viewModel.longitude)
            }

            Section {
                Button {
                    viewModel.onSubmitTapped()
                } label: {
                    Text(viewModel.submitButtonTitle)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
        }
        .navigationTitle(viewModel.navigationTitle)
    }
}
