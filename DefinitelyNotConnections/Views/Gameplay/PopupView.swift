//
//  OneAway.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 16.06.25.
//

import SwiftUI

struct PopupView: View {
    @Environment(Popup.self) private var popup: Popup
    //let text: String

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(.foreground)
                .frame(width: 150, height: 70)
            Text(popup.text)
                .foregroundStyle(.background)
        }
        .show(for: .seconds(2), trigger: popup.trigger)
    }
}

//#Preview {
    //PopupView(text: "One away!")
    //PopupView(text: "Already guessed!")
//}
