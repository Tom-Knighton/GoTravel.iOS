//
//  JourneyPlannerPage.swift
//  GoTravel
//
//  Created by Tom Knighton on 28/01/2024.
//

import SwiftUI
import GoTravel_Models
import GoTravel_API
import Turf
import Combine

public struct JourneyPlannerPage: View {
    
    @State private var viewModel = JourneyPlannerViewModel()
    @State private var showSearchSheetType: JourneyStopSearchType? = nil
    @State private var showTimeSheet: Bool = false

    public var body: some View {
        ZStack {
            Color.layer1.ignoresSafeArea()
            
            ScrollView {
                
                Text("Plan a trip:")
                    .font(.title3.bold())
                    .fontDesign(.rounded)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack {
                    VStack {
                        LocationField(promptText: "From:", imageName: "location.magnifyingglass", type: .from, point: viewModel.from)
                        LocationField(promptText: "To:", imageName: "location.magnifyingglass", type: .to, point: viewModel.to)
                    }
                    
                    VStack {
                        Button(action: {}) {
                            Image(systemName: "arrow.up.arrow.down")
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
                                Image(systemName: "plus")
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
                        LocationField(promptText: "Via:", imageName: "location.magnifyingglass", type: .via, point: viewModel.via)
                        Button(action: { withAnimation { viewModel.showViaField = false } }) {
                            Image(systemName: "minus")
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
                            Image(systemName: "clock.fill")
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
                    Button(action: {}) {
                        Text("Plan Journey")
                            .fontWeight(.bold)
                            .fontDesign(.rounded)
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                }
                
                Spacer()
            }
            .contentMargins(16)
        }
        .navigationTitle("Journeys")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {}) {
                    Image(systemName: "line.3.horizontal.decrease.circle")
                        .fontWeight(.bold)
                        .fontDesign(.rounded)
                }
            }
        }
        .sheet(item: $showSearchSheetType) { type in
            SearchLocView(type: type, onSelection: { point in
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
                viewModel.searchResults = []
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
    private func LocationField(promptText: String, imageName: String, type: JourneyStopSearchType, point: JourneyRequestPoint? = nil) -> some View {
        
        let hasValue = (point?.displayName.count ?? 0) > 0
        HStack {
            Button(action: {}) {
                Image(systemName: imageName)
                    .shadow(radius: 3)
            }
            Text(point?.displayName ?? promptText)
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
    
    private func getTimeToDisplay() -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        switch self.viewModel.journeyTime {
        case .now:
            return "Now"
        case .arriveAt(let date):
            return "Arrive by \(formatter.string(from: date)) \(getDayToDisplay(date))"
        case .leaveAt(let date):
            return "Leave at \(formatter.string(from: date)) \(getDayToDisplay(date))"
        }
    }
    
    private func getDayToDisplay(_ date: Date) -> String {
        let calendar = Calendar.current
        
        if calendar.isDateInToday(date) {
            return ""
        } else if calendar.isDateInTomorrow(date) {
            return "tomorrow"
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

private struct JourneyTimeSelectSheet: View {
    
    @Environment(JourneyPlannerViewModel.self) private var viewModel
    @State private var pickerMode: Int = 0
    @State private var selectedDate: Date = Date()
    
    public var body: some View {
        ZStack {
            Color.layer3.ignoresSafeArea()
            VStack {
                Spacer().frame(height: 16)
                Picker("", selection: $pickerMode) {
                    Text("Now").tag(0)
                    Text("Leave at").tag(1)
                    Text("Arrive by").tag(2)
                }
                .pickerStyle(.segmented)
                
                Spacer()
                
                if let maxDate = maxDate() {
                    DatePicker(selection: $selectedDate, in: Date()...maxDate) {
                        Text("Date")
                    }
                    .datePickerStyle(.wheel)
                } else {
                    DatePicker(selection: $selectedDate, in: Date()...) {
                        Text("Date")
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

private struct SearchLocView: View {
    
    private var type: JourneyStopSearchType
    private var onSelected: (_:JourneyRequestPoint) -> Void
    
    @Environment(JourneyPlannerViewModel.self) private var vm
    @State private var text: String = ""
    @FocusState private var isFocused: Bool
    let searchTextPublisher = PassthroughSubject<String, Never>()
    
    public init(type: JourneyStopSearchType, onSelection: @escaping (_:JourneyRequestPoint) -> Void) {
        self.type = type
        self.onSelected = onSelection
    }

    var body: some View {
        ZStack {
            Color.layer1.ignoresSafeArea()
            ScrollView {
                Spacer().frame(height: 8)
                Text(getTitle())
                    .font(.title3.bold())
                    .fontDesign(.rounded)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack {
                    TextField("", text: $text, prompt: Text("From:"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .focused($isFocused)
                    
                    if self.text.count > 0 {
                        Button(action: { self.text = "" }) {
                            Image(systemName: "xmark.circle.fill")
                        }
                        .tint(.primary)
                    }
                    
                }
                .padding(.horizontal, 8)
                .frame(maxWidth: .infinity, minHeight: 50)
                .background(Color.layer2)
                .clipShape(.rect(cornerRadius: 10))
                .shadow(radius: 3)
                
                CurrentLocationButton()
                
                LazyVStack {
                    ForEach(vm.searchResults, id: \.stopPoint.stopPointId) { stop in
                        MapSheetSearchResultItem(item: stop, isSelected: false)
                            .onTapGesture {
                                self.onSelected(JourneyRequestPoint(displayName: stop.stopPoint.stopPointName, coordinate: stop.stopPoint.stopPointCoordinate.coordinates))
                            }
                    }
                }
                
                Spacer()
            }
            .contentMargins(16)
        }
        .onAppear {
            self.isFocused = true
        }
        .onChange(of: self.text, { _, newValue in
            self.searchTextPublisher.send(newValue)
        })
        .onReceive(searchTextPublisher.debounce(for: .seconds(0.5), scheduler: DispatchQueue.main), perform: { val in
            Task {
                await self.vm.searchStops(val)
            }
        })
    }
    
    private func getTitle() -> LocalizedStringKey {
        switch type {
        case .from:
            return Strings.JourneyPage.ChooseStart
        case .to:
            return Strings.JourneyPage.ChooseEnd
        case .via:
            return Strings.JourneyPage.ChooseVia
        }
    }
    
    @ViewBuilder
    private func CurrentLocationButton() -> some View {
        HStack {
            Button(action: {}) {
                HStack {
                    Image(systemName: "location.fill")
                    Text("My Current Location")
                        .bold()
                        .fontDesign(.rounded)
                        .frame(maxWidth: .infinity, minHeight: 40, alignment: .leading)
                }
            }
            .buttonStyle(.borderedProminent)
        }
        
    }
}


#Preview {
    NavigationStack {
        JourneyPlannerPage()
            .environment(GlobalViewModel())
    }
}
