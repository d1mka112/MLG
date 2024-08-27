//
//  OfflineMafiaGameSetting4s.swift
//  ML-Game (iOS)
//
//  Created by Dmitry Leukhin on 12.10.2022.
//

import Foundation

class OfflineMafiaGameSettings: Codable {
    struct ShouldBeRole: Codable {
        var role: MafiaPlayerRole
        var isActive: Bool
    }

    var mafiasCount: Int = 1
    var playersCount: Int = 1 {
        willSet {
            if newValue < 3 {
                shouldBeRole = shouldBeRole.map{
                    .init(role: $0.role, isActive: false)
                }
            }
        }
    }

    var selectedRolesCount: Int {
        shouldBeRole.reduce(into: 0) { partialResult, role in
            partialResult = role.isActive ? partialResult + 1 : partialResult
        }
    }

    var shouldBeRole: [ShouldBeRole] = [
        ShouldBeRole(role: .don, isActive: false),
        ShouldBeRole(role: .maniac, isActive: false),
        ShouldBeRole(role: .doctor, isActive: false),
        ShouldBeRole(role: .journalist, isActive: false),
        ShouldBeRole(role: .whore, isActive: false),
        ShouldBeRole(role: .yakuza, isActive: false)
    ]
}

