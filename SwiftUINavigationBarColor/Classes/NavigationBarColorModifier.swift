import SwiftUI

struct NavigationBarColorModifier<Background>: ViewModifier where Background: View {
    let background: () -> Background
    public init(@ViewBuilder background: @escaping () -> Background) {
        self.background = background
    }

    func body(content: Content) -> some View {
        // Color(UIColor.secondarySystemBackground)

        ZStack {
            content
            VStack {
                background()
                    .edgesIgnoringSafeArea([.top, .leading, .trailing])
                    .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 0, alignment: .center)

                Spacer() // to move the navigation bar to top
            }
        }
    }
}

public extension View {
    func navigationBarBackground<Background: View>(@ViewBuilder _ background: @escaping () -> Background) -> some View {
        modifier(NavigationBarColorModifier(background: background))
    }
}
