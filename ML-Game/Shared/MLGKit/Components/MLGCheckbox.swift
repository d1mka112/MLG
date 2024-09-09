//
//  MLGCheckbox.swift
//  ML-Game (iOS)
//
//  Created by Dmitry Leukhin on 24.10.2022.
//

import SwiftUI

struct MLGCheckbox : View {
    @Binding var isChecked: Bool

    var title: String
    var titleColor: Color = Design.Colors.primary
    var image: Image?
    var imageColor: Color = Design.Colors.primary
    var borderColor: Color = Design.Colors.primary
    var background: Color = Design.Colors.background
    var inactiveColor: Color = Design.Colors.special
    var isEnabled: Bool = true
    var onToggle: (()->())?

    var body: some View {
        ZStack {
            if let image = image {
                HStack {
                    image
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .padding(Design.Spacing.small)
                        .frame(
                            width: Design.Size.big,
                            height: Design.Size.big
                        )
                        .foregroundColor((isChecked || isEnabled) ? imageColor : inactiveColor)
                    Spacer()
                }
            }

            Text(title)
                .font(Design.Fonts.h3)
                .frame(
                    maxWidth: .infinity
                )
                .foregroundColor((isChecked || isEnabled) ? titleColor : inactiveColor)
                .padding(Design.Spacing.standart)
        }
        .frame(
            height: Design.Size.big
        )
        .background(
            Capsule()
                .strokeBorder(lineWidth: Design.Width.standart, antialiased: false)
                .foregroundColor(isChecked ? borderColor : background)
                .background(
                    Capsule()
                        .foregroundColor(background)
                )
        )
        .onTapGesture {
            if isEnabled || isChecked {
                Feedback.pull()
                withAnimation {
                    isChecked.toggle()
                }
                onToggle?()
            }
        }
    }
}

struct MLGCheckbox_Previews: PreviewProvider {
    @State static var isChecked: Bool = false
    static var previews: some View {
        Group {
            MLGCheckbox(isChecked: $isChecked, title: "Дон мафии")
        }
        .previewLayout(.sizeThatFits)
    }
}

