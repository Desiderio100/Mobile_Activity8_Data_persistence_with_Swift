//
//  ContentView.swift
//  Mobile_Activity8_Data_persistence_with_SwiftData_and_SwiftTest
//
//  Created by Desiderio Ortegon morton on 20/10/26.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var context
    @State private var viewModel = FirstAidKitViewModel()
    @State private var isShowingNewSupply = false
    @State private var supplyToEdit: Supply?
    @State private var errorAlert = ErrorAlert()

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.supplies.isEmpty {
                    emptyState
                } else {
                    supplyList
                }
            }
            .navigationTitle("Mi botiquín")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Agregar insumo", systemImage: "plus") {
                        isShowingNewSupply = true
                    }
                }
            }
            .sheet(isPresented: $isShowingNewSupply) {
                SupplyEditorSheet(viewModel: viewModel)
            }
            .sheet(item: $supplyToEdit) { supply in
                SupplyEditorSheet(viewModel: viewModel, supply: supply)
            }
            .errorAlert($errorAlert)
            .onAppear(perform: loadSupplies)
        }
    }

    private var supplyList: some View {
        List {
            ForEach(ExpirationStatus.allCases) { status in
                let supplies = viewModel.supplies(with: status)
                if !supplies.isEmpty {
                    Section(status.sectionTitle) {
                        ForEach(supplies) { supply in
                            Button {
                                supplyToEdit = supply
                            } label: {
                                SupplyRow(supply: supply)
                            }
                            .tint(.primary)
                        }
                        .onDelete { offsets in
                            delete(offsets.map { supplies[$0] })
                        }
                    }
                }
            }
        }
    }

    private var emptyState: some View {
        ContentUnavailableView {
            Label("Tu botiquín está vacío", systemImage: "cross.case")
        } description: {
            Text("Registra tus insumos para saber qué tienes y cuándo caducan.")
        } actions: {
            Button("Agregar insumo") {
                isShowingNewSupply = true
            }
            .buttonStyle(.borderedProminent)
        }
    }

    private func loadSupplies() {
        do {
            try viewModel.setContext(context)
        } catch {
            errorAlert.present(error, title: "No se pudo cargar el botiquín")
        }
    }

    private func delete(_ supplies: [Supply]) {
        do {
            try viewModel.delete(supplies)
        } catch {
            errorAlert.present(error, title: "No se pudo eliminar")
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Supply.self, inMemory: true)
}
