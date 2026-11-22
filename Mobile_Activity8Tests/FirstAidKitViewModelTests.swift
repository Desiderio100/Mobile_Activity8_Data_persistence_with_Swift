//
//  FirstAidKitViewModelTests.swift
//  Mobile_Activity8Tests
//
//  Created by Desiderio Ortegon morton on 08/11/26.
//

import Foundation
import SwiftData
import Testing
@testable import Mobile_Activity8_Data_persistence_with_SwiftData_and_SwiftTest

// cada test usa una base en memoria para no mover los datos reales
@MainActor
struct FirstAidKitViewModelTests {
    private let container: ModelContainer
    private let viewModel: FirstAidKitViewModel

    init() throws {
        container = try ModelContainer(
            for: Supply.self,
            configurations: ModelConfiguration(isStoredInMemoryOnly: true)
        )
        viewModel = FirstAidKitViewModel()
        try viewModel.setContext(container.mainContext)
    }

    @Test("Adding a valid supply saves it with trimmed text")
    func addSavesSupply() throws {
        var draft = makeDraft(name: "  Gasas estériles  ")
        draft.usageNotes = "  Cubren heridas pequeñas.  "

        try viewModel.add(draft)

        #expect(viewModel.supplies.count == 1)
        #expect(viewModel.supplies.first?.name == "Gasas estériles")
        #expect(viewModel.supplies.first?.usageNotes == "Cubren heridas pequeñas.")
    }

    @Test("A supply without a name is rejected and nothing is saved")
    func emptyNameIsRejected() {
        #expect(throws: SupplyError.invalidName) {
            try viewModel.add(makeDraft(name: "   "))
        }
        #expect(viewModel.supplies.isEmpty)
    }

    @Test("Updating a supply stores the new values")
    func updateChangesSupply() throws {
        try viewModel.add(makeDraft(name: "Guantes de nitrilo"))
        let supply = try #require(viewModel.supplies.first)

        var draft = SupplyDraft(supply: supply)
        draft.quantity = 10
        try viewModel.update(supply, with: draft)

        #expect(viewModel.supplies.first?.quantity == 10)
    }

    @Test("Deleting a supply removes it from the kit")
    func deleteRemovesSupply() throws {
        try viewModel.add(makeDraft(name: "Venda elástica"))

        try viewModel.delete(viewModel.supplies)

        #expect(viewModel.supplies.isEmpty)
    }

    private func makeDraft(name: String) -> SupplyDraft {
        var draft = SupplyDraft()
        draft.name = name
        return draft
    }
}
