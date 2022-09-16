import SwiftUI

private extension View {
    /// Дополнительный идентификатор для навигации с именем, отличным от id
    /// Из-за static method dispatch в расширениях к протоколам свойство с именем id имеет приоритет над одноименным свойством во вью
    var navigationID: String {
        String(describing: Self.self)
    }
}

/// Модификатор навигации
struct NavigationModifier<Destination: View>: ViewModifier {
    let destination: () -> Destination
    let isPresented: Binding<Bool>

    init(id: String, title: String, destination: @escaping () -> Destination, isPresented: Binding<Bool>) {
        self.destination = destination
        self.isPresented = isPresented

        guard isPresented.wrappedValue == true else { return }

        NavigationStorage.shared.addItem(isPresented: isPresented, id: id, title: title)
    }

    func body(content: Content) -> some View {
        content
            .navigationDestination(isPresented: isPresented, destination: destination)
    }
}

extension View {
    func navigationLink<Destination: View>(
        id: String,
        title: String,
        isPresented: Binding<Bool>,
        destination: @escaping () -> Destination
    ) -> some View {
        modifier(NavigationModifier(id: id, title: title, destination: destination, isPresented: isPresented))
    }
}
