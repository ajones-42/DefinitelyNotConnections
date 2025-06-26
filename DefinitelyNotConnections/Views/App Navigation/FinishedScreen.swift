//
//  FinishedScreen.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 26.06.25.
//

import SwiftUI

struct FinishedScreen: View {
    var body: some View {
        ZStack {
            Color.purple
                .ignoresSafeArea()
            VStack {
                Text("YOU DID IT!")
                    .foregroundStyle(.black)
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                Text("Happy anniversary! I love you!")
                    .foregroundStyle(.black)
                    .font(.title3)
                AppNavigationButton(text: "Play again")
                
            }
        }
    }
}

#Preview {
    FinishedScreen()
}
