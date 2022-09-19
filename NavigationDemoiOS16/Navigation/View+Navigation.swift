import SwiftUI

private extension View {
    /// Дополнительный идентификатор для навигации с именем, отличным от id
    /// Из-за static method dispatch в расширениях к протоколам свойство с именем id имеет приоритет над одноименным свойством во вью
    var navigationID: String {
        String(describing: Self.self)
    }
}

/// Модификатор навигации
struct NavigationModifier: ViewModifier {
    let item: NavigationPathItem?

    init(id: String, title: String, destination: @escaping () -> AnyView) {
        let item = NavigationPathItem(id: id, title: title, destination: destination)
        self.item = item
        NavigationStorage.shared.addItem(item)
    }

    func body(content: Content) -> some View {
        content
            .background(
                NavigationLink(value: item) {
                    EmptyView()
                }
                .hidden()
            )
    }
}

extension View {
    func navigationLink(
        id: String,
        title: String,
        destination: @escaping () -> AnyView
    ) -> some View {
        modifier(NavigationModifier(id: id, title: title, destination: destination))
    }
}
