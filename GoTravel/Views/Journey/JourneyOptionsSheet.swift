//
//  JourneyOptionsSheet.swift
//  GoTravel
//
//  Created by Tom Knighton on 05/02/2024.
//

import SwiftUI
import GoTravel_Models

public struct JourneyOptionsSheet: View {
    
    @Environment(JourneyPlannerViewModel.self) private var viewModel
    @Environment(\.accessibilityVoiceOverEnabled) private var voiceOver
    @Environment(\.dismiss) private var dismiss
    
    @State private var stepFreeVehicle: Bool = false
    @State private var stepFreePlatform: Bool = false
    @State private var quicketJourney: Bool = false
    @State private var fewestChanges: Bool = false
    @State private var fewestWalking: Bool = false
    
    public var body: some View {
        ZStack {
            Color.layer1.ignoresSafeArea()
            ScrollView {
                Spacer().frame(height: 16)
                
                if voiceOver {
                    HStack {
                        Spacer()
                        Button(action: { self.dismiss() }) {
                            ExitButtonView()
                        }
                    }
                    Spacer().frame(height: 8)
                }
                
                Text(Strings.JourneyPage.JourneyOptions)
                    .font(.title2.bold())
                    .fontDesign(.rounded)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack {
                    Text(Strings.JourneyPage.JourneyAccessHead)
                        .font(.title3.bold())
                        .fontDesign(.rounded)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Toggle(isOn: $stepFreeVehicle, label: {
                        Text(Strings.JourneyPage.StepFreeVehicle)
                            .bold()
                            .fontDesign(.rounded)
                    })
                    Divider()
                    Toggle(isOn: $stepFreePlatform, label: {
                        Text(Strings.JourneyPage.StepFreePlatform)
                            .bold()
                            .fontDesign(.rounded)
                    })
                    Divider()
                    Text(accessibilityDescription())
                        .font(.subheadline)
                        .fontDesign(.rounded)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                }
                .frame(maxWidth: .infinity)
                .padding(8)
                .background(Color.layer2)
                .clipShape(.rect(cornerRadius: 10))
                .shadow(radius: 3)
                
                Spacer().frame(height: 16)
                
                VStack {
                    Text(Strings.JourneyPage.JourneyPreferencesHead)
                        .font(.title3.bold())
                        .fontDesign(.rounded)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer().frame(height: 8)
                    Toggle(isOn: $quicketJourney, label: {
                        Text(Strings.JourneyPage.FastJourneys)
                            .bold()
                            .fontDesign(.rounded)
                    })
                    .toggleStyle(RadioToggleStyle())
                    Divider()
                    Toggle(isOn: $fewestChanges, label: {
                        Text(Strings.JourneyPage.FewChanges)
                            .bold()
                            .fontDesign(.rounded)
                    })
                    .toggleStyle(RadioToggleStyle())
                    Divider()
                    Toggle(isOn: $fewestWalking, label: {
                        Text(Strings.JourneyPage.LeastWalk)
                            .bold()
                            .fontDesign(.rounded)
                    })
                    .toggleStyle(RadioToggleStyle())
                    Divider()
                    
                    Text(preferenceDescription())
                        .font(.subheadline)
                        .fontDesign(.rounded)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                }
                .frame(maxWidth: .infinity)
                .padding(8)
                .background(Color.layer2)
                .clipShape(.rect(cornerRadius: 10))
                .shadow(radius: 3)
                
                Spacer()
            }
            .contentMargins(16)
        }
        .onChange(of: self.stepFreeVehicle) { _, newValue in
            self.viewModel.setJourneyAccessibilityPreference(.stepFreeVehicle, to: newValue)
        }
        .onChange(of: self.stepFreePlatform) { _, newValue in
            self.viewModel.setJourneyAccessibilityPreference(.stepFreePlatform, to: newValue)
        }
        .onChange(of: self.quicketJourney) { _, newValue in
            if newValue {
                self.viewModel.toggleJourneyPreference(.leastTime)
            }
        }
        .onChange(of: self.fewestChanges) { _, newValue in
            if newValue {
                self.viewModel.toggleJourneyPreference(.leastChanges)
            }
        }
        .onChange(of: self.fewestWalking) { _, newValue in
            if newValue {
                self.viewModel.toggleJourneyPreference(.leastWalking)
            }
        }
        .onChange(of: self.viewModel.journeyPreferenceMode, initial: true, { _, newValue in
            switch newValue {
            case .leastTime:
                self.fewestChanges = false
                self.fewestWalking = false
                self.quicketJourney = true
            case .leastChanges:
                self.fewestChanges = true
                self.fewestWalking = false
                self.quicketJourney = false
            case .leastWalking:
                self.fewestChanges = false
                self.fewestWalking = true
                self.quicketJourney = false
            }
        })
        .onChange(of: self.viewModel.journeyAccessibilityPreference, initial: true, { _, newValue in
            self.stepFreeVehicle = newValue.contains(.stepFreeVehicle)
            self.stepFreePlatform = newValue.contains(.stepFreePlatform)
        })
    }
    
    private func accessibilityDescription() -> LocalizedStringKey {
        if self.stepFreeVehicle {
            return Strings.JourneyPage.OptionsVehicleAccessibilityDescription
        } else if self.stepFreePlatform {
            return Strings.JourneyPage.OptionsPlatformAccessibilityDescription
        } else {
            return Strings.JourneyPage.OptionsNoAccessibilityDescription
        }
    }
    
    private func preferenceDescription() -> LocalizedStringKey {
        if self.fewestChanges {
            return Strings.JourneyPage.OptionsFewChangesDescription
        }
        if self.fewestWalking {
            return Strings.JourneyPage.OptionsFewWalkingDescription
        }
        else {
            return Strings.JourneyPage.OptionsFastestDescription
        }
    }
}


#Preview {
    let journeyViewModel = JourneyPlannerViewModel()
    
    return JourneyOptionsSheet()
        .environment(journeyViewModel)
}
