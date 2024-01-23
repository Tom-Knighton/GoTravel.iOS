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
    
    @State private var showToiletInfoAlert: Bool = false
    @State private var toiletInfoString: String?
    
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
            Text(Strings.StopPage.Information)
                .font(.title3.bold())
                .fontDesign(.rounded)
                .frame(maxWidth: .infinity, alignment: .leading)
                .accessibilityAddTraits(.isHeader)
                .accessibilityHint(Strings.StopPage.Accessibility.InfoLabel)
            
            HStack {
                InfoCard {
                    Text(Strings.StopPage.WiFi)
                        .bold()
                        .fontDesign(.rounded)
                    
                    Image(systemName: info.hasWifi ? Icons.check : Icons.cross)
                        .bold()
                        .foregroundStyle(info.hasWifi ? .green : .red)
                }     
                .accessibilityElement(children: .ignore)
                .accessibilityElement()
                .accessibilityLabel(info.hasWifi ? Strings.StopPage.Accessibility.HasWifiLabel : Strings.StopPage.Accessibility.NoWifiLabel)
                
                if !hideAccessible {
                    let viaLift = info.accessibleInfo?.viaLift ?? false
                    InfoCard {
                        Text(Strings.StopPage.Accessible)
                            .bold()
                            .fontDesign(.rounded)
                        
                        Image(systemName: viaLift ? Icons.check : Icons.cross)
                            .bold()
                            .foregroundStyle(viaLift ? .green : .red)
                    }
                    .accessibilityElement(children: .ignore)
                    .accessibilityElement()
                    .accessibilityLabel(viaLift ? Strings.StopPage.Accessibility.ViaLiftLabel : Strings.StopPage.Accessibility.NoViaLiftLabel)
                }
                
                if let address = self.addressString {
                    InfoCard {
                        Text(Strings.StopPage.Address)
                            .bold()
                            .fontDesign(.rounded)
                        
                        Text(address)
                            .fontDesign(.rounded)
                            .accessibilityHidden()
                    }
                    .accessibilityElement(children: .ignore)
                    .accessibilityElement()
                    .accessibilityLabel(Strings.StopPage.Address.toString() + ": " + address)
                }
            }
            
            if info.toiletsInfo.count > 0 {
                InfoCard {
                    HStack {
                        Grid(alignment: .leading, horizontalSpacing: 12) {
                            GridRow {
                                Text(Strings.StopPage.Toilets)
                                    .fontDesign(.rounded)
                                    .bold()
                                Text(Strings.StopPage.Free)
                                    .fontDesign(.rounded)
                                    .bold()
                                Image(systemName: Icons.accessible)
                                    .fontDesign(.rounded)
                                    .bold()
                                Image(systemName: Icons.family)
                                    .fontDesign(.rounded)
                                    .bold()
                                Image(systemName: Icons.info)
                                    .fontDesign(.rounded)
                                    .bold()
                            }
                            .accessibilityHidden()
                            
                            Divider()
                            ForEach(info.toiletsInfo, id: \.type) { toilet in
                                GridRow {
                                    Text(toilet.type)
                                        .fontDesign(.rounded)
                                        .bold()
                                    
                                    Image(systemName: toilet.free ? Icons.check : Icons.cross)
                                        .foregroundStyle(toilet.free ? .green : .red)
                                        .bold()
                                        .accessibilityHidden()
                                    
                                    Image(systemName: toilet.accessible ? Icons.check : Icons.cross)
                                        .foregroundStyle(toilet.accessible ? .green : .red)
                                        .bold()
                                        .accessibilityHidden()

                                    Image(systemName: toilet.hasBabyGate ? Icons.check : Icons.cross)
                                        .foregroundStyle(toilet.hasBabyGate ? .green : .red)
                                        .bold()
                                        .accessibilityHidden()

                                    if let info = toilet.info, info.count >= 2 {
                                        Button(action: {
                                            self.toiletInfoString = info
                                            self.showToiletInfoAlert = true
                                        }) {
                                            Image(systemName: Icons.info_circle)
                                                .resizable()
                                                .frame(width: 25, height: 25)
                                        }
                                        .accessibilityHidden()
                                    }
                                }
                                .accessibilityLabel(Strings.Accessibility.ToiletInfoRowLabel(toilet))
                                .accessibilityHint(toilet.info ?? "")
                                .frame(minHeight: 30)
                            }
                        }
                        Spacer()
                    }
                }
            }
        }
        .alert(Strings.StopPage.StopToiletInfoAlertTitle, isPresented: $showToiletInfoAlert, presenting: toiletInfoString, actions: { _ in
            Button(Strings.Misc.Ok, action: {})
        }, message: { info in
            Text(info)
        })
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
