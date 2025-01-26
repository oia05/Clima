//
//  WeatherView.swift
//  Clima
//
//  Created by Omar Assidi on 26/01/2025.
//  Copyright © 2025 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherView: UIView {
    lazy var backgroundImageView: UIImageView = {
        let uiImageView = UIImageView(image: .Common.background)
        uiImageView.contentMode = .scaleAspectFill
        uiImageView.translatesAutoresizingMaskIntoConstraints = false
        return uiImageView
    }()
    
    lazy var conditionImageView: UIImageView = {
        let uiImageView = UIImageView(image: .Common.conditionImage)
        uiImageView.translatesAutoresizingMaskIntoConstraints = false
        uiImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        uiImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        uiImageView.contentMode = .scaleAspectFill
        uiImageView.tintColor = .Common.weatherColor
        return uiImageView
    }()
    
    lazy var uiActivityIndicatorView: UIActivityIndicatorView = {
        let uiActivityIndicatorView = UIActivityIndicatorView(style: .large)
        uiActivityIndicatorView.color = .Common.loaderColor
        uiActivityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        return uiActivityIndicatorView
    }()
    
    lazy var locationButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(.Common.locationImage, for: .normal)
        button.tintColor = .Common.weatherColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 35).isActive = true
        button.widthAnchor.constraint(equalToConstant: 35).isActive = true
        return button
    }()
    
    lazy var searchButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(.Common.searchImage, for: .normal)
        button.tintColor = .Common.weatherColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 35).isActive = true
        button.widthAnchor.constraint(equalToConstant: 35).isActive = true
        return button
    }()
    
    lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = UIColor.label
        textField.font = .systemFont(ofSize: 25, weight: .regular)
        textField.minimumFontSize = 25
        textField.placeholder = .Common.searchPlaceHolder
        textField.returnKeyType = .go
        textField.backgroundColor = .systemFill
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 20
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var headerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30, weight: .regular)
        label.textColor = .Common.weatherColor
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = false
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 100, weight: .bold)
        label.textColor = .label
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = false
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var celciusLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 100, weight: .bold)
        label.textColor = .label
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = false
        label.text = .Common.celcius
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .trailing
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var temperatureStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpSubViews()
        activateConstraints()
    }
    
    private func setUpSubViews() {
        self.addSubview(backgroundImageView)
        self.addSubview(headerStackView)
        self.addSubview(contentStackView)
        self.addSubview(uiActivityIndicatorView)
        headerStackView.addArrangedSubviews(locationButton, searchTextField, searchButton)
        temperatureStackView.addArrangedSubviews(temperatureLabel, celciusLabel)
        contentStackView.addArrangedSubviews(conditionImageView, temperatureStackView, cityLabel)
        contentStackView.isHidden = true
        uiActivityIndicatorView.isHidden = false
    }
    private func activateConstraints() {
        activateBackgroundImageViewConstraints()
        activateIndicatorViewConstraints()
        activateHeaderStackViewConstraints()
        activateContentStackViewConstraints()
    }
    
    private func activateBackgroundImageViewConstraints() {
        backgroundImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
    private func activateIndicatorViewConstraints() {
        uiActivityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        uiActivityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
    }
    
    private func activateHeaderStackViewConstraints() {
        headerStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        headerStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        headerStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
    }
    
    private func activateContentStackViewConstraints() {
        contentStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        contentStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -30).isActive = true
        contentStackView.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: 80).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) Not implemented")
    }
}

extension UIStackView {
    func addArrangedSubviews(_ subviews: UIView...) {
        subviews.forEach({ self.addArrangedSubview($0) })
    }
}
