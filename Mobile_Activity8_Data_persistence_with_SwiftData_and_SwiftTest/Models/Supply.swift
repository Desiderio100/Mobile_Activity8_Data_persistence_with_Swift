//
//  Supply.swift
//  Mobile_Activity8_Data_persistence_with_SwiftData_and_SwiftTest
//
//  Created by Desiderio Ortegon morton on 08/11/26.
//

import Foundation
import SwiftData

/// A first aid kit item stored on the device with SwiftData.
@Model
final class Supply {
    var name: String
    var category: SupplyCategory
    var quantity: Int
    var expirationDate: Date
    var usageNotes: String

    init(
        name: String,
        category: SupplyCategory,
        quantity: Int,
        expirationDate: Date,
        usageNotes: String = ""
    ) {
        self.name = name
        self.category = category
        self.quantity = quantity
        self.expirationDate = expirationDate
        self.usageNotes = usageNotes
    }

    var expirationStatus: ExpirationStatus {
        ExpirationStatus(expirationDate: expirationDate)
    }
}

// MARK: - Business rules

extension Supply {
    static func isValidName(_ name: String) -> Bool {
        !name.trimmed.isEmpty
    }

    static func isValidQuantity(_ quantity: Int) -> Bool {
        quantity > 0
    }
}
