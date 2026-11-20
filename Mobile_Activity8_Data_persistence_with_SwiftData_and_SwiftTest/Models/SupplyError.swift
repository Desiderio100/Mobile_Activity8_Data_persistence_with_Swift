//
//  SupplyError.swift
//  Mobile_Activity8_Data_persistence_with_SwiftData_and_SwiftTest
//
//  Created by Desiderio Ortegon morton on 08/11/26.
//

import Foundation

nonisolated enum SupplyError: LocalizedError {
    case invalidName
    case invalidQuantity
    case storageUnavailable
    case loadFailed
    case saveFailed

    var errorDescription: String? {
        switch self {
        case .invalidName:
            "Escribe el nombre del insumo."
        case .invalidQuantity:
            "La cantidad debe ser mayor que cero."
        case .storageUnavailable:
            "El almacenamiento no está disponible. Cierra la app y vuelve a abrirla."
        case .loadFailed:
            "No se pudieron cargar los insumos. Intenta de nuevo."
        case .saveFailed:
            "No se pudieron guardar los cambios. Intenta de nuevo."
        }
    }
}
