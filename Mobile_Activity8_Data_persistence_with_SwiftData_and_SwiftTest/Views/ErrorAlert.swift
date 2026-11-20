//
//  ErrorAlert.swift
//  Mobile_Activity8_Data_persistence_with_SwiftData_and_SwiftTest
//
//  Created by Desiderio Ortegon morton on 08/11/26.
//

import SwiftUI

/// State of an alert that tells the user why an operation failed.
struct ErrorAlert {
    var isPresented = false
    private(set) var title = ""
    private(set) var message = ""

    mutating func present(_ error: any Error, title: String) {
        self.title = title
        message = (error as? LocalizedError)?.errorDescription
            ?? "Ocurrió un error inesperado. Intenta de nuevo."
        isPresented = true
    }
}

extension View {
    func errorAlert(_ errorAlert: Binding<ErrorAlert>) -> some View {
        alert(errorAlert.wrappedValue.title, isPresented: errorAlert.isPresented) {
            Button("Aceptar", role: .cancel) {}
        } message: {
            Text(errorAlert.wrappedValue.message)
        }
    }
}
