//
//  LineSearchView.swift
//  GoTravel
//
//  Created by Tom Knighton on 28/03/2024.
//

import Foundation
import SwiftUI
import GoTravel_API
import GoTravel_Models
import Combine

public struct LineSearchView: View {
    
    @State private var searchText: String = ""
    @State private var loading: Bool = false
    @State private var lines: [Line] = []
    let searchTextPublisher = PassthroughSubject<String, Never>()
    
    @Binding private var selectedLines: [Line]
    
    public init (selectedLines: Binding<[Line]>) {
        self._selectedLines = selectedLines
    }
    
    public var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    if searchText.isEmpty {
                        ContentUnavailableView(Strings.Community.Relationships.SearchUsers, systemImage: Icons.magnifyingGlass, description: Text(Strings.Community.Relationships.SearchUsersDesc))
                    }
                    
                    if searchText.count >= 1 {
                        if loading {
                            ProgressView()
                        } else {
                            if lines.isEmpty {
                                ContentUnavailableView(Strings.Misc.NoResults, systemImage: Icons.cross, description: Text(Strings.Misc.NoResultsDesc))
                            } else {
                                ForEach(lines, id: \.lineId) { line in
                                    Button(action: { self.toggleLine(line) }) {
                                        HStack {
                                            Text(line.lineName)
                                                .shadow(radius: 3)
                                            
                                            if selectedLines.contains(where: { $0.lineId == line.lineId }) {
                                                Image(systemName: Icons.checkCircleFill)
                                            }
                                        }
                                        .padding(.vertical, 8)
                                        .padding(.horizontal)
                                        .background(Color(hex: line.linePrimaryColour ?? "") ?? Color.layer2)
                                        .clipShape(.rect(cornerRadius: 10))
                                    }
                                    .tint(.white)
                                }
                                Spacer()
                            }
                        }
                    }
                    
                }
            }
            .contentMargins(.horizontal, 16, for: .scrollContent)
            .navigationTitle(Strings.Community.Journey.SearchLines)
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: Strings.Community.Relationships.SearchUsersPrompt)
            .onChange(of: self.searchText, { _, newValue in
                self.searchTextPublisher.send(newValue)
            })
            .onReceive(searchTextPublisher.debounce(for: .seconds(0.5), scheduler: DispatchQueue.main), perform: { val in
                let trimmed = val.trimmingCharacters(in: .whitespacesAndNewlines)
                if trimmed.count >= 1 {
                    Task {
                        await searchLines(with: val)
                    }
                }
                
            })
        }
        
    }
    
    private func searchLines(with query: String) async {
        self.loading = true
        defer { self.loading = false }
        
        do {
            let lines = try await LineModeService.SearchLines(query: query, maxResults: 50)
            self.lines = lines
        } catch {
            self.lines = []
        }
    }
    
    private func toggleLine(_ line: Line) {
        if let index = self.selectedLines.firstIndex(where: { $0.lineId == line.lineId }) {
            self.selectedLines.remove(at: index)
        } else {
            self.selectedLines.append(line)
        }
    }
}
