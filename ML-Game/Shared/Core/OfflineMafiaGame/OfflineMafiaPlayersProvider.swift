//
//  OfflineMafiaPlayersProvider.swift.swift
//  ML-Game (iOS)
//
//  Created by Dmitry Leukhin on 12.10.2022.
//

import Foundation

enum OfflineMafiaPlayersProvider {
    static func makeDefaultValueForEmptyNames(of players: [OfflineMafiaPlayer]) {
        players.forEach { player in
            player.name = player.name.isEmpty ? makeDefaultName(by: player.id) : player.name
        }
    }

    static func makePlayers(by settings: OfflineMafiaGameSettings) -> [OfflineMafiaPlayer] {
        var players: [OfflineMafiaPlayer] = []

        for index in 0..<settings.playersCount {
            players.append(makePlayer(by: index))
        }
        RoleAllocator.assign(for: players, by: settings)

        return players
    }

    private static func makePlayer(by index: Int) -> OfflineMafiaPlayer {
        OfflineMafiaPlayer(
            id: index,
            role: .none,
            placeholderName: makeDefaultName(by: index)
        )
    }

    private static func makeDefaultName(by index: Int) -> String {
        "Игрок \(index)"
    }
}
