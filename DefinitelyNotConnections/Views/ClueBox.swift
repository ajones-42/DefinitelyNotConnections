//
//  ClueBox.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 02.06.25.
//

import SwiftUI

struct ClueBoxStyle: View {
    var clueBox: ConnectionsGameModel.ClueBox
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20).aspectRatio(1, contentMode: .fit).frame(width: 80, height: 80)
            let text = Text(clueBox.text).font(.system(size: 13, weight: .bold, design: .rounded))
            if clueBox.isSelected { // Possibly want to put into VM/its own VM but would need 16 variables?
                shape.foregroundStyle(.black)
                text.foregroundStyle(.white)
            } else {
                shape.foregroundStyle(.gray)
                text.foregroundStyle(.black)
            }
        }
    }
}

