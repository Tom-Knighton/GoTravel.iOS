//
//  PostSignupView.swift
//  GoTravel
//
//  Created by Tom Knighton on 11/02/2024.
//

import SwiftUI

public struct PostSignupView: View {
    
    
    
    public var body: some View {
        ZStack {
            Color.layer1.ignoresSafeArea()
            
            VStack {
                Spacer().frame(height: 16)
                Text("Woohoo!")
                    .font(.title2.bold())
                    .fontDesign(.rounded)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("Thank you for signing up, now you can choose how others will see you:")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .fontDesign(.rounded)
                
                Spacer()
                
                //TODO: Replace w/ image
                Circle()
                    .frame(width: 150, height: 150)
                
                Spacer()
                
                Button(action: {}) {
                    Text("Continue")
                        .frame(maxWidth: .infinity)
                }
                .disabled(true)
                .buttonStyle(.borderedProminent)
                .bold()
                .fontDesign(.rounded)
                
                Spacer().frame(height: 16)
            }
            .padding(.horizontal, 16)
        }
    }
}

#Preview {
    VStack {
        
    }
    .sheet(isPresented: .constant(true)) {
        PostSignupView()
            .presentationDetents([.medium])
            .interactiveDismissDisabled()
            .presentationBackgroundInteraction(.disabled)
    }
}
