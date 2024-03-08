//
//  CrowdsourceView.swift
//  GoTravel
//
//  Created by Tom Knighton on 08/03/2024.
//

import SwiftUI
import GoTravel_Models

public struct CrowdsourceView: View {
    
    @State private var showSheet: Bool = false
    @State private var showInfoAlert: Bool = false
    var crowdsources: [CrowdsourceSubmission]
    var fullMode: Bool
    
    public init(crowdsources: [CrowdsourceSubmission], fullMode: Bool = false) {
        self.crowdsources = crowdsources
        self.fullMode = fullMode
    }
    
    
    public var body: some View {
        VStack {
            if (fullMode) {
                Spacer().frame(height: 16)
            }
            
            HStack {
                Text("Users reported the following:")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(fullMode ? .title3.bold() : .body.bold())
                Button(action: { self.showInfoAlert = true }) {
                    Image(systemName: "info.circle")
                }
            }
            
            
            initialFlagsView()
                .padding(.bottom, 2)
            
            let withText = crowdsources.filter { $0.text != nil && $0.text?.isEmpty == false }
            let viewable = fullMode ? crowdsources : Array(withText.prefix(2))
            ForEach(viewable, id: \.crowdsourceId) { submission in
                Text("\"" + (submission.text ?? "") + "\"")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
                    .fontWeight(.light)
                Divider()
            }
            
            if (!fullMode && withText.dropFirst(2).count > 0) {
                Button(action: { self.showSheet = true }) {
                    Text("See More")
                }
            }
            
            if (fullMode) {
                Spacer()
            }
        }
        .fontDesign(.rounded)
        .padding(.horizontal, 8)
        .padding(.vertical, 6)
        .overlay {
            if !fullMode {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.gray, lineWidth: 1)
            }
        }
        .sheet(isPresented: $showSheet) {
            ScrollView {
                CrowdsourceView(crowdsources: crowdsources, fullMode: true)
            }
        }
        .alert(Text("Information"), isPresented: $showInfoAlert) {
            Button(action: {}) { Text("Ok")}
        } message: {
            Text("Users can submit information on any stop, line or line mode that they believe will be helpful to other users. Submitted information is reviewed automatically and manually, and you can vote on information if you believe it to be helpful. If you want to report information for being irrelevant or harmful, you can do so - and the information will be flagged for further review.")
        }

    }
    
    @ViewBuilder
    private func initialFlagsView() -> some View {
        VStack {
            if crowdsources.contains(where: { $0.isClosed }) {
               Label("Closed", systemImage: "exclamationmark.octagon.fill")
                   .foregroundStyle(.red)
                   .bold()
                   .frame(maxWidth: .infinity, alignment: .leading)
            }
            if crowdsources.contains(where: { $0.isDelayed }) {
                Label("Delayed Journeys", systemImage: "exclamationmark.triangle")
                   .foregroundStyle(.yellow)
                   .bold()
                   .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}


#Preview {
    
    let crowdsources: [CrowdsourceSubmission] = [
        .init(crowdsourceId: "1", text: "", isDelayed: true, isClosed: true, started: Date(), expectedEnd: Date(), isFlagged: false, submittedBy: PreviewUserData.User1, currentUserVoteStatus: .noVote, score: 12),
        .init(crowdsourceId: "2", text: "There were a huge queues today to get out of the station, delayed my journey", isDelayed: true, isClosed: true, started: Date(), expectedEnd: Date(), isFlagged: false, submittedBy: PreviewUserData.User2, currentUserVoteStatus: .noVote, score: 0),
        .init(crowdsourceId: "3", text: "A lot busier than usual, some exits are closed", isDelayed: true, isClosed: true, started: Date(), expectedEnd: Date(), isFlagged: false, submittedBy: PreviewUserData.User2, currentUserVoteStatus: .noVote, score: 0)
    ]
    
    return VStack {
        CrowdsourceView(crowdsources: crowdsources)
            .padding(.horizontal, 16)
    }
}
