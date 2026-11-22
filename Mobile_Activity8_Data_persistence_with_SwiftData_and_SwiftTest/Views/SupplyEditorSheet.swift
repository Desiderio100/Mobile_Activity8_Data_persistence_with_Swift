//
//  SupplyEditorSheet.swift
//  Mobile_Activity8_Data_persistence_with_SwiftData_and_SwiftTest
//
//  Created by Desiderio Ortegon morton on 08/11/26.
//

import SwiftUI

// mismo form para agregar y editar
struct SupplyEditorSheet: View {
    @Environment(\.dismiss) private var dismiss

    let viewModel: FirstAidKitViewModel
    private let supply: Supply?

    @State private var draft: SupplyDraft
    @State private var isGeneratingTip = false
    @State private var errorAlert = ErrorAlert()

    init(viewModel: FirstAidKitViewModel, supply: Supply? = nil) {
        self.viewModel = viewModel
        self.supply = supply
        _draft = State(initialValue: supply.map { SupplyDraft(supply: $0) } ?? SupplyDraft())
    }

    private var isEditing: Bool {
        supply != nil
    }

    private var canGenerateTip: Bool {
        viewModel.tipUnavailableMessage == nil && Supply.isValidName(draft.name) && !isGeneratingTip
    }

    var body: some View {
        NavigationStack {
            Form {
                detailsSection
                notesSection
            }
            .navigationTitle(isEditing ? "Editar insumo" : "Nuevo insumo")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Guardar", action: save)
                        .disabled(!draft.isValid || isGeneratingTip)
                }
            }
            .errorAlert($errorAlert)
        }
    }

    private var detailsSection: some View {
        Section("Datos del insumo") {
            TextField("Nombre (ej. gasas estériles)", text: $draft.name)
            Picker("Categoría", selection: $draft.category) {
                ForEach(SupplyCategory.allCases) { category in
                    Label(category.title, systemImage: category.symbolName)
                        .tag(category)
                }
            }
            Stepper("Cantidad: \(draft.quantity)", value: $draft.quantity, in: 1...999)
            DatePicker("Caducidad", selection: $draft.expirationDate, displayedComponents: .date)
        }
    }

    private var notesSection: some View {
        Section {
            TextField("Para qué sirve y cómo conservarlo", text: $draft.usageNotes, axis: .vertical)
                .lineLimit(3...6)

            Button(action: generateTip) {
                if isGeneratingTip {
                    HStack(spacing: 8) {
                        ProgressView()
                        Text("Generando sugerencia…")
                    }
                } else {
                    Label("Sugerir nota de uso", systemImage: "sparkles")
                }
            }
            .disabled(!canGenerateTip)
        } header: {
            Text("Notas de uso")
        } footer: {
            Text(viewModel.tipUnavailableMessage ?? "La sugerencia se genera en tu dispositivo. Revísala antes de guardar.")
        }
    }

    private func save() {
        do {
            if let supply {
                try viewModel.update(supply, with: draft)
            } else {
                try viewModel.add(draft)
            }
            dismiss()
        } catch {
            errorAlert.present(error, title: "No se pudo guardar")
        }
    }

    private func generateTip() {
        isGeneratingTip = true
        Task {
            defer { isGeneratingTip = false }
            do {
                draft.usageNotes = try await viewModel.usageTip(for: draft)
            } catch {
                errorAlert.present(error, title: "Sugerencia no disponible")
            }
        }
    }
}

#Preview {
    SupplyEditorSheet(viewModel: FirstAidKitViewModel())
}
