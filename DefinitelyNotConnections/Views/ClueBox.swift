//
//  ClueBox.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 02.06.25.
//

import SwiftUI

struct ClueBoxStyle: View {
    var clueBoxText: String
    var boxColour: Color
    var textColour: Color
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundStyle(boxColour)
                .frame(width: 80, height: 80)
            Text(clueBoxText)
                .foregroundStyle(textColour)
                .font(.system(size: 13, weight: .bold, design: .rounded))
        }
    }
}
