//
//  LazyView.swift
//  ML-Game
//
//  Created by Ильнур Закиров on 25.08.2024.
//

import Foundation
import SwiftUI

struct LazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }

    var body: Content {
        build()
    }
}
