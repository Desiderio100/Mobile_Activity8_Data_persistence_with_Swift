//
//  FirstAidKitViewModel.swift
//  Mobile_Activity8_Data_persistence_with_SwiftData_and_SwiftTest
//
//  Created by Desiderio Ortegon morton on 08/11/26.
//

import Foundation
import Observation
import SwiftData

@MainActor
@Observable
final class FirstAidKitViewModel {
    private(set) var supplies: [Supply] = []

    @ObservationIgnored private var context: ModelContext?
    private let tipGenerator = UsageTipGenerator()

    func setContext(_ context: ModelContext) throws {
        self.context = context
        try load()
    }

    // MARK: - Leer

    func load() throws {
        let context = try requireContext()
        let descriptor = FetchDescriptor<Supply>(
            sortBy: [SortDescriptor(\.expirationDate), SortDescriptor(\.name)]
        )

        do {
            supplies = try context.fetch(descriptor)
        } catch {
            throw SupplyError.loadFailed
        }
    }

    func supplies(with status: ExpirationStatus) -> [Supply] {
        supplies.filter { $0.expirationStatus == status }
    }

    // MARK: - Agregar, editar y borrar

    func add(_ draft: SupplyDraft) throws {
        try validate(draft)
        let context = try requireContext()

        let supply = Supply(
            name: draft.name.trimmed,
            category: draft.category,
            quantity: draft.quantity,
            expirationDate: draft.expirationDate,
            usageNotes: draft.usageNotes.trimmed
        )
        context.insert(supply)
        try save(context)
    }

    func update(_ supply: Supply, with draft: SupplyDraft) throws {
        try validate(draft)
        let context = try requireContext()

        supply.name = draft.name.trimmed
        supply.category = draft.category
        supply.quantity = draft.quantity
        supply.expirationDate = draft.expirationDate
        supply.usageNotes = draft.usageNotes.trimmed
        try save(context)
    }

    func delete(_ suppliesToDelete: [Supply]) throws {
        let context = try requireContext()

        for supply in suppliesToDelete {
            context.delete(supply)
        }
        try save(context)
    }

    // MARK: - Foundation Models

    var tipUnavailableMessage: String? {
        tipGenerator.unavailabilityReason?.errorDescription
    }

    func usageTip(for draft: SupplyDraft) async throws -> String {
        guard Supply.isValidName(draft.name) else {
            throw SupplyError.invalidName
        }
        return try await tipGenerator.makeTip(for: draft.name.trimmed, category: draft.category)
    }

    // MARK: - Helpers

    private func validate(_ draft: SupplyDraft) throws {
        guard Supply.isValidName(draft.name) else {
            throw SupplyError.invalidName
        }
        guard Supply.isValidQuantity(draft.quantity) else {
            throw SupplyError.invalidQuantity
        }
    }

    private func requireContext() throws -> ModelContext {
        guard let context else {
            throw SupplyError.storageUnavailable
        }
        return context
    }

    // si falla el save se hace rollback para no dejar cambios a medias
    private func save(_ context: ModelContext) throws {
        do {
            try context.save()
        } catch {
            context.rollback()
            throw SupplyError.saveFailed
        }
        try load()
    }
}
