//
//  ContentView.swift
//  PocketCipher
//
//  Created by Connor Sottosanti on 12/14/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing:0) {
            HeaderView()
            HeaderBottomBorder
            InputView()
        }
    }
    
    // MARK: - SubViews
    private var HeaderBottomBorder: some View {
        Divider()
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color.yellow.opacity(0.3), Color.yellow.opacity(0.8), Color.yellow.opacity(0.3)]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
                .frame(height: 2)
            )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
