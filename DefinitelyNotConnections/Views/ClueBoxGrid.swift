//
//  ClueBoxGrid.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 02.06.25.
//

import SwiftUI

struct ClueBoxGrid: View {
    @Binding var connectionsGameModel: ConnectionsGameModel
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    connectionsGameModel.clickClueBox(clueBoxPosition: 0)
                } label: {
                    ClueBoxStyle(clueBoxText: connectionsGameModel.allClueTexts[0], boxColour: connectionsGameModel.boxColours[0], textColour: connectionsGameModel.textColours[0])
                }
                Button {
                    connectionsGameModel.clickClueBox(clueBoxPosition: 1)
                } label: {
                    ClueBoxStyle(clueBoxText: connectionsGameModel.allClueTexts[1], boxColour: connectionsGameModel.boxColours[1], textColour: connectionsGameModel.textColours[1])
                }
                Button {
                    connectionsGameModel.clickClueBox(clueBoxPosition: 2)
                } label: {
                    ClueBoxStyle(clueBoxText: connectionsGameModel.allClueTexts[2], boxColour: connectionsGameModel.boxColours[2], textColour: connectionsGameModel.textColours[2])
                }
                Button {
                    connectionsGameModel.clickClueBox(clueBoxPosition: 3)
                } label: {
                    ClueBoxStyle(clueBoxText: connectionsGameModel.allClueTexts[3], boxColour: connectionsGameModel.boxColours[3], textColour: connectionsGameModel.textColours[3])
                }
            }
            HStack {
                Button {
                    connectionsGameModel.clickClueBox(clueBoxPosition: 4)
                } label: {
                    ClueBoxStyle(clueBoxText: connectionsGameModel.allClueTexts[4], boxColour: connectionsGameModel.boxColours[4], textColour: connectionsGameModel.textColours[4])
                }
                Button {
                    connectionsGameModel.clickClueBox(clueBoxPosition: 5)
                } label: {
                    ClueBoxStyle(clueBoxText: connectionsGameModel.allClueTexts[5], boxColour: connectionsGameModel.boxColours[5], textColour: connectionsGameModel.textColours[5])
                }
                Button {
                    connectionsGameModel.clickClueBox(clueBoxPosition: 6)
                } label: {
                    ClueBoxStyle(clueBoxText: connectionsGameModel.allClueTexts[6], boxColour: connectionsGameModel.boxColours[6], textColour: connectionsGameModel.textColours[6])
                }
                Button {
                    connectionsGameModel.clickClueBox(clueBoxPosition: 7)
                } label: {
                    ClueBoxStyle(clueBoxText: connectionsGameModel.allClueTexts[7], boxColour: connectionsGameModel.boxColours[7], textColour: connectionsGameModel.textColours[7])
                }
            }
            HStack {
                Button {
                    connectionsGameModel.clickClueBox(clueBoxPosition: 8)
                } label: {
                    ClueBoxStyle(clueBoxText: connectionsGameModel.allClueTexts[8], boxColour: connectionsGameModel.boxColours[8], textColour: connectionsGameModel.textColours[8])
                }
                Button {
                    connectionsGameModel.clickClueBox(clueBoxPosition: 9)
                } label: {
                    ClueBoxStyle(clueBoxText: connectionsGameModel.allClueTexts[9], boxColour: connectionsGameModel.boxColours[9], textColour: connectionsGameModel.textColours[9])
                }
                Button {
                    connectionsGameModel.clickClueBox(clueBoxPosition: 10)
                } label: {
                    ClueBoxStyle(clueBoxText: connectionsGameModel.allClueTexts[10], boxColour: connectionsGameModel.boxColours[10], textColour: connectionsGameModel.textColours[10])
                }
                Button {
                    connectionsGameModel.clickClueBox(clueBoxPosition: 11)
                } label: {
                    ClueBoxStyle(clueBoxText: connectionsGameModel.allClueTexts[11], boxColour: connectionsGameModel.boxColours[11], textColour: connectionsGameModel.textColours[11])
                }
            }
            HStack {
                Button {
                    connectionsGameModel.clickClueBox(clueBoxPosition: 12)
                } label: {
                    ClueBoxStyle(clueBoxText: connectionsGameModel.allClueTexts[12], boxColour: connectionsGameModel.boxColours[12], textColour: connectionsGameModel.textColours[12])
                }
                Button {
                    connectionsGameModel.clickClueBox(clueBoxPosition: 13)
                } label: {
                    ClueBoxStyle(clueBoxText: connectionsGameModel.allClueTexts[13], boxColour: connectionsGameModel.boxColours[13], textColour: connectionsGameModel.textColours[13])
                }
                Button {
                    connectionsGameModel.clickClueBox(clueBoxPosition: 14)
                } label: {
                    ClueBoxStyle(clueBoxText: connectionsGameModel.allClueTexts[14], boxColour: connectionsGameModel.boxColours[14], textColour: connectionsGameModel.textColours[14])
                }
                Button {
                    connectionsGameModel.clickClueBox(clueBoxPosition: 15)
                } label: {
                    ClueBoxStyle(clueBoxText: connectionsGameModel.allClueTexts[15], boxColour: connectionsGameModel.boxColours[15], textColour: connectionsGameModel.textColours[15])
                }
            }
        }
    }
}

/*
#Preview {
    ClueBoxGrid()
}
*/
