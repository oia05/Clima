//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation
import Combine
import Factory


class WeatherViewController: UIViewController {
    @Injected(\.weatherViewModel)
    private var weatherViewModel: WeatherViewModel
    @Injected(\.locationManager)
    private var locationManager: CLLocationManager
    private var cancellables = Set<AnyCancellable>()
    private lazy var weatherView = WeatherView(frame: UIScreen.main.bounds)
    var coordinator: MainCoordinator?

    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = weatherView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        weatherView.searchTextField.delegate = self
        handleState()
        handleEffect()
        setClickListeners()
        locationManager.requestWhenInUseAuthorization()
        navigationController?.isNavigationBarHidden = true
    }
    
    
    @objc func locationButtonPressed() {
        locationManager.requestLocation()
    }
    
    @objc func searchPressed() {
        weatherView.searchTextField.endEditing(true)
    }
    
    private func setClickListeners() {
        weatherView.locationButton.addTarget(self, action: #selector(locationButtonPressed) , for: .touchUpInside)
        weatherView.searchButton.addTarget(self, action: #selector(searchPressed) , for: .touchUpInside)
    }
    
    private func handleState() {
        weatherViewModel.uiState.sink { [weak self] newState in
            self?.handleState(newState)
        }.store(in: &cancellables)
    }
    
    private func handleEffect() {
        weatherViewModel.effect.sink { [weak self] errorMessage in
            self?.handleEffect(errorMessage: errorMessage)
        }.store(in: &cancellables)
    }
    
    private func handleState(_ uiState: UiState) {
        weatherView.uiActivityIndicatorView.isHidden = !uiState.isLoading
        if uiState.isLoading {
            weatherView.uiActivityIndicatorView.startAnimating()
        } else {
            weatherView.uiActivityIndicatorView.stopAnimating()
        }
        weatherView.contentStackView.isHidden = uiState.isLoading
        if let weatherModel = uiState.weatherModel {
            let temp = String(format: "%.1f", weatherModel.temperature)
            let tempDegree = "\(temp)°"
            weatherView.temperatureLabel.text = tempDegree
            weatherView.cityLabel.text = weatherModel.name
            weatherView.conditionImageView.image = UIImage(systemName: weatherModel.condition.rawValue)
        }
    }
    
    private func handleEffect(errorMessage: String?) {
        if errorMessage != nil {
            let alert = UIAlertController(title: "Error", message: "Error loading weather", preferredStyle: .alert)
            alert.title = "Error"
            alert.addAction(UIAlertAction(title: "Ok", style: .default) { action in
            })
            present(alert, animated: true)
            print("Error loading weather: \(errorMessage!))")
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
        weatherViewModel.fetchWeather(latitude: lat, longtitude: lon)
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
            weatherViewModel.fetchWeather(cityName: cityName)
        }
        textField.placeholder = "Search by city"
        textField.text = ""
    }
}
