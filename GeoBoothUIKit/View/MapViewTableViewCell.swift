//
//  MapViewTableViewCell.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 2/14/24.
//

import UIKit
import MapKit

class MapViewTableViewCell: UITableViewCell {
    static let identifier = "MapViewTableViewCell"
    
    @IBOutlet weak var mapView: MKMapView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setupLocationManager()
        self.mapView.showsUserLocation = true
        self.mapView.userTrackingMode = .follow
        self.mapView.layer.cornerRadius = 16
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    static func nib() -> UINib {
        .init(nibName: identifier, bundle: nil)
    }
    fileprivate func setupLocationManager() {
        LocationServices.shared.locationManager.requestWhenInUseAuthorization()
    }
    
}
