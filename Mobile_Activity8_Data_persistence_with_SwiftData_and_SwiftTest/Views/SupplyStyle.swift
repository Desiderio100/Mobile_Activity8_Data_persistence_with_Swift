//
//  SupplyStyle.swift
//  Mobile_Activity8_Data_persistence_with_SwiftData_and_SwiftTest
//
//  Created by Desiderio Ortegon morton on 08/11/26.
//

import SwiftUI

extension SupplyCategory {
    var symbolName: String {
        switch self {
        case .woundCare: "bandage.fill"
        case .medication: "pills.fill"
        case .protection: "facemask.fill"
        case .instruments: "scissors"
        case .other: "shippingbox.fill"
        }
    }

    var tint: Color {
        switch self {
        case .woundCare: .pink
        case .medication: .blue
        case .protection: .teal
        case .instruments: .indigo
        case .other: .brown
        }
    }
}

extension ExpirationStatus {
    var sectionTitle: String {
        switch self {
        case .expired: "Caducados"
        case .expiringSoon: "Caducan pronto"
        case .valid: "Vigentes"
        }
    }

    var tint: Color {
        switch self {
        case .expired: .red
        case .expiringSoon: .orange
        case .valid: .secondary
        }
    }
}
