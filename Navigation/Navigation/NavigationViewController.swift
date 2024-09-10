//
//  NavigationViewController.swift
//  Navigation
//
//  Created by Sergey on 23.08.2024.
//

import UIKit
import MapKit


final class NavigationViewController: UIViewController {
    
    private let latitudinalMeters: CLLocationDistance = 2000
    private let longitudinalMeters: CLLocationDistance = 2000
    private let locationService = LocationService()
    
    //MARK: - let mapView
    private lazy var  mapView: MKMapView = {
        let mapView = MKMapView()

        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.showsUserLocation = true
        mapView.showsScale = true
        mapView.showsCompass = true
                
        if #available(iOS 16.0, *) {
            mapView.preferredConfiguration = MKHybridMapConfiguration(elevationStyle: .flat)
        }
        mapView.delegate = self
        return mapView
    }()
    
    //MARK: - init
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - override
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        longPressForAddAnnotation()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getLocation()
    }
}
//MARK: - private extension
private extension NavigationViewController {
    func longPressForAddAnnotation() {
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressAction))
        longPress.minimumPressDuration = 0.5
        longPress.delaysTouchesBegan = true
        mapView.addGestureRecognizer(longPress)
    }
    func getLocation() {
        locationService.getLocation { location in
            DispatchQueue.main.async { [weak self] in
                guard let self, let coordinate = location?.coordinate else { return }
                let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: self.latitudinalMeters, longitudinalMeters: self.longitudinalMeters)
                self.mapView.setCenter(coordinate, animated: true)
                self.mapView.setRegion(region, animated: true)
            }
        }
    }
    func setPin(_ location: CLLocation) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = location.coordinate
        locationService.getNameFor(location: location) { title in
            annotation.title = title
        }
        mapView.addAnnotation(annotation)
    }
    func removeAllAnnotations(){
        mapView.removeAnnotations(mapView.annotations)
    }
    
    func setupView() {
        
        let button1 = UIBarButtonItem(image: UIImage(systemName: "location.fill"),
                                      style: .plain,
                                      target: self,
                                      action: #selector(locationAction))

        let button2 = UIBarButtonItem(image: UIImage(systemName: "mappin.slash"),
                                      style: .plain,
                                      target: self,
                                      action: #selector(removeAction))
        self.navigationItem.rightBarButtonItems = [button2, button1]

        view.addSubview(mapView)

        NSLayoutConstraint.activate([
            
            mapView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    @objc func locationAction() {
        getLocation()
    }
    
    @objc func removeAction() {
        removeAllAnnotations()
    }
    
    @objc func longPressAction(gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state != UIGestureRecognizer.State.ended {
            let touchLocation = gestureRecognizer.location(in: mapView)
            let mapCoordinate = mapView.convert(touchLocation, toCoordinateFrom: mapView)
            let mapLocation = CLLocation(latitude: mapCoordinate.latitude, longitude: mapCoordinate.longitude)
            setPin(mapLocation)
        }
    }
}


//MARK: - extension MKMapViewDelegate
extension NavigationViewController: MKMapViewDelegate {
    //Настройка линии маршрута
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let render = MKPolylineRenderer(overlay: overlay)
        render.strokeColor = .blue
        render.lineWidth = 10
        return render
    }
    
    //Добавление аннотаций
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation { return nil }
        var viewMarker: MKMarkerAnnotationView
        let idView = "marker"
        if let view = mapView.dequeueReusableAnnotationView(withIdentifier: idView) as? MKMarkerAnnotationView {
            view.annotation = annotation
            viewMarker = view
        } else {
            viewMarker = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: idView)
            viewMarker.canShowCallout = true
            viewMarker.rightCalloutAccessoryView = UIButton(type: .contactAdd)
        }
        return viewMarker
    }
    
    //Построение маршрута
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let userCoordinate = mapView.userLocation.coordinate
        guard let annotationCoordinate = view.annotation?.coordinate else { return }
        mapView.removeOverlays(mapView.overlays)
        let startPoint = MKPlacemark(coordinate: userCoordinate)
        let endPoint = MKPlacemark(coordinate: annotationCoordinate)
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: startPoint)
        request.destination = MKMapItem(placemark: endPoint)
        request.transportType = .automobile
        
        let direction = MKDirections(request: request)
        direction.calculate { response, error in
            guard let response else { return }
            for route in response.routes {
                mapView.addOverlay(route.polyline)
            }
        }
    }
}
