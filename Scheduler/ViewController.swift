//
//  ViewController.swift
//  Scheduler
//
//  Created by rae on 2023/02/22.
//

import UIKit

final class ViewController: UIViewController {
    
    private lazy var kakaoButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "kakao")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(kakaoButtonDidTap(_:)), for: .touchUpInside )
        return button
    }()
    
    private lazy var loginButtonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [kakaoButton])
        stackView.axis = .vertical
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    
}

private extension ViewController {
    func setup() {
        setupLayout()
    }
    
    func setupLayout() {
        view.addSubview(loginButtonStackView)
        loginButtonStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginButtonStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButtonStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    @objc func kakaoButtonDidTap(_ sender: UIButton) {
        
    }
}
