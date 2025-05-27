//
//  MapView.swift
//  Frameworks
//
//  Created by Paul Vayssier on 27/11/2024.
//


import SwiftUI
import MapKit

public struct MapView: View {
    @State private var route: MKRoute?
    @State private var selectedResult: MKMapItem?
    public init() {
        fetchRoute()
    }

    let position = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 44.86628262919928, longitude: -0.5764049734393997),
            span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        )
    )

    let location = CLLocationCoordinate2D(latitude: 44.86628262919928, longitude: -0.5764049734393997)

    let direction = CLLocationCoordinate2D(latitude: 44.865211486816406, longitude: -0.604365885257721)

    func fetchRoute() {
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: location))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: direction))
        request.requestsAlternateRoutes = false
        request.transportType = .walking
        Task {
            let directions = MKDirections(request: request)
            let response = try? await directions.calculate()
            route = response?.routes.first
        }
    }

    private var travelTime: String? {
        // Check if there is a route to get the info from
        guard let route else { return nil }

        // Set up a date formater
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .abbreviated
        formatter.allowedUnits = [.hour, .minute]

        // Format the travel time to the format you want to display it
        return formatter.string(from: route.expectedTravelTime)
    }

    public var body: some View {
          ZStack(alignment: .top) {
              MapReader { proxy in
                  Map(initialPosition: position) {
                      if let route {
                          MapPolyline(route.polyline)
                              .stroke(.blue, style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
                      }
                      Marker("Location", coordinate: location)
                      Marker(travelTime ?? "direction", coordinate: direction)
                  }
              }
              .edgesIgnoringSafeArea(.all)
              LayoutView()
                  .safeAreaPadding(.top)
              ItinerarySheetView()
          }
          .onAppear {
              fetchRoute()
          }
      }
}

#Preview {
    MapView()
}
