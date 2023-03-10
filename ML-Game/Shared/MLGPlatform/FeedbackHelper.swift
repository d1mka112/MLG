//
//  FeedbackHelper.swift
//  ML-Game (iOS)
//
//  Created by Dmitry Leukhin on 24.10.2022.
//

import UIKit

enum Feedback {
    static func pull(style: UIImpactFeedbackGenerator.FeedbackStyle = .light) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }

    static func doublePull(dispatchTime: DispatchTime = .now() + 0.1, style: UIImpactFeedbackGenerator.FeedbackStyle = .light) {
        pull(style: style)
        DispatchQueue.global().asyncAfter(deadline: dispatchTime) {
            pull(style: style)
        }
    }
}
