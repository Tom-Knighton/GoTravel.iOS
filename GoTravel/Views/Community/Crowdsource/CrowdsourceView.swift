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
                Text(Strings.Community.Info.UsersReported)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(fullMode ? .title3.bold() : .body.bold())
                    .accessibilityAddTraits(.isHeader)
                Button(action: { self.showInfoAlert = true }) {
                    Image(systemName: Icons.infoCircle)
                        .accessibilityLabel(Strings.Community.Accessibility.UserInfoLabel)
                        .accessibilityHint(Strings.Community.Accessibility.UserInfoHint)
                }
            }
            
            
            initialFlagsView()
                .padding(.bottom, 2)
            
            let withText = crowdsources.filter { $0.text != nil && $0.text?.isEmpty == false }
            let viewable = fullMode ? crowdsources : Array(withText.prefix(2))
            ForEach(viewable, id: \.crowdsourceId) { submission in
                if let text = submission.text {
                    Text(Strings.Misc.Quote(text))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .multilineTextAlignment(.leading)
                        .fontWeight(.light)
                }
               
                Divider()
            }
            
            if (!fullMode && withText.dropFirst(2).count > 0) {
                Button(action: { self.showSheet = true }) {
                    Text(Strings.Misc.TapToSeeMore)
                }
                .accessibilityHint(Strings.Community.Accessibility.UserInfoSeeMoreHint)
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
        .alert(Text(Strings.Misc.Information), isPresented: $showInfoAlert) {
            Button(action: {}) { Text(Strings.Misc.Ok)}
        } message: {
            Text(Strings.Community.Info.Blurb)
        }

    }
    
    @ViewBuilder
    private func initialFlagsView() -> some View {
        VStack {
            if crowdsources.contains(where: { $0.isClosed }) {
                Label(Strings.Community.Info.Closed, systemImage: Icons.exclamationMarkStopFill)
                   .foregroundStyle(.red)
                   .bold()
                   .frame(maxWidth: .infinity, alignment: .leading)
            }
            if crowdsources.contains(where: { $0.isDelayed }) {
                Label(Strings.Community.Info.Delayed, systemImage: Icons.exclamationMarkTriangle)
                   .foregroundStyle(.yellow)
                   .bold()
                   .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

#if DEBUG
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
#endif
