//
//  SavedJourneyData.swift
//  GoTravel
//
//  Created by Tom Knighton on 21/03/2024.
//

import Foundation
import GoTravel_CoreData
import SwiftData

#if DEBUG
public struct PreviewSavedJourneyData {
    
    public static let timeAgo = Calendar.current.date(byAdding: .minute, value: -55, to: Date())
    public static let savedJourneys: [SavedJourney] = [
        .init(name: "Test", startedAt: timeAgo!, endedAt: Date(), coordinates: [.init(.init(latitude: 51.52751593393153, longitude: -0.020685195922851566)), .init(.init(latitude: 51.5278596860883, longitude: -0.020941346883773804)), .init(.init(latitude: 51.5282034356497, longitude: -0.02119749784469605)), .init(.init(latitude: 51.528597642153606, longitude: -0.021517165908025996)), .init(.init(latitude: 51.52899184524432, longitude: -0.021836833971355944)), .init(.init(latitude: 51.52918535091636, longitude: -0.022007528707821414)), .init(.init(latitude: 51.529378855765906, longitude: -0.022178223444286885)), .init(.init(latitude: 51.5296030371852, longitude: -0.022136498064265767)), .init(.init(latitude: 51.52982721750058, longitude: -0.022094772684244653)), .init(.init(latitude: 51.53013634854592, longitude: -0.021795108591334822)), .init(.init(latitude: 51.5304454774922, longitude: -0.021495444498424998)), .init(.init(latitude: 51.530754604339414, longitude: -0.020865770581667276)), .init(.init(latitude: 51.531063729087585, longitude: -0.020236096664909557)), .init(.init(latitude: 51.53126902451618, longitude: -0.019731598888235172)), .init(.init(latitude: 51.531474319018976, longitude: -0.01922710111156079)), .init(.init(latitude: 51.531949204450584, longitude: -0.01821162616699912)), .init(.init(latitude: 51.53242408492836, longitude: -0.01719615122243745)), .init(.init(latitude: 51.532488979402466, longitude: -0.017057381350222837)), .init(.init(latitude: 51.532788653840754, longitude: -0.01602941971503902)), .init(.init(latitude: 51.533088326306235, longitude: -0.015001458079855205)), .init(.init(latitude: 51.53340687361434, longitude: -0.01429971305214828)), .init(.init(latitude: 51.5337254186933, longitude: -0.013597968024441355)), .init(.init(latitude: 51.53420205235203, longitude: -0.012892429780373417)), .init(.init(latitude: 51.53467868101998, longitude: -0.01218689153630548)), .init(.init(latitude: 51.53497598152302, longitude: -0.011849295279725556)), .init(.init(latitude: 51.53527328008429, longitude: -0.01151169902314564)), .init(.init(latitude: 51.53578764919941, longitude: -0.01079098791361366)), .init(.init(latitude: 51.53630201250186, longitude: -0.01007027680408168)), .init(.init(latitude: 51.53681401056689, longitude: -0.009414050372766882)), .init(.init(latitude: 51.53732600287256, longitude: -0.008757823941452083)), .init(.init(latitude: 51.537964908709014, longitude: -0.008010265668384694)), .init(.init(latitude: 51.53860380557674, longitude: -0.007262707395317304)), .init(.init(latitude: 51.53902473792946, longitude: -0.006770178565682628)), .init(.init(latitude: 51.539581308540875, longitude: -0.00586840160430689)), .init(.init(latitude: 51.54013787234583, longitude: -0.004966624642931153)), .init(.init(latitude: 51.54069442934429, longitude: -0.004064847681555414)), .init(.init(latitude: 51.5408508074007, longitude: -0.003811469800214518))
], lines: []),
        .init(name: "Test 2", startedAt: timeAgo!, endedAt: Date(), coordinates: [], lines: []),
        .init(name: "Test 3", startedAt: timeAgo!, endedAt: timeAgo!, coordinates: [], lines: [])
    ]
    
    public static func container() -> ModelContainer {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: SavedJourney.self, configurations: config)
        
        return container
    }
}
#endif
