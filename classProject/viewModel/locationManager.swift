import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    static let shared = LocationManager()

    private let manager = CLLocationManager()

    private var completion: ((CLLocation?, String?) -> Void)?

    override private init() {
        super.init()
        manager.delegate = self
    }

    func requestLocation(completion: @escaping (CLLocation?, String?) -> Void) {
        self.completion = completion

        let status = manager.authorizationStatus
        if status == .notDetermined {
            manager.requestWhenInUseAuthorization()
        } else if status == .denied || status == .restricted {
            print("Location permission denied")
            completion(nil, nil)
            return
        }

        manager.requestLocation()
    }

    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        let loc = locations.last
        print("location:", loc?.coordinate.latitude as Any, loc?.coordinate.longitude as Any)
        completion?(loc, nil)    // for now no reverse-geocode name
        completion = nil
    }

    func locationManager(_ manager: CLLocationManager,
                         didFailWithError error: Error) {
        print("Location error:", error.localizedDescription)
        completion?(nil, nil)
        completion = nil
    }
}

