//
//  RoleAllocator.swift
//  ML-Game (iOS)
//
//  Created by Dmitry Leukhin on 18.10.2022.
//

import Foundation

/// Распределитель ролей для игроков
enum RoleAllocator {
    /// Число игроков:
    /// 3 и больше.
    /// При малом количестве игроков игра быстро заканчивается,
    /// При большом из-за общего шума и разбиения на кучки обсуждающих теряет смысл.

    /// Правило вычисления количества мафий
    /// Минимальное Mmin = N/4 - где N - общее количество игроков
    /// Максимальное Mmax = N/3 - где N - общее количество игроков
    /// Другие варианты приводят к дисбалансу игры.
    /// Рекомендуется для онлайн игр использовать >= 4 (Мафий меньше)
    /// Для оффлайн между N/4 - N/3

    /// Метод, распределяющий роли среди игроков `players`
    /// - Parameters:
    ///   - players: Массив игроков, у которых будут распределены роли в соответствии с настройками
    ///   - settings: Настройки, на основании которых будут распределятся роли
    static func assign(for players: [OfflineMafiaPlayer], by settings: OfflineMafiaGameSettings) {
        guard settings.playersCount > 1 && settings.playersCount > settings.mafiasCount else { return }

        let shouldBeDon: Bool = settings.shouldBeRole.first { $0.role == .don }?.isActive ?? false
        let mafiasCount = shouldBeDon ? settings.mafiasCount - 1 : settings.mafiasCount

        var freeRolesIndexes: [Int] = Array(0..<settings.playersCount)

        // Assign commissioner role
        allocate(role: .commissioner, for: &freeRolesIndexes, with: players)

        // Assign mafia roles
        for _ in 0..<mafiasCount {
            allocate(role: .mafia, for: &freeRolesIndexes, with: players)
        }

        // Assign additional roles
        settings.shouldBeRole.forEach {
            if $0.isActive {
                allocate(role: $0.role, for: &freeRolesIndexes, with: players)
            }
        }

        // Assign left civilian roles
        freeRolesIndexes.forEach { index in
            players[index].role = MafiaPlayerRole.civilian
        }
    }

    /// Метод, выделяющий роль игроку из массивов допустимых индексов
    private static func allocate(role: MafiaPlayerRole, for freeRolesIndexes: inout [Int], with players: [OfflineMafiaPlayer]) {
        let index = Int.random(in: 0..<freeRolesIndexes.count)
        players[freeRolesIndexes.remove(at: index)].role = role
    }

    static func validate(gameSettings: OfflineMafiaGameSettings) -> String {
        guard gameSettings.playersCount > gameSettings.mafiasCount else {
            return Localization.playersCountLessThenMafiasCount
        }
        return String.empty
    }

    static var playersRange: Range<Int> {
        3..<20
    }

    static func playersRange(for gameSettings: OfflineMafiaGameSettings) -> Range<Int> {
        let activeRoles = gameSettings.shouldBeRole.filter{$0.isActive == true}.count
        let minRange = max(3, 3 + activeRoles - 1)
        return minRange..<20
    }

    static func mafiasRange(for gameSettings: OfflineMafiaGameSettings) -> Range<Int> {
        let minMafias = max(1, gameSettings.playersCount / 4)
        let maxMafias = max(1, gameSettings.playersCount / 3)
        let length = maxMafias - minMafias

        let range = NSRange(location: minMafias, length: length)
        return Range(range) ?? 1..<gameSettings.playersCount
    }
}

extension RoleAllocator {
    enum Localization {
        // TODO: Добавить новые случаи
        static let playersCountLessThenMafiasCount: String = "RoleAllocator.validation.playersCountLessThenMafiasCount".localized
    }
}
