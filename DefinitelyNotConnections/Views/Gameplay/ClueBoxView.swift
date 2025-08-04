//
//  ClueBox.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 02.06.25.
//

import SwiftUI

struct ClueBoxView: View {
    var clueBox: ClueBox
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20).aspectRatio(1, contentMode: .fit).frame(width: 80, height: 80)
            let text = Text(clueBox.text).font(.system(size: 13, weight: .bold, design: .rounded))
            if clueBox.isSelected {
                shape.foregroundStyle(.gray)
                text.foregroundStyle(.black)
            } else {
                shape.foregroundStyle(.foreground)
                text.foregroundStyle(.background)
            }
        }
        .offset(x: clueBox.shake ? -10 : 0)
    }
}

