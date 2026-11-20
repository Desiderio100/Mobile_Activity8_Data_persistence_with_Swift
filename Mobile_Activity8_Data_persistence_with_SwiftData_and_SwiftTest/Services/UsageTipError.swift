//
//  UsageTipError.swift
//  Mobile_Activity8_Data_persistence_with_SwiftData_and_SwiftTest
//
//  Created by Desiderio Ortegon morton on 08/11/26.
//

import Foundation
import FoundationModels

nonisolated enum UsageTipError: LocalizedError {
    case deviceNotEligible
    case appleIntelligenceDisabled
    case modelNotReady
    case unsupportedLanguage
    case unsafeContent
    case generationFailed

    init(_ reason: SystemLanguageModel.Availability.UnavailableReason) {
        switch reason {
        case .deviceNotEligible:
            self = .deviceNotEligible
        case .appleIntelligenceNotEnabled:
            self = .appleIntelligenceDisabled
        default:
            self = .modelNotReady
        }
    }

    init(_ error: LanguageModelError) {
        switch error {
        case .guardrailViolation, .refusal:
            self = .unsafeContent
        case .unsupportedLanguageOrLocale:
            self = .unsupportedLanguage
        default:
            self = .generationFailed
        }
    }

    var errorDescription: String? {
        switch self {
        case .deviceNotEligible:
            "Este dispositivo no es compatible con Apple Intelligence, así que las sugerencias no están disponibles."
        case .appleIntelligenceDisabled:
            "Activa Apple Intelligence en Configuración para recibir sugerencias."
        case .modelNotReady:
            "El modelo todavía se está preparando. Intenta de nuevo en unos minutos."
        case .unsupportedLanguage:
            "El idioma del dispositivo no es compatible con las sugerencias."
        case .unsafeContent:
            "No se pudo generar una sugerencia para este insumo. Escribe la nota manualmente."
        case .generationFailed:
            "No se pudo generar la sugerencia. Intenta de nuevo."
        }
    }
}
