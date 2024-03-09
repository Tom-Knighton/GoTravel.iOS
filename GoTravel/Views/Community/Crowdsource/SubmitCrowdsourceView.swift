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
            Text(globalVm.currentUser == nil ? Strings.Community.Info.SignUpAndPost : Strings.Community.Info.PostATip)
                .fontDesign(.rounded)
                .bold()
                .frame(maxWidth: .infinity)
        }
        .accessibilityHint(Strings.Community.Accessibility.SubmitInfoHint)
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
    
    @Environment(\.dismiss) private var dismiss
    @State private var viewModel = SubmitCrowdsourceViewModel()
    @State private var showConfirmDialog: Bool = false
    @State private var showSuccessAlert: Bool = false

    public var body: some View {
        ScrollView {
            Spacer().frame(height: 16)
            Text(Strings.Community.Info.SubmitHeader)
                .font(.title3.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(Strings.Community.Info.SubmitSubheader)
                .font(.subheadline)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Divider()
            
            Text(Strings.Community.Info.Status)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(Strings.Community.Info.StatusDesc)
                .font(.subheadline)
                .fontWeight(.light)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Picker("", selection: $viewModel.journeyStatus) {
                Text(Strings.Community.Info.NoChange)
                    .accessibilityHint(Strings.Community.Accessibility.NoChangeHint)
                    .tag(SubmitCrowdsourceViewModel.Status.noChange)
                Label(Strings.Community.Info.Delayed, systemImage: Icons.exclamationMarkTriangle)
                    .accessibilityHint(Strings.Community.Accessibility.DelayedHint)
                    .tint(.yellow)
                    .tag(SubmitCrowdsourceViewModel.Status.delayed)
                Label(Strings.Community.Info.Closed, systemImage: Icons.exclamationMarkStopFill)
                    .accessibilityHint(Strings.Community.Accessibility.ClosedHint)
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
            
            Text(Strings.Community.Info.WhatsGoingOn)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(Strings.Community.Info.WhatsGoingOnDesc)
                .font(.subheadline)
                .fontWeight(.light)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            TextField(text: $viewModel.freeText, prompt: Text(Strings.Community.Info.SomeMoreInfo), axis: .vertical) {
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
            
            Text(Strings.Community.Info.HowLong)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(Strings.Community.Info.HowLongDesc)
                .font(.subheadline)
                .fontWeight(.light)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            DatePicker(selection: $viewModel.startsAt, displayedComponents: [.date, .hourAndMinute]) {
                Text(Strings.Community.Info.StartsAt)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            DatePicker(selection: $viewModel.endsAt, in: viewModel.startsAt..., displayedComponents: [.date, .hourAndMinute]) {
                Text(Strings.Community.Info.EndsAt)
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
                        Text(Strings.Misc.Submit)
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
        .alert(Strings.Community.Info.HoldUp, isPresented: $showConfirmDialog) {
            Button(action: { Task {
                let success = await self.viewModel.submit(for: self.entityId)
                if success {
                    self.showSuccessAlert = true
                }
            }}) { Text(Strings.Misc.Continue) }
            Button(Strings.Misc.Cancel) {}
        } message: {
            Text(Strings.Community.Info.ConfirmBeforeSubmit)
        }
        .alert(Strings.Community.Info.HoldUp, isPresented: $viewModel.showError) {
            Button(Strings.Misc.Ok) {}
        } message: {
            Text(self.viewModel.error ?? Strings.Errors.SomethingWrong)
        }
        .alert(Strings.Misc.Success, isPresented: $showSuccessAlert) {
            Button(Strings.Misc.Ok) { self.dismiss() }
        } message: {
            Text(Strings.Community.Info.SuccessMsg)
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
