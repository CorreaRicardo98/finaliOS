//
//  MapaViewController.swift
//  FinalProject
//
//  Created by Mac17 on 01/07/21.
//

import UIKit
import MapKit
import CoreLocation

class MapaViewController: UIViewController,CLLocationManagerDelegate {

    @IBOutlet weak var mapa: MKMapView!
    
    var manaer = CLLocationManager()
    
    var latitude:CLLocationDegrees?
    var longitude:CLLocationDegrees?
    
    var ubicacion:String!
    var nombre:String!
    override func viewDidLoad() {
        super.viewDidLoad()
        manaer.delegate = self
        
        manaer.requestWhenInUseAuthorization()
        manaer.requestLocation()
        
        manaer.desiredAccuracy = kCLLocationAccuracyBest
        manaer.startUpdatingLocation()
        // Do any additional setup after loading the view.
        
        let geocode = CLGeocoder()
        
        if let ubi = ubicacion{
            geocode.geocodeAddressString(ubi) { (lugares:[CLPlacemark]?, error:Error?) in
                if(error == nil){
                    let lugar = lugares?.first
                    let anotacion = MKPointAnnotation()
                    anotacion.coordinate = (lugar?.location?.coordinate)!
                    anotacion.title = self.nombre
                    
                    let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                    
                    let region = MKCoordinateRegion(center: anotacion.coordinate, span: span)
                    
                    self.mapa.setRegion(region, animated: true)
                    self.mapa.addAnnotation(anotacion)
                    self.mapa.selectAnnotation(anotacion, animated: true)
                }else{
                    print("error con a ubicación: \(error?.localizedDescription)")
                }
            }
        }
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let ubicacion = locations.first{
            print(ubicacion
            )
            latitude = ubicacion.coordinate.latitude
            longitude = ubicacion.coordinate.longitude
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error: \(error.localizedDescription)")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
