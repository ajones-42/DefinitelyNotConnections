//
//  AppNavigationButton.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 26.06.25.
//

import SwiftUI

struct AppNavigationButton: View {
    let text: String

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 50)
                .foregroundStyle(.black)
                .frame(width: 200, height: 60)
            Text(text)
                .foregroundStyle(.white)
                .font(.system(size: 18, weight: .bold, design: .rounded))
            }
    }
}

#Preview {
    ZStack {
        Color.purple
            .ignoresSafeArea()
        AppNavigationButton(text: "Play")
    }
}
