//
//  MLGButton.swift
//  ML-Game
//
//  Created by Dmitry Leukhin on 12.10.2022.
//

import SwiftUI

/// Компонент, для отрисовки NavigationLink со стандартными параметрами, внутри контейнера.
/// Будет отступать на значение  `Design.Spacing.standart`
struct MLGNavigationLink<Label, Destination> : View where Label : View, Destination : View  {
    @Environment(\.colorScheme) var colorScheme

    var destination: Destination
    var label: Label

    init(@ViewBuilder destination: () -> Destination, @ViewBuilder label: () -> Label) {
        self.destination = destination()
        self.label = label()
    }

    var body: some View {
        HStack {
            NavigationLink {
                destination
            } label: {
                label
                    .padding(Design.Spacing.standart)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(
                        colorScheme == .dark ?
                            Design.Colors.primary :
                            Design.Colors.secondary
                           
                    )
                    .background(
                        colorScheme == .dark ?
                            Design.Colors.secondary :
                            Design.Colors.primary
                    )
                    .clipShape(
                        Capsule()
                    )
            }
            .buttonStyle(.plain)
            .padding(Design.Spacing.standart)
        }
    }
}
