//
//  ContentView.swift
//  SwiftUI-ViewModifiers
//
//  Created by Ben Scheirman on 4/22/20.
//  Copyright © 2020 NSScreencast. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        VStack {
            ShoppingList(storeName: "Grocery Store",
                         items: [
                            "Apples",
                            "Bananas",
                            "Oranges"
            ])

            ShoppingList(storeName: "Hardware Store",
                         items: [
                            "Lumber",
                            "Screws",
                            "Cement"
            ])

            Spacer()
        }

    }
}

struct ShoppingList: View {
    let storeName: String
    let items: [String]

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(storeName)
                .headlineStyle()
                .badge(items.count)
            Divider()
            ForEach(Array(items.enumerated()), id: \.offset) { item in
                Text(item.element)
            }
        }
        .padding()
    }
}

extension View {
    func badge(_ count: Int) -> some View {
        modifier(BadgeModifier(count: count))
    }
}

struct BadgeModifier: ViewModifier {

    @State var count: Int
    @State var isVisible: Bool = true

    func body(content: Content) -> some View {
        content.overlay(
            GeometryReader { geometry in
                Text("\(self.count)")
                    .font(Font.system(size: 14).monospacedDigit())
                    .foregroundColor(.white)
                    .padding(6)
                    .background(
                        Circle().fill(Color.red)
                        .onTapGesture {
                            self.count -= 1
                            if self.count == 0 {
                                self.isVisible = false
                            }
                        }
                    )
                    .offset(x: geometry.size.width/2 + 8, y: -geometry.size.height/2)
            }
            .opacity(isVisible ? 1 : 0)
            .animation(.default)
        )
    }
}

extension Text {
    func headlineStyle() -> Text {
        font(.headline)
        .foregroundColor(.green)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
