//
//  OneAway.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 16.06.25.
//

import SwiftUI

struct PopupView: View {
    @Binding var text: String
    @Binding var isPresented: Bool

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(.foreground)
                .frame(width: 150, height: 70)
            Text(text)
                .foregroundStyle(.background)
        }
        .opacity(isPresented ? 1 : 0)
    }
}

//#Preview {
    //PopupView(text: "One away!")
    //PopupView(text: "Already guessed!")
//}
