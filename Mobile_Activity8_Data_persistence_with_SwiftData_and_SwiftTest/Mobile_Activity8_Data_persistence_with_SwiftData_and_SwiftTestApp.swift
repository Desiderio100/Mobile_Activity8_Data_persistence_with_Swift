//
//  Mobile_Activity8_Data_persistence_with_SwiftData_and_SwiftTestApp.swift
//  Mobile_Activity8_Data_persistence_with_SwiftData_and_SwiftTest
//
//  Created by Desiderio Ortegon morton on 20/10/26.
//

import SwiftData
import SwiftUI

@main
struct Mobile_Activity8_Data_persistence_with_SwiftData_and_SwiftTestApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Supply.self)
    }
}
