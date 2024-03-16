//
//  CrowdsourceView.swift
//  GoTravel
//
//  Created by Tom Knighton on 08/03/2024.
//

import SwiftUI 
import GoTravel_Models
import GoTravel_API

public struct CrowdsourceView: View {
    
    private var entityId: String
    @State private var showSheet: Bool = false
    @State private var showInfoAlert: Bool = false
    @State private var showReportAlert: Bool = false
    @State private var isLoading: Bool = false
    @State private var crowdsources: [CrowdsourceSubmission]
    
    var reportReasons: [String] = [
        "Misleading, Incorrect or Irrelevant",
        "Innapropriate or Offensive",
        "Spam or Advertisement",
        "Harrasment or Bullying",
        "Safety Concern or Illegal"
    ]
    
    var fullMode: Bool
    
    public init(entityId: String, crowdsources: [CrowdsourceSubmission], fullMode: Bool = false) {
        self.entityId = entityId
        self._crowdsources = State(wrappedValue: crowdsources)
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
                VStack {
                    if let text = submission.text {
                        Text(Strings.Misc.Quote(text))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .multilineTextAlignment(.leading)
                            .fontWeight(.light)
                    }
                    
                    HStack {
                        Menu {
                            Section("Report Reason:") {
                                ForEach(self.reportReasons, id: \.self) { reason in
                                    Button(action: { self.report(reason, id: submission.crowdsourceId)}) {
                                        Text(reason)
                                    }
                                }
                            }
                        } label: {
                            Image(systemName: "flag")
                        }
                        .disabled(self.isLoading)
                        
                        Spacer()
                        
                        Button(action: { self.vote(.upvoted, id: submission.crowdsourceId)}) {
                            HStack(spacing: 2) {
                                Image(systemName: "arrow.up.circle")
                                Text(String(describing: submission.score))
                                    .font(.subheadline)
                            }
                        }
                        .tint(submission.currentUserVoteStatus == .upvoted ? .orange : .accentColor)
                        .disabled(self.isLoading)

                        Button(action: { self.vote(.downvoted, id: submission.crowdsourceId) }) {
                            Image(systemName: "arrow.down.circle")
                        }
                        .tint(submission.currentUserVoteStatus == .downvoted ? .purple : .accentColor)
                        .disabled(self.isLoading)
                    }
                    .padding(.vertical, 1)

                    Divider()
                }
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
                CrowdsourceView(entityId: entityId, crowdsources: crowdsources, fullMode: true)
            }
        }
        .alert(Text(Strings.Misc.Information), isPresented: $showInfoAlert) {
            Button(action: {}) { Text(Strings.Misc.Ok)}
        } message: {
            Text(Strings.Community.Info.Blurb)
        }
        .alert(Text("Report Received"), isPresented: $showReportAlert) {
            Button(action: {}) { Text(Strings.Misc.Ok) }
        } message: {
            Text("Your report has been received, it will be reviewed manually.")
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
    
    private func vote(_ status: CrowdsourceVoteStatus, id: String) {
        guard !isLoading else { return }
        
        Task {
            self.isLoading = true
            defer { self.isLoading = false }
            
            do {
                if try await CrowdsourceService.Vote(on: id, status) {
                    self.crowdsources = try await CrowdsourceService.GetSubmissions(for: entityId)
                }
            }
            catch {
                print(error)
            }
        }
    }
    
    private func report(_ reason: String, id: String) {
        guard !isLoading else { return }
        
        Task {
            self.isLoading = true
            defer { self.isLoading = false }
            
            do {
                if try await CrowdsourceService.Report(id, reason: reason) {
                    self.crowdsources = try await CrowdsourceService.GetSubmissions(for: entityId)
                    self.showReportAlert = true
                }
            }
            catch {
                print(error)
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
        CrowdsourceView(entityId: "HUBSRA", crowdsources: crowdsources)
            .padding(.horizontal, 16)
    }
}
#endif
