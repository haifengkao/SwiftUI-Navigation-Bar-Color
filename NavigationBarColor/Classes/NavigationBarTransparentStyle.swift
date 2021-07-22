//
//  NavigationBarTransparentStyle.swift
//  Pods
//
//  Created by Hai Feng Kao on 2021/7/22.
//

import SwiftUI

struct NavigationBarTransparentStyle: ViewModifier {
    static var transparentAppearanceDict: [Color: UINavigationBarAppearance] = [:]
    static let defaultTransparentAppearance: UINavigationBarAppearance = {
        makeAppearance()
    }()

    static func makeAppearance(color: Color? = nil) -> UINavigationBarAppearance {
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.backgroundColor = .clear

        // keep the shadow image
        color.map {
            coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor($0)]
            coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor($0)]
        }

        return coloredAppearance
    }

    init(tintColor: Color? = nil) {
        let apply: (UINavigationBarAppearance) -> Void = {
            guard UINavigationBar.appearance() != $0 else {
                return
            }
            UINavigationBar.appearance().standardAppearance = $0
            UINavigationBar.appearance().scrollEdgeAppearance = $0
            UINavigationBar.appearance().compactAppearance = $0
        }

        if let color = tintColor {
            if let appearance = Self.transparentAppearanceDict[color] {
                apply(appearance)
            } else {
                let appearance = Self.makeAppearance(color: color)
                Self.transparentAppearanceDict[color] = appearance
                apply(appearance)
            }
        } else {
            apply(Self.defaultTransparentAppearance)
        }

        tintColor.map {
            if UINavigationBar.appearance().tintColor != UIColor($0) {
                UINavigationBar.appearance().tintColor = UIColor($0)
            }
        }
    }

    func body(content: Content) -> some View { content }
}

public extension View {
    func navigationTransparentBar(tintColor: Color? = nil) -> some View {
        modifier(NavigationBarTransparentStyle(tintColor: tintColor))
    }
}
