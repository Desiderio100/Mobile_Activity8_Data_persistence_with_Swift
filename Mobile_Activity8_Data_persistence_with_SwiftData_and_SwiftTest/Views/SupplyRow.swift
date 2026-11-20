//
//  SupplyRow.swift
//  Mobile_Activity8_Data_persistence_with_SwiftData_and_SwiftTest
//
//  Created by Desiderio Ortegon morton on 08/11/26.
//

import SwiftUI

struct SupplyRow: View {
    let supply: Supply

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: supply.category.symbolName)
                .font(.body.weight(.semibold))
                .foregroundStyle(.white)
                .frame(width: 36, height: 36)
                .background(supply.category.tint.gradient, in: .rect(cornerRadius: 8))
                .accessibilityHidden(true)

            VStack(alignment: .leading, spacing: 2) {
                Text(supply.name)
                    .font(.headline)
                Text(supply.category.title)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 2) {
                Text(quantityText)
                    .font(.subheadline)
                    .monospacedDigit()
                Text(supply.expirationDate, format: .dateTime.day().month(.abbreviated).year())
                    .font(.caption)
                    .foregroundStyle(supply.expirationStatus.tint)
            }
        }
        .padding(.vertical, 2)
        .accessibilityElement(children: .combine)
    }

    private var quantityText: String {
        supply.quantity == 1 ? "1 pieza" : "\(supply.quantity) piezas"
    }
}
