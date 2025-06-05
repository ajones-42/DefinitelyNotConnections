//
//  ButtonStyle.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 04.06.25.
//

import SwiftUI

struct NormalButton: View {
    let text: String
    var boxColour: Color
    var textColour: Color
    
    var body: some View {
    ZStack {
        RoundedRectangle(cornerRadius: 20)
            .foregroundStyle(boxColour)
            .frame(width: 80, height: 40)
        Text(text)
            .foregroundStyle(textColour)
            .font(.system(size: 13, weight: .bold, design: .rounded))
        }
    }
}
