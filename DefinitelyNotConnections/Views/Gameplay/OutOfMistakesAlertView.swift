//
//  NoMistakesRemainingAlert.swift
//  DefinitelyNotConnections
//
//  Created by Alex Jones on 07.01.26.
//

import SwiftUI

struct OutOfMistakesAlertView: View {
    @Environment(MainGame.self) private var mainGame: MainGame
    let boxWidth: CGFloat = 320
    let boxHeight: CGFloat = 120
    
    var body: some View {
        if mainGame.getOutOfMistakes() {
            ZStack {
                RoundedRectangle(cornerRadius: 30)
                    .frame(width: boxWidth, height: boxHeight)
                    .foregroundStyle(.white)
                    .opacity(0.9)
                VStack {
                    Text("Oh go on then, have another go!").foregroundStyle(.black)
                    Button {
                        mainGame.resetMistakesRemaining()
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 50)
                                .frame(width: 0.9 * boxWidth, height: 0.3 * boxHeight)
                                .foregroundStyle(.white)
                                .opacity(1.0)
                            Text("Ok")
                                .foregroundStyle(.black)
                        }
                    }
                }
            }
        }
    }
}

/*#Preview {
    NoMistakesRemainingAlert()
        .environment(MainGame(categories: createDefaultTestCategories()))
}*/
