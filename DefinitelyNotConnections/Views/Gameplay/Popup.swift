//
//  OneAway.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 16.06.25.
//

import SwiftUI

struct Popup: View {
    let text: String

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(.foreground)
                .frame(width: 150, height: 70)
            Text(text)
                .foregroundStyle(.background)
        }
    }
}

#Preview {
    Popup(text: "One away!")
    Popup(text: "Already guessed!")
}
