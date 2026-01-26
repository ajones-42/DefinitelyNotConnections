//
//  OneAway.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 16.06.25.
//

import SwiftUI

struct PopupView: View {
    let popup: Popup?

    var body: some View {
        let popupBox = RoundedRectangle(cornerRadius: 10)
            .foregroundStyle(.foreground)
            .frame(width: 150, height: 70)
        if let popup {
            ZStack {
                popupBox
                Text(popup.message)
                    .foregroundStyle(.background)
            }
        } else {
            popupBox.opacity(0)
        }
    }
}

#Preview {
    PopupView(popup: Popup(message: "One away!"))
}
