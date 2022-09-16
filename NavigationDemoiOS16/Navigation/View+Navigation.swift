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
    let destination: Destination?
    let isPresented: Binding<Bool>

    init(id: String? = nil, title: String, destination: Destination?, isPresented: Binding<Bool>) {
        self.destination = destination
        self.isPresented = isPresented

        guard let destination = destination, isPresented.wrappedValue == true else { return }
        let identifier = id ?? destination.navigationID

        NavigationStorage.shared.addItem(isPresented: isPresented, id: identifier, title: title)
    }

    func body(content: Content) -> some View {
        content
            .background(
                NavigationLink(
                    destination: destination,
                    isPresented: isPresented
                ) {
                    EmptyView()
                }
                .hidden()
            )
    }
}

extension View {
    func navigationLink<Destination: View>(
        id: String? = nil,
        title: String,
        destination: Destination?,
        isPresented: Binding<Bool>
    ) -> some View {
        modifier(NavigationModifier(id: id, title: title, destination: destination, isPresented: isPresented))
    }
}
