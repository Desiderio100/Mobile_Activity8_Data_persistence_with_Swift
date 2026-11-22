//
//  UsageTipGenerator.swift
//  Mobile_Activity8_Data_persistence_with_SwiftData_and_SwiftTest
//
//  Created by Desiderio Ortegon morton on 08/11/26.
//

import Foundation
import FoundationModels

// genera la nota de uso con el modelo de Foundation Models
struct UsageTipGenerator {
    private let model = SystemLanguageModel.default

    private let instructions = """
        Eres un asistente de primeros auxilios de la Cruz Roja Mexicana. \
        Responde siempre en español, en un máximo de dos oraciones y sin listas. \
        Explica para qué sirve el insumo dentro de un botiquín y da un consejo para conservarlo. \
        No des diagnósticos ni dosis de medicamentos.
        """

    var unavailabilityReason: UsageTipError? {
        guard case .unavailable(let reason) = model.availability else { return nil }
        return UsageTipError(reason)
    }

    func makeTip(for supplyName: String, category: SupplyCategory) async throws -> String {
        if let unavailabilityReason {
            throw unavailabilityReason
        }

        let session = LanguageModelSession(instructions: instructions)
        let prompt = "Insumo: \(supplyName). Categoría: \(category.title)."

        do {
            let response = try await session.respond(to: prompt)
            return response.content.trimmed
        } catch let error as LanguageModelError {
            throw UsageTipError(error)
        } catch is SystemLanguageModel.Error {
            throw UsageTipError.modelNotReady
        } catch {
            throw UsageTipError.generationFailed
        }
    }
}
