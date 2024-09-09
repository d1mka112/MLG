//
//  MLGTextField.swift
//  ML-Game (iOS)
//
//  Created by Dmitry Leukhin on 25.10.2022.
//

import SwiftUI

struct MLGTextField: View {
    var placeholder: String
    @Binding var text: String

    var body: some View {
        TextField(placeholder, text: $text)
            .padding(Design.Spacing.standart)
            .frame(maxWidth: .infinity)
            .multilineTextAlignment(.center)
            .foregroundColor(Design.Colors.primary)
            .background(
                Capsule()
                    .foregroundColor(Design.Colors.background)
            )
    }
}

struct MLGTextField_Previews: PreviewProvider {
    @State static var isChecked: Bool = false
    static var previews: some View {
        Group {
            MLGTextField(
                placeholder: "Плейсхолдер",
                text: .constant("Текст")
            )
        }
        .previewLayout(.sizeThatFits)
    }
}
