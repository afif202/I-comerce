//
//  HomeViewModel.swift
//  I-Commerce
//
//  Created by macbook on 01/03/21.
//

import SwiftUI
import CoreLocation

class HomeViewModel: NSObject,ObservableObject,CLLocationManagerDelegate {
   @Published var locationManager = CLLocationManager()
   @Published var search = ""
   
   @Published var userLocation: CLLocation!
   @Published var userAddress = ""
   @Published var noLocation = false
   
   @Published var showMenu = false
   
   func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
      switch manager.authorizationStatus {
      case .authorizedWhenInUse:
         print("authorized")
         self.noLocation = false
         manager.requestLocation()
      case .denied:
         print("denied")
         self.noLocation = true
      default:
         print("unknown")
         self.noLocation = false
         locationManager.requestWhenInUseAuthorization()
         
      }
   }
   
   func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
      print(error.localizedDescription)
   }
   
   func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
      self.userLocation = locations.last
      self.extractLocation()
   }
   
   func extractLocation() {
      CLGeocoder().reverseGeocodeLocation(self.userLocation) { (res, err) in
         guard let safeData = res else {return}
         
         var address = ""
         
         address += safeData.first?.name ?? ""  //nil colascing
         address += ", "
         address += safeData.first?.locality ?? ""
         
         self.userAddress = address
      }
   }
   
   
}

// class NSObject = kelas yang mendeklarasikan sebagai objective - c
//NSObject = sebuah kelas turunan,yang mana NSObject berasal dari bahasa objective-c

//CLLocationManagerDelegate = Delegasi dari library CoreLocation
//CorelocationManager = meng update lokasi terkini
//CoreLocation = membaca latitude longitude sebuah daerah/lokasi
//CLGeocoder = yang mengubah sebuah alamat menjadi latitude longitude
