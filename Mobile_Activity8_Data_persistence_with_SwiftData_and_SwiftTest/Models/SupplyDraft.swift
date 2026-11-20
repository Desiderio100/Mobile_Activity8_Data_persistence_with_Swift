//
//  SupplyDraft.swift
//  Mobile_Activity8_Data_persistence_with_SwiftData_and_SwiftTest
//
//  Created by Desiderio Ortegon morton on 08/11/26.
//

import Foundation

/// Editable copy of a supply used by the form.
/// Nothing is stored until the view model validates and saves it.
struct SupplyDraft {
    var name = ""
    var category = SupplyCategory.woundCare
    var quantity = 1
    var expirationDate = Calendar.current.date(byAdding: .year, value: 1, to: .now) ?? .now
    var usageNotes = ""

    init() {}

    init(supply: Supply) {
        name = supply.name
        category = supply.category
        quantity = supply.quantity
        expirationDate = supply.expirationDate
        usageNotes = supply.usageNotes
    }

    var isValid: Bool {
        Supply.isValidName(name) && Supply.isValidQuantity(quantity)
    }
}
