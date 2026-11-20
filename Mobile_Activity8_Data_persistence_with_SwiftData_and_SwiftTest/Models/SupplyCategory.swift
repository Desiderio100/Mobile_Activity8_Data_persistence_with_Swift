//
//  SupplyCategory.swift
//  Mobile_Activity8_Data_persistence_with_SwiftData_and_SwiftTest
//
//  Created by Desiderio Ortegon morton on 08/11/26.
//

import Foundation

nonisolated enum SupplyCategory: String, CaseIterable, Codable, Identifiable {
    case woundCare
    case medication
    case protection
    case instruments
    case other

    var id: Self { self }

    var title: String {
        switch self {
        case .woundCare: "Curación"
        case .medication: "Medicamento"
        case .protection: "Protección"
        case .instruments: "Instrumental"
        case .other: "Otro"
        }
    }
}
