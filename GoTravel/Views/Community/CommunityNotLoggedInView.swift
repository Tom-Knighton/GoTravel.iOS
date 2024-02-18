//
//  CommunityNotLoggedInView.swift
//  GoTravel
//
//  Created by Tom Knighton on 18/02/2024.
//

import SwiftUI

public struct CommunityNotLoggedInView: View {
    
    public var body: some View {
        ZStack {
            Color.layer1.ignoresSafeArea()
            
            ScrollView {
                VStack {
                    
                }
            }
            .scrollBounceBehavior(.basedOnSize)
        }
    }
}

#Preview(body: {
    
    NavigationStack {
        CommunityNotLoggedInView()
            .navigationTitle("Community")
    }
})
