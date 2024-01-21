//
//  GaugeTimerView.swift
//  GoTravel
//
//  Created by Tom Knighton on 20/01/2024.
//

import SwiftUI
import UIKit

public struct GaugeTimerView: View {
    
    @Environment(\.colorScheme) private var scheme
    
    private var countTo: Int
    @State private var counter: Int = 0
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    private let onComplete: () -> Void
    
    public init(countTo: Int = 30, onComplete: @escaping () -> Void = {}) {
        self.countTo = countTo
        self.onComplete = onComplete
    }
    
    public var body: some View {
        VStack {
            ZStack {
                Circle()
                    .fill(Color.clear)
                    .overlay(Circle().stroke(Color(uiColor: UIColor.systemGray5)))
                    .shadow(color: .black.opacity(scheme == .dark ? 0.7 : 0), radius: 1)
                
                Circle()
                    .fill(Color.clear)
                    .overlay(
                        Circle()
                            .trim(from: 0, to: self.progress())
                            .stroke(.red, style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round))
                            .animation(.linear, value: self.progress())
                            .rotationEffect(.degrees(90))
                            .shadow(color: .black.opacity(scheme == .dark ? 0.7 : 0.3), radius: 3)
                            .rotation3DEffect(.degrees(180), axis: (x: 1, y: 0, z: 0))
                    )
                
                Text(String(describing: self.countTo - self.counter))
                    .font(.system(size: 10).bold())
                    .fontDesign(.rounded)
                    .animation(.spring, value: self.counter)
            }
            .onReceive(self.timer, perform: { _ in
                guard self.counter + 1 <= self.countTo else { 
                    self.counter = self.countTo
                    return
                }
                
                self.counter += 1
                if self.counter == self.countTo {
                    self.onComplete()
                }
            })
        }
    }
    
    func progress() -> CGFloat {
        return CGFloat(counter) / CGFloat(countTo)
    }
}
