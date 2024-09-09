//
//  OfflineMafiaCardScreenTwo.swift
//  ML-Game
//
//  Created by Ильнур Закиров on 30.08.2024.
//

import SwiftUI

struct OfflineMafiaCardScreenTwo: View {
    @ObservedObject var viewModel: ViewModel = ViewModel()
    @State var selection = 0
    @State var isPush = false
    
    var body: some View {
        VStack() {
            MLGSection(title: Localization.title) {
                Spacer()
                TabView(selection: $selection) {
                    //Если id игроков гарантированно будет начинаться с 0 и увеличиваться на 1, то можно сделать итерацию по игрокам, а не по количеству
                    ForEach(0..<viewModel.game.players.count) { index in
                        HStack {
                            MLGCardView(
                                role: RoleInfoProvider.getName(
                                    by: viewModel.game.getRole(for: index)
                                )
                            )
                            .tag(index)
                        }
                    }
                }
                
                Spacer()

                HStack(spacing: 5) {
                    if selection > 0 {
                        Button {
                            if selection > 0 {
                                selection -= 1
                            }
                        } label: {
                            Text(viewModel.game.players[selection - 1].name)
                                .modifier(ButtonViewModifier())
                        }
                        .transition(.custom)
                    }
                    
                        Button {
                            if selection < viewModel.game.players.count - 1 {
                            selection += 1
                            } else {
                                isPush.toggle()
                            }
                        } label: {
                            Text(
                                selection < viewModel.game.players.count - 1 ?
                                viewModel.game.players[selection].name :
                                Localization.goToLeader
                            )
                            .lineLimit(1)
                            .modifier(ButtonViewModifier(isNextScreen:  selection < viewModel.game.players.count - 1))
                        }
                }
            }
        }
        .animation(.easeIn, value: selection)
        .tabViewStyle(.page(indexDisplayMode: .never))
        .padding(Design.Spacing.standart)
        .navigationBarTitleDisplayMode(.automatic)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(viewModel.game.players[selection].name)
                    .font(Design.Fonts.h3)
                    .bold()
            }
        }
        .onTapGesture {
            hideKeyboard()
        }
        .background(
            NavigationLink(isActive: $isPush, destination: {
                OfflineMafiaPlayersScreen()
            }, label: {
                EmptyView()
            })
        )
    }
    
    @ViewBuilder
    private func createNavigationLink() -> some View {
        MLGNavigationLink {
            OfflineMafiaPlayersScreen()
        } label: {
            Text(Localization.goToLeader)
                .lineLimit(1)
        }
    }
}

#Preview {
    OfflineMafiaCardScreenTwo()
}

extension OfflineMafiaCardScreenTwo {
    class ViewModel: ObservableObject {
        @Published var game: OfflineMafiaGame = OfflineMafiaGame.shared
    }
}

extension OfflineMafiaCardScreenTwo {
    enum Localization {
        static let title: String = "OfflineMafiaCardScreen.button.title".localized
        static let nextPlayer: String = "OfflineMafiaCardScreen.button.nextPlayer".localized
        static let goToLeader: String = "OfflineMafiaCardScreen.button.leader".localized
    }
}

private struct ButtonViewModifier: ViewModifier {
    var isNextScreen: Bool = true
    func body(content: Content) -> some View {
        content
            .padding(Design.Spacing.standart)
            .frame(maxWidth: .infinity)
            .font(Design.Fonts.h3)
            .foregroundColor(Design.Colors.secondary)
            .background(isNextScreen ? Design.Colors.primary : Color.green)
            .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

private struct ButtonTransitionModifier: ViewModifier {
    var isPresent: Bool
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(x: isPresent ? 1 : 0, y: 1, anchor: .leading)
    }
}

extension AnyTransition {
    static var custom: AnyTransition {
        .modifier(
            active: ButtonTransitionModifier(isPresent: false),
            identity: ButtonTransitionModifier(isPresent: true)
        )
    }
}
