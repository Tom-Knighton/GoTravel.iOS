//
//  JourneyTimeSelectSheet.swift
//  GoTravel
//
//  Created by Tom Knighton on 02/02/2024.
//

import SwiftUI

public struct JourneyTimeSelectSheet: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(JourneyPlannerViewModel.self) private var viewModel
    @Environment(\.accessibilityVoiceOverEnabled) private var voiceOverEnabled
    @State private var pickerMode: Int = 0
    @State private var selectedDate: Date = Date()
    
    public var body: some View {
        ZStack {
            Color.layer3.ignoresSafeArea()
            VStack {
                
                if voiceOverEnabled {
                    Spacer().frame(height: 16)
                    HStack {
                        Spacer()
                        Button(action: { self.dismiss() }) {
                            ExitButtonView()
                        }
                    }
                }
                
                Spacer().frame(height: 16)
                Picker("", selection: $pickerMode) {
                    Text(Strings.JourneyPage.Now).tag(0)
                    Text(Strings.JourneyPage.LeaveAt).tag(1)
                    Text(Strings.JourneyPage.ArriveBy).tag(2)
                }
                .pickerStyle(.segmented)
                
                Spacer()
                
                if let maxDate = maxDate() {
                    DatePicker(selection: $selectedDate, in: Date()...maxDate) {
                        Text("")
                    }
                    .datePickerStyle(.wheel)
                } else {
                    DatePicker(selection: $selectedDate, in: Date()...) {
                        Text("")
                    }
                    .datePickerStyle(.wheel)
                }
                
                Spacer()
            }
            .padding(.horizontal, 12)
            .labelsHidden()
        }
        .onChange(of: self.pickerMode, { oldValue, newValue in
            switch newValue {
            case 0:
                self.viewModel.journeyTime = .now
                break
            case 1:
                self.viewModel.journeyTime = .leaveAt(self.selectedDate)
                break
            case 2:
                self.viewModel.journeyTime = .arriveAt(self.selectedDate)
                break
            default:
                self.viewModel.journeyTime = .now
            }
        })
        .onChange(of: self.selectedDate) { oldValue, newValue in
            switch self.pickerMode {
            case 0:
                self.viewModel.journeyTime = .now
                break
            case 1:
                self.viewModel.journeyTime = .leaveAt(newValue)
                break
            case 2:
                self.viewModel.journeyTime = .arriveAt(newValue)
                break
            default:
                self.viewModel.journeyTime = .now
            }
        }
    }
    
    private func maxDate() -> Date? {
        let calendar = Calendar.current
        return calendar.date(byAdding: .month, value: 1, to: Date())
    }
}
