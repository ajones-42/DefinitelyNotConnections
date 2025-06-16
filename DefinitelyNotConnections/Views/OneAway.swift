//
//  OneAway.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 16.06.25.
//

import SwiftUI

struct OneAway: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(.green)
                .frame(width: 110, height: 70)
            Text("One Away!")
                .foregroundStyle(.background)
        }
    }
}

#Preview {
    OneAway()
}
