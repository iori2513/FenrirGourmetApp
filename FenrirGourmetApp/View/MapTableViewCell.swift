//
//  MapTableViewCell.swift
//  FenrirGourmetApp
//
//  Created by 中田伊織 on 2022/07/26.
//

import UIKit
import MapKit

class MapTableViewCell: UITableViewCell {
    
    static let identifier = "MapTableViewCell"

    private lazy var mapView: MKMapView = {
            let map = MKMapView()
            map.translatesAutoresizingMaskIntoConstraints = false
            return map
    }()
    
    
    public func setupMap(latitude: Double, longitude: Double) {
            // map center
            let lat = CLLocationDegrees(latitude)
            let long = CLLocationDegrees(longitude)
            let loc: CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat, long)
            mapView.setCenter(loc ,animated:true)

            // map region
            var region: MKCoordinateRegion = mapView.region
            region.center = loc
            region.span.latitudeDelta = 0.01
            region.span.longitudeDelta = 0.01
            mapView.setRegion(region,animated:true)
        
            // anotation
            mapView.removeAnnotations(mapView.annotations)
            let annotation = MKPointAnnotation()
            annotation.coordinate = loc
            mapView.addAnnotation(annotation)
            mapView.showAnnotations(mapView.annotations, animated: true)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(mapView)
        [mapView.topAnchor.constraint(equalTo: contentView.topAnchor),
         mapView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
         mapView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
         mapView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),]
            .forEach { $0.isActive = true }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
            

    
    
    

}

extension MapTableViewCell: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "annotation"
        if let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) {
            annotationView.annotation = annotation
            return annotationView
        } else {
            let annotationView = MKAnnotationView(
                annotation: annotation,
                reuseIdentifier: identifier
            )
            annotationView.image = UIImage(named: "annotation")
            return annotationView
        }
    }
}
