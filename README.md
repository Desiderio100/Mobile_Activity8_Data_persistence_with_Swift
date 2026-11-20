# Mi botiquín

Mobile_Activity8: Data persistence with SwiftData and SwiftTest
Desiderio Iván Ortegón Mortón (A00840591), TC2007B Group 501

Mi botiquín is a section of the Cruz Roja Mexicana challenge app. A volunteer can register the supplies in their first aid kit, see which ones are expired or about to expire, and get a short usage note for each supply generated on the device with Foundation Models.

## Features

- **CRUD with SwiftData:** add, list, edit and delete supplies (name, category, quantity, expiration date and notes). The data stays after closing the app.
- **Expiration sections:** Caducados, Caducan pronto (30 days or less) and Vigentes, sorted by date.
- **Foundation Models:** the "Sugerir nota de uso" button asks the on-device model for a short note about what the supply is for and how to store it. The user can edit the note before saving.
- **Error handling:** validation, storage and model errors are typed errors and the user sees an alert in Spanish. If Apple Intelligence is not available, the button is disabled and the form explains why.
- **Design (Apple HIG):** NavigationStack, a Form sheet with Cancelar and Guardar, swipe to delete, ContentUnavailableView for the empty list, SF Symbols, Dark Mode, Dynamic Type and VoiceOver labels.

## Architecture (MVVM)

| Layer | Files |
| --- | --- |
| Model | `Supply` (@Model), `SupplyCategory`, `ExpirationStatus`, `SupplyDraft`, `SupplyError` |
| ViewModel | `FirstAidKitViewModel`: fetch, insert, update, delete and save with the `ModelContext` |
| Service | `UsageTipGenerator`, `UsageTipError` (Foundation Models) |
| View | `ContentView`, `SupplyEditorSheet`, `SupplyRow`, `SupplyStyle`, `ErrorAlert` |

The views never write to SwiftData directly. The view model receives the `ModelContext` through `setContext`, so the tests can give it an in-memory container.

## Error messages

| Case | Message |
| --- | --- |
| Empty name | Escribe el nombre del insumo. |
| Quantity of 0 or less | La cantidad debe ser mayor que cero. |
| Fetch fails | No se pudieron cargar los insumos. Intenta de nuevo. |
| Save fails (changes are rolled back) | No se pudieron guardar los cambios. Intenta de nuevo. |
| Apple Intelligence off or not supported | Shown under the notes field, the button is disabled. |
| The model cannot answer | Alert asking to try again or write the note manually. |

## User story and acceptance criteria

US-1: As a Cruz Roja volunteer, I want to register the supplies in my first aid kit so that I know what I have and when each one expires.

| Acceptance criterion | Test |
| --- | --- |
| A supply cannot be saved without a name. | `nameValidation`, `emptyNameIsRejected` |
| The quantity must be greater than zero. | `quantityValidation` |
| A saved supply appears in the list. | `addSavesSupply` |
| A supply can be edited and deleted. | `updateChangesSupply`, `deleteRemovesSupply` |
| Supplies that expire in 30 days or less are flagged. | `expirationStatus` |

## Unit tests (Swift Testing)

Run them with Product > Test (Cmd + U).

- `SupplyTests`: name validation, quantity validation and expiration status.
- `FirstAidKitViewModelTests`: add, reject an empty name, update and delete. Each test uses a new in-memory `ModelContainer`, so the app's real data is never touched.

## Requirements

- Xcode 27 and iOS 27 (iPhone and iPad).
- Open `Mobile_Activity8_Data_persistence_with_SwiftData_and_SwiftTest.xcodeproj`, choose an iPhone simulator and press Cmd + R.
- Usage notes need Apple Intelligence turned on. Without it, the rest of the app works normally.
