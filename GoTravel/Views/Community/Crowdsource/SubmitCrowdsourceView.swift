//
//  SubmitCrowdsourceView.swift
//  GoTravel
//
//  Created by Tom Knighton on 09/03/2024.
//

import SwiftUI


public struct SubmitCrowdsourceButton: View {
    
    @Environment(GlobalViewModel.self) private var globalVm
    @State private var showSheet: Bool = false
    public let entityId: String
    
    public var body: some View {
        Button(action: { self.showSheet = true }) {
            Text(globalVm.currentUser == nil ? "Sign up and Post a tip" : "Post a tip")
                .fontDesign(.rounded)
                .bold()
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(.borderedProminent)
        .tint(.orange)
        .shadow(color: .orange, radius: 3)
        .sheet(isPresented: $showSheet, content: {
            if globalVm.currentUser != nil {
                SubmitCrowdsourceView(entityId: entityId)
            } else {
                VStack {
                    Spacer().frame(height: 16)
                    CommunityNotLoggedInView()
                }
            }
        })
    }
}

public struct SubmitCrowdsourceView: View {
    
    public let entityId: String
    
    @State private var viewModel = SubmitCrowdsourceViewModel()
    @State private var showConfirmDialog: Bool = false
    
    public var body: some View {
        ScrollView {
            Spacer().frame(height: 16)
            Text("Submit your own information")
                .font(.title3.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("Submit useful tips and up-to-date information to help other users on their journeys")
                .font(.subheadline)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Divider()
            
            Text("Status:")
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("Did you experience delayed journeys or a closed station? If not, feel free to leave this blank and fill in some text below")
                .font(.subheadline)
                .fontWeight(.light)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Picker("Status", selection: $viewModel.journeyStatus) {
                Text("No change in journey")
                    .tag(SubmitCrowdsourceViewModel.Status.noChange)
                Label("Delayed Journey", systemImage: "exclamationmark.triangle")
                    .tint(.yellow)
                    .tag(SubmitCrowdsourceViewModel.Status.delayed)
                Label("Closed", systemImage: "exclamationmark.octagon.fill")
                    .tint(.red)
                    .tag(SubmitCrowdsourceViewModel.Status.closed)
            }
            .pickerStyle(.menu)
            .labelsHidden()
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.layer2)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Divider()
            
            Text("What's going on here?")
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("(Optional) Provide some further information to users like 'There were huge queues to leave!'")
                .font(.subheadline)
                .fontWeight(.light)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            TextField(text: $viewModel.freeText, prompt: Text("Some more info"), axis: .vertical) {
                Text("")
            }
            .lineLimit(10)
            .padding()
            .labelsHidden()
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.layer2.opacity(0.7))
            }
            Text(verbatim: "\(viewModel.freeText.count)/\(viewModel.freeTextLimit)")
                .font(.caption)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .onChange(of: viewModel.freeText) { _, newValue in
                    viewModel.freeText = filterText(newValue)
                }
            
            Divider()
            
            Text("How long?")
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("Just provide a rough estimate so other users know how long to expect your info to be relevant for")
                .font(.subheadline)
                .fontWeight(.light)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            DatePicker(selection: $viewModel.startsAt, displayedComponents: [.date, .hourAndMinute]) {
                Text("Started at:")
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            DatePicker(selection: $viewModel.endsAt, in: viewModel.startsAt..., displayedComponents: [.date, .hourAndMinute]) {
                Text("Expected end:")
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            Divider()
            
            Spacer()
            
            Button(action: { self.showConfirmDialog = true }) {
                Group {
                    if self.viewModel.isLoading {
                        ProgressView()
                    } else {
                        Text("Submit")
                    }
                }
                .bold()
                .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .tint(.orange)
            .shadow(color: .orange, radius: 3)
        
            Spacer()
        }
        .fontDesign(.rounded)
        .contentMargins(.horizontal, 16, for: .scrollContent)
        .alert("Hold up!", isPresented: $showConfirmDialog) {
            Button(action: { Task { await self.viewModel.submit(for: self.entityId) }}) { Text("Confirm") }
            Button("Cancel") {}
        } message: {
            Text("👉 By submitting, you confirm your info is accurate and grant us rights to use it.\n👉 It's public, so no confidential stuff.\n👉 Be respectful.")
        }
        .alert("Hold up!", isPresented: $viewModel.showError) {
            Button("Ok") {}
        } message: {
            Text(self.viewModel.error ?? "Something went wrong")
        }

    }
    
    private func filterText(_ input: String) -> String {
        let max = viewModel.freeTextLimit
        let filtered = input.reduce(into: "") { result, char in
            if result.count < max {
                result.append(char)
            }
        }
        
        return filtered
    }
}

#if DEBUG
#Preview {
    let globalVm = GlobalViewModel()
//    globalVm.currentUser = PreviewUserData.Current
    return SubmitCrowdsourceButton(entityId: "HUBSRA")
        .environment(globalVm)
}
#endif
