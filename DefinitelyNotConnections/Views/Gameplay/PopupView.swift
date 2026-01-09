//
//  OneAway.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 16.06.25.
//

import SwiftUI

struct PopupView: View {
    var popup: Popup

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(.foreground)
                .frame(width: 150, height: 70)
            Text(popup.message)
                .foregroundStyle(.background)
        }
        .opacity(popup.isPresented ? 1 : 0)
    }
}

//#Preview {
    //PopupView(text: "One away!")
    //PopupView(text: "Already guessed!")
//}
