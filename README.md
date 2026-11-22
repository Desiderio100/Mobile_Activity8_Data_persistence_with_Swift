# Mi botiquín

Actividad 8 de TC2007B (Gpo. 501) - Persistencia de datos con SwiftData y Swift Testing

Desiderio Iván Ortegón Mortón - A00840591

Es una sección de la app de Cruz Roja. Sirve para llevar el control de lo que tienes en tu botiquín: registras los insumos con su cantidad y fecha de caducidad, y la app te los separa en caducados, los que caducan pronto (30 días o menos) y vigentes.

## Qué tiene

- CRUD con SwiftData: agregar, ver, editar y borrar insumos. Los datos se quedan guardados aunque cierres la app.
- Foundation Models: en el formulario hay un botón de "Sugerir nota de uso" que usa el modelo del iPhone para escribir para qué sirve el insumo y cómo guardarlo. La nota se puede editar antes de guardar.
- Manejo de errores: si falta el nombre, la cantidad es 0 o falla al cargar o guardar, sale una alerta con el mensaje. Si Apple Intelligence no está activado, el botón de sugerencia se desactiva y te dice por qué.
- MVVM: las vistas no tocan SwiftData directo, todo pasa por `FirstAidKitViewModel`.
- Diseño con la HIG de Apple: NavigationStack, sheet con Cancelar y Guardar, swipe para borrar, pantalla de lista vacía, SF Symbols y modo oscuro.

## Estructura

- `Models`: `Supply` (el @Model), categorías, estado de caducidad, errores y el draft del formulario
- `ViewModels`: `FirstAidKitViewModel`
- `Services`: `UsageTipGenerator` (Foundation Models)
- `Views`: lista, formulario, fila y alerta de errores

## Pruebas

Se corren con Cmd + U. Son 2 archivos de pruebas con Swift Testing:

- `SupplyTests`: valida el nombre, la cantidad y el estado de caducidad.
- `FirstAidKitViewModelTests`: prueba agregar, rechazar un nombre vacío, editar y borrar. Usan una base de datos en memoria para no tocar los datos reales.

## Cómo correrlo

Abrir `Mobile_Activity8_Data_persistence_with_SwiftData_and_SwiftTest.xcodeproj` en Xcode 27, escoger un simulador de iPhone y darle Cmd + R. Para las sugerencias se necesita Apple Intelligence activado; sin eso lo demás funciona igual.
