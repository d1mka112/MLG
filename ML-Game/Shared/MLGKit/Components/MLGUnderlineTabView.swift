//
//  MLGUnderlineTabView.swift
//  ML-Game
//
//  Created by Damir Yumaguzhin on 10/18/22.
//

import SwiftUI

// TODO: Подумать над необходимостью такого компонента
struct MLGUnderlineTabView: View {
    @State var currentTab: Int = 0
    @Namespace var namespace
    
    var body: some View {
        ZStack(alignment: .top) {
            TabView(selection: self.$currentTab, content: {
                view1.tag(0)
                view2.tag(1)
                view3.tag(2)
            })
                .tabViewStyle(.page(indexDisplayMode: .never))
                .edgesIgnoringSafeArea(.all)
            navigationBarView
        }
    }
    
    var navigationitems: [String] = ["Описание игры", "Правила игры", "Описание ролей"]
    
    var navigationBarView: some View {
        ScrollView(.horizontal) {
            HStack(spacing: Design.Spacing.big) {
                ForEach(Array(zip(self.navigationitems.indices, self.navigationitems)), id: \.0, content: {
                    index, name in
                    navBarItem(string: name, tab: index)
                })
            }
            .padding(.horizontal)
        }
        .background(Color.white)
        .frame(height: Design.Size.big)
        .edgesIgnoringSafeArea(.top)
    }
    
    
    func navBarItem(string: String, tab: Int) -> some View {
        Button {
                self.currentTab = tab
        } label: {
            VStack {
                Spacer()
                Text(string)
                    .font(.system(size: 13, weight: .light, design: .default))
                    .frame(maxWidth: .infinity)
                if self.currentTab == tab {
                    Color.black.frame(height: 2)
                        .matchedGeometryEffect(id: "underline", in: namespace, properties: .frame)
                } else {
                    Color.clear.frame(height: 2)
                }
            }.animation(.spring(), value: currentTab)
        }
        .buttonStyle(.plain)
    }

    var view1: some View {
        Color.red.opacity(0.2).edgesIgnoringSafeArea(.all)
    }

    var view2: some View {
        Color.blue.opacity(0.2).edgesIgnoringSafeArea(.all)
    }
    
    var view3: some View {
        Color.yellow.opacity(0.2).edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MLGUnderlineTabView()
    }
}
