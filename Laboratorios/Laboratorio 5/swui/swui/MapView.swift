//
//  MapView.swift
//  swui
//
//  Created by Andrey Leal on 4/9/21.
//

import SwiftUI
import MapKit

struct MapView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 8.540_800, longitude: -83.571_000),
        span: MKCoordinateSpan(latitudeDelta: 0.2 , longitudeDelta: 0.2)
    )
    var body: some View {
        Map(coordinateRegion: $region)
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
