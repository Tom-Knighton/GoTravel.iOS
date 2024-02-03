//
//  JourneyPlannerPage.swift
//  GoTravel
//
//  Created by Tom Knighton on 28/01/2024.
//

import SwiftUI
import GoTravel_Models
import DotLottie

public struct JourneyPlannerPage: View {
    
    @State private var viewModel = JourneyPlannerViewModel()
    @State private var showSearchSheetType: JourneyStopSearchType? = nil
    @State private var showTimeSheet: Bool = false

    public var body: some View {
        ZStack {
            Color.layer1.ignoresSafeArea()
            ScrollView {
                VStack {
                    Text(Strings.JourneyPage.PlanATrip)
                        .font(.title3.bold())
                        .fontDesign(.rounded)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    HStack {
                        VStack {
                            LocationField(promptText: Strings.JourneyPage.FromPrompt, imageName: Icons.location_magnifyingglass, type: .from, point: viewModel.from)
                            LocationField(promptText: Strings.JourneyPage.ToPrompt, imageName: Icons.location_magnifyingglass, type: .to, point: viewModel.to)
                        }
                        
                        VStack {
                            Button(action: { viewModel.swapStops() }) {
                                Image(systemName: Icons.arrowUpAndDown)
                                    .resizable()
                                    .frame(width: 15, height: 15)
                                    .fontWeight(.bold)
                                    .fontDesign(.rounded)
                                    .foregroundStyle(.white)
                                    .clipShape(.rect(cornerRadius: 10))
                            }
                            .buttonStyle(.borderedProminent)
                            
                            if !viewModel.showViaField {
                                Button(action: { withAnimation { viewModel.showViaField = true } }) {
                                    Image(systemName: Icons.add)
                                        .resizable()
                                        .frame(width: 15, height: 15)
                                        .fontWeight(.bold)
                                        .fontDesign(.rounded)
                                        .foregroundStyle(.white)
                                        .clipShape(.rect(cornerRadius: 10))
                                }
                                .buttonStyle(.borderedProminent)
                                .transition(.slide.combined(with: .opacity))
                            }
                            
                        }
                        .frame(width: 40)
                    }
                    
                    if viewModel.showViaField {
                        HStack {
                            LocationField(promptText: Strings.JourneyPage.ViaPrompt, imageName: Icons.location_magnifyingglass, type: .via, point: viewModel.via)
                            Button(action: { withAnimation { viewModel.showViaField = false } }) {
                                Image(systemName: Icons.minus)
                                    .fontWeight(.bold)
                                    .fontDesign(.rounded)
                                    .foregroundStyle(.white)
                                    .clipShape(.rect(cornerRadius: 10))
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(Color.red)
                            .transition(.slide.combined(with: .opacity))
                            .frame(width: 40)
                        }
                    }
                    
                    
                    HStack {
                        Button(action: { self.showTimeSheet = true }) {
                            HStack {
                                Image(systemName: Icons.clockFilled)
                                Text(getTimeToDisplay())
                                    .fontWeight(.bold)
                                    .fontDesign(.rounded)
                                    .frame(maxWidth: .infinity)
                            }
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(Color.layer2)
                        .foregroundStyle(.primary)
                    }
                    HStack {
                        Button(action: {
                            Task {
                                await self.viewModel.planJourney()
                            }
                        }) {
                            Text(Strings.JourneyPage.PlanJourneyButton)
                                .fontWeight(.bold)
                                .fontDesign(.rounded)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 4)
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    
                    Spacer()
                    
                    if viewModel.isSearchingJourneys {
                        Text(Strings.Misc.Searching)
                            .font(.title2.bold())
                            .fontDesign(.rounded)
                        DotLottieAnimation(fileName: Strings.Assets.BusLoading, config: AnimationConfig(autoplay: true, loop: true))
                            .view()
                            .frame(width: 100, height: 200)
                    }
                    if let result = viewModel.journeyResult {
                        JourneyResultsView(result: result)
                    }
                    
                }
                .padding(.horizontal, 16)
            }
        }
        .navigationTitle(Strings.JourneyPage.Title)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {}) {
                    Image(systemName: Icons.filter)
                        .fontWeight(.bold)
                        .fontDesign(.rounded)
                }
            }
        }
        .sheet(item: $showSearchSheetType, onDismiss: { viewModel.searchResults = [] }) { type in
            JourneyLocationSearchSheet(type: type, onSelection: { point in
                switch type {
                case .from:
                    self.viewModel.from = point
                    break
                case .to:
                    self.viewModel.to = point
                    break
                case .via:
                    self.viewModel.via = point
                }
                self.showSearchSheetType = nil
            })
            .environment(viewModel)
        }
        .sheet(isPresented: $showTimeSheet) {
            JourneyTimeSelectSheet()
                .environment(self.viewModel)
                .presentationDetents([.fraction(0.45)])
                .presentationBackgroundInteraction(.disabled)
        }
    }
    
    
    @ViewBuilder
    private func LocationField(promptText: LocalizedStringKey, imageName: String, type: JourneyStopSearchType, point: JourneyRequestPoint? = nil) -> some View {
        
        let hasValue = (point?.displayName.count ?? 0) > 0
        HStack {
            Button(action: {}) {
                Image(systemName: imageName)
                    .shadow(radius: 3)
            }
            Text(point?.displayName ?? promptText.toString())
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(hasValue ? Color.primary : Color.gray)
        }
        .padding(.horizontal, 8)
        .frame(maxWidth: .infinity, minHeight: 50)
        .background(Color.layer2)
        .clipShape(.rect(cornerRadius: 10))
        .shadow(radius: 3)
        .onTapGesture {
            self.showSearchSheetType = type
        }
    }
    
    private func getTimeToDisplay() -> LocalizedStringKey {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        switch self.viewModel.journeyTime {
        case .now:
            return Strings.JourneyPage.Now
        case .arriveAt(let date):
            return Strings.JourneyPage.ArriveBy("\(formatter.string(from: date)) \(getDayToDisplay(date))")
        case .leaveAt(let date):
            return Strings.JourneyPage.LeaveAt("\(formatter.string(from: date)) \(getDayToDisplay(date))")
        }
    }
    
    private func getDayToDisplay(_ date: Date) -> String {
        let calendar = Calendar.current
        
        if calendar.isDateInToday(date) {
            return ""
        } else if calendar.isDateInTomorrow(date) {
            return Strings.JourneyPage.Tomorrow.toString()
        } else {
            let formatter = DateFormatter()
            formatter.timeStyle = .none
            formatter.dateStyle = .medium
            
            let day = date.formatted(Date.FormatStyle().day(.twoDigits))
            let month = date.formatted(Date.FormatStyle().month(.abbreviated))
            
            return day + " " + month
        }
    }
}

#Preview {
    NavigationStack {
        JourneyPlannerPage()
        .environment(JourneyPlannerViewModel())
        .environment(GlobalViewModel())
        .environment(LocationManager())
    }
}
