//
//  JourneyResultsView.swift
//  GoTravel
//
//  Created by Tom Knighton on 02/02/2024.
//

import SwiftUI

public struct JourneyResultsView: View {
    
    @Environment(JourneyPlannerViewModel.self) private var viewModel
    
    public var body: some View {
        LazyVStack {
            
        }
    }
}


#Preview {
    
    let vm = JourneyPlannerViewModel()
    
    return JourneyResultsView()
        .environment(vm)
}
