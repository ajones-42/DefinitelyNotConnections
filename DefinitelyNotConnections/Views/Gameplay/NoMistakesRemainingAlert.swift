//
//  NoMistakesRemainingAlert.swift
//  DefinitelyNotConnections
//
//  Created by Alex Jones on 07.01.26.
//

import SwiftUI

struct NoMistakesRemainingAlert: View {
    var mistakes: Mistakes
    let boxWidth: CGFloat = 320
    let boxHeight: CGFloat = 120
    
    var body: some View {
        if mistakes.noMistakesLeft {
            ZStack {
                RoundedRectangle(cornerRadius: 30)
                    .frame(width: boxWidth, height: boxHeight)
                    .foregroundStyle(.white)
                    .opacity(0.9)
                VStack {
                    Text("Oh go on then, have another go!").foregroundStyle(.black)
                    Button {
                        mistakes.reset()
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
