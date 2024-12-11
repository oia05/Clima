//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation


class WeatherViewController: UIViewController {
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temparatureLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var contentStackView: UIStackView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var weatherManager = WeatherManager()
    private var locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
        weatherManager.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    @IBAction func locationButtonPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    
}

// MARK: - UITextFieldDelegate
extension WeatherViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
        
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        let text = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let isEmpty = text?.isEmpty ?? true
        if isEmpty {
            textField.text = ""
            textField.placeholder = "Enter a city"
        }
        return !isEmpty
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let cityName = textField.text {
            weatherManager.fetchWeather(cityName: cityName)
        }
        textField.placeholder = "Search by city"
        textField.text = ""
    }
}

// MARK: - WeatherManagerDelegate
extension WeatherViewController: WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.contentStackView.isHidden = false
            self.activityIndicator.isHidden = true
            let temp = String(format: "%.1f", weather.temperature)
            let tempDegree = "\(temp)°"
            self.temparatureLabel.text = tempDegree
            self.cityLabel.text = weather.name
            self.conditionImageView.image = UIImage(systemName: weather.condition.rawValue)
        }
    }
    
    func didFailWithError(_ weatherManager: WeatherManager, error: Error) {
        DispatchQueue.main.async {
            self.activityIndicator.isHidden = true
            print(error)
        }
    }
    
    func didStartFetching(_ weatherManager: WeatherManager) {
        DispatchQueue.main.async {
            self.activityIndicator.isHidden = false
        }
    }
    
}

// MARK: - Location Manager Delegate
extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        manager.stopUpdatingLocation()
        let lat = location.coordinate.latitude
        let lon = location.coordinate.longitude
        weatherManager.fetchWeather(latitude: lat, longtitude: lon)
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("Error while getting the location: \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
}
