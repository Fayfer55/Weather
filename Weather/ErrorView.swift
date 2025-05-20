//
//  ErrorView.swift
//  Weather
//
//  Created by Kirill Faifer on 20.05.2025.
//

import UIKit

final class ErrorView: UIView {
 
    // MARK: - UI Elements
    
    lazy var actionButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Try again", for: .normal)
        button.configuration = .filled()
        button.configuration?.cornerStyle = .large
        return button
    }()
    
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.text = "Something went wrong"
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var verticalStack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [errorLabel, actionButton])
        view.axis = .vertical
        view.distribution = .fill
        view.isLayoutMarginsRelativeArrangement = true
        view.directionalLayoutMargins = .safeArea
        return view
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    private func setupSubviews() {
        addSubview(verticalStack)
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        verticalStack.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}
