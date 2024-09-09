//
//  OfflinePlayerNameInputScreen.swift
//  ML-Game
//
//  Created by Damir Yumaguzhin on 10/13/22.
//

import SwiftUI

struct OfflineMafiaPlayerNameInputScreen: View {
    @ObservedObject var viewModel: ViewModel = ViewModel()

    var body: some View {
        VStack {
            MLGSection(title: Localization.sectionTitle) {
                MLGScrollViewIfNeeded {
                    VStack {
                        ForEach($viewModel.game.players, id: \.id) { player in
                            MLGTextField(
                                placeholder: player.placeHolderName.wrappedValue,
                                text: player.name
                            )
                        }
                    }
                }
            }

            MLGNavigationLink {
//                OfflineMafiaCardScreen()
                OfflineMafiaCardScreenTwo()
            } label: {
                Text(Localization.buttonTitle)
            }.simultaneousGesture(
                TapGesture().onEnded {
                    viewModel.game.createGame()
                }
            )
        }
        .padding(Design.Spacing.standart)
        .navigationBarTitleDisplayMode(.automatic)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(Localization.title)
                    .font(Design.Fonts.h3)
                    .bold()
            }
        }
        .onTapGesture {
            hideKeyboard()
        }
    }
}

//MARK: - PreviewProvider
struct OfflineMafiaPlayerNameInputScreen_Preview: PreviewProvider {
    static var previews: some View {
        OfflineMafiaPlayerNameInputScreen()
    }
}

// MARK: - ViewModel
extension OfflineMafiaPlayerNameInputScreen {
    class ViewModel: ObservableObject {
        @Published var game: OfflineMafiaGame = OfflineMafiaGame.shared

        init() {
            game.createPlayers()
        }
    }
}

// MARK: - Localization
extension OfflineMafiaPlayerNameInputScreen {
    enum Localization {
        static let title: String = "OfflinePlayerNameInputScreen.title".localized
        static let sectionTitle: String = "OfflinePlayerNameInputScreen.setPlayersName".localized
        static let buttonTitle: String = "OfflinePlayerNameInputScreen.startGame".localized
        static let playerName: String = "OfflinePlayerNameInputScreen.playerName".localized
    }
}

