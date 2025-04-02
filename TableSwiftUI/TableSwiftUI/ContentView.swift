//
//  ContentView.swift
//  TableSwiftUI
//
//  Created by Noah Trevino on 3/31/25.
//

import SwiftUI
import MapKit

let data = [
    Item(name: "A Bronx Tale", year: "1993", desc: "A coming-of-age crime drama about a boy caught between his father and a mob boss.", lat: 40.7704, long: -73.9301, imageName: "bronxtale"),
    Item(name: "Selena", year: "1997", desc: "A biographical drama telling the inspiring yet tragic story of beloved singer Selena Quintanilla.", lat: 29.4252, long: -98.4946, imageName: "selena"),
    Item(name: "Halloween 4: The Return of Michael Myers", year: "1988", desc: "Ten years after the original films, Michael Myers escapes and returns to hunt Jamie Lloyd.", lat: 40.7606, long: -111.8881, imageName: "halloween4"),
    Item(name: "Poetic Justice", year: "1993", desc: "A romantic drama about Justice, a woman who falls in love with a mailman named Lucky after losing her boyfriend.", lat: 37.8044, long: -122.2712, imageName: "poeticjustice"),
    Item(name: "The Terminator", year: "1984", desc: "A cyborg assassin is sent from the future to kill Sarah Connor, whose son will lead humanity.", lat: 34.0549, long: -118.2426, imageName: "terminator")
]
    struct Item: Identifiable {
        let id = UUID()
        let name: String
        let year: String
        let desc: String
        let lat: Double
        let long: Double
        let imageName: String
    }

struct ContentView: View {
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 38.7946, longitude: -106.5348), span: MKCoordinateSpan(latitudeDelta: 18, longitudeDelta: 18))

    var body: some View {
        NavigationView {
            VStack {
                List(data, id: \.name) { item in
                    
                    NavigationLink(destination: DetailView(item: item)) {

                    
                    HStack {
                        Image(item.imageName)
                            .resizable()
                            .frame(width: 50, height: 50)
                            .cornerRadius(10)
                    VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.year)
                                .font(.subheadline)
                        } // end internal VStack
                    } // end HStack
                    } // end NavigationLink
                } // end List
                Map(coordinateRegion: $region, annotationItems: data) { item in
                                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)) {
                                    Image(systemName: "mappin.circle.fill")
                                        .foregroundColor(.red)
                                        .font(.title)
                                        .overlay(
                                            Text(item.name)
                                                .font(.subheadline)
                                                .foregroundColor(.black)
                                                .fixedSize(horizontal: true, vertical: false)
                                                .offset(y: 25)
                                        )
                                }
                            } // end map
                            .frame(height: 300)
                            .padding(.bottom, -30)
    
                            
                                
                
                
                
            } // end VStack
            .listStyle(PlainListStyle())
                    .navigationTitle("VHS Movie Vault")
                } // end NavigationView
        } // end body
}


struct DetailView: View {
    @State private var region: MKCoordinateRegion
          
          init(item: Item) {
              self.item = item
              _region = State(initialValue: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long), span: MKCoordinateSpan(latitudeDelta: 0.20, longitudeDelta: 0.20)))
          }
    
    
        let item: Item
                
        var body: some View {
            VStack {
                Image(item.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 200)
                Text("Year movie came out: \(item.year)")
                    .font(.subheadline)
                Text("Description: \(item.desc)")
                    .font(.subheadline)
                    .padding(10)
                Map(coordinateRegion: $region, annotationItems: [item]) { item in
                        MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)) {
                            Image(systemName: "mappin.circle.fill")
                                .foregroundColor(.red)
                                .font(.title)
                                .overlay(
                                    Text(item.name)
                                        .font(.subheadline)
                                        .foregroundColor(.black)
                                        .fixedSize(horizontal: true, vertical: false)
                                        .offset(y: 25)
                                )
                        }
                    } // end Map
                        .frame(height: 300)
                        .padding(.bottom, -30)
                      
                          
                    } // end VStack
                     .navigationTitle(item.name)
                     Spacer()
         } // end body
      } // end DetailView
    


#Preview {
    ContentView()
}
