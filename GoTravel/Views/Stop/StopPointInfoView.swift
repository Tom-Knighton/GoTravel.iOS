//
//  StopPointInfoView.swift
//  GoTravel
//
//  Created by Tom Knighton on 21/01/2024.
//

import SwiftUI
import GoTravel_Models
import CoreLocation

public struct StopPointInfoView: View {
    
    @State private var addressString: String?
    
    private var info: StopPointInfo
    private var coordinates: CLLocationCoordinate2D?
    private var hideAccessible: Bool

    public init(info: StopPointInfo, coords: CLLocationCoordinate2D? = nil, hideAccessible: Bool = false) {
        self.info = info
        self.coordinates = coords
        self.hideAccessible = hideAccessible
    }
    
    public var body: some View {
        VStack(alignment: .leading) {
            Text("Information:")
                .font(.title3.bold())
                .fontDesign(.rounded)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack {
                InfoCard {
                    Text("Wi-Fi")
                        .bold()
                        .fontDesign(.rounded)
                    
                    Image(systemName: info.hasWifi ? "checkmark" : "xmark")
                        .bold()
                        .foregroundStyle(info.hasWifi ? .green : .red)
                }     
                
                if !hideAccessible {
                    InfoCard {
                        Text("Accessible")
                            .bold()
                            .fontDesign(.rounded)
                        
                        Image(systemName: info.hasWifi ? "checkmark" : "xmark")
                            .bold()
                            .foregroundStyle(info.hasWifi ? .green : .red)
                    }
                }
                
                if let address = self.addressString {
                    InfoCard {
                        Text("Address")
                            .bold()
                            .fontDesign(.rounded)
                        
                        Text(address)
                            .fontDesign(.rounded)
                    }
                }
            }
            
            if info.toiletsInfo.count > 0 {
                InfoCard {
                    HStack {
                        Grid(alignment: .leading, horizontalSpacing: 12) {
                            GridRow {
                                Text("Toilets")
                                    .fontDesign(.rounded)
                                    .bold()
                                Text("Free")
                                    .fontDesign(.rounded)
                                    .bold()
                                Image(systemName: "figure.roll")
                                    .fontDesign(.rounded)
                                    .bold()
                                Image(systemName: "figure.and.child.holdinghands")
                                    .fontDesign(.rounded)
                                    .bold()
                                Image(systemName: "info")
                                    .fontDesign(.rounded)
                                    .bold()
                            }
                            Divider()
                            ForEach(info.toiletsInfo, id: \.type) { toilet in
                                GridRow {
                                    Text(toilet.type)
                                        .fontDesign(.rounded)
                                        .bold()
                                    
                                    Image(systemName: toilet.free ? "checkmark" : "xmark")
                                        .foregroundStyle(toilet.free ? .green : .red)
                                        .bold()
                                    
                                    Image(systemName: toilet.accessible ? "checkmark" : "xmark")
                                        .foregroundStyle(toilet.accessible ? .green : .red)
                                        .bold()
                                    
                                    Image(systemName: toilet.hasBabyGate ? "checkmark" : "xmark")
                                        .foregroundStyle(toilet.hasBabyGate ? .green : .red)
                                        .bold()
                                    
                                    if let info = toilet.info, info.count >= 2 {
                                        Button(action: {}) {
                                            Image(systemName: "info.circle")
                                        }
                                    }
                                }
                            }
                        }
                        Spacer()
                    }
                }
            }
        }
        .onChange(of: self.coordinates, initial: true, { _, val in
            if let val {
                Task.detached {
                    let reversed = try? await CLGeocoder().reverseGeocodeLocation(.init(latitude: val.latitude, longitude: val.longitude))
                    if let reversed, let placemark = reversed.first {
                        
                        var address = ""
                        if let building = placemark.subThoroughfare {
                            address += building + " "
                        }
                        if let street = placemark.thoroughfare {
                            address += street + ", "
                        }
                        if let postcode = placemark.postalCode {
                            address += postcode
                        }
                                     
                        await MainActor.run { [address] in
                            self.addressString = address
                        }
                    }
                }
            }
        })
    }
    
    @ViewBuilder
    private func InfoCard<Content: View>(@ViewBuilder content: @escaping () -> Content) -> some View {
        VStack(spacing: 4) {
            content()
        }
        .padding(8)
        .background(Color.layer2)
        .clipShape(.rect(cornerRadius: 10))
        .shadow(radius: 3)
    }
}

#Preview {
    
    StopPointInfoView(info: StopPointInfo(hasWifi: true, toiletsInfo: [.init(type: "Men", free: true, accessible: true, hasBabyGate: true, info: "Y"), .init(type: "Women", free: true, accessible: true, hasBabyGate: true, info: "Y"), .init(type: "Unisex", free: true, accessible: true, hasBabyGate: true, info: "Yes")], accessibleInfo: nil, addressInfo: nil))
        .padding(.horizontal, 16)
}
