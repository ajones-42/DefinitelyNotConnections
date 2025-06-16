//
//  ShowMomentarily.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 16.06.25.
//


/* From https://stackoverflow.com/questions/78959243/show-view-and-then-hide-it-in-2-seconds/78959877#78959877
 */

import SwiftUI

struct ShowMomentarily<Trigger: Equatable>: ViewModifier {
    
    let duration: Duration
    let trigger: Trigger
    @State private var isVisible = false // initially not visible
    @State private var initial = true
    
    func body(content: Content) -> some View {
        content
            .opacity(isVisible ? 1 : 0)
            .task(id: trigger) {
                // do not do the task on the first appearance
                if initial {
                    initial = false
                    return
                }
                
                isVisible = true
                do {
                    try await Task.sleep(for: duration)
                    isVisible = false
                } catch {
                    // this means the task has been cancelled
                    // e.g. 'trigger' changes again before the duration ended
                }
            }
            .animation(.default, value: isVisible)
    }
}

extension View {
    func show(for delay: Duration, trigger: some Equatable) -> some View {
        modifier(ShowMomentarily(duration: delay, trigger: trigger))
    }
}
