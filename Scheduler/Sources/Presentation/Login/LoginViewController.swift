//
//  LoginViewController.swift
//  Scheduler
//
//  Created by rae on 2023/02/22.
//

import UIKit
import Combine

final class LoginViewController: UIViewController {
    
    private let viewModel: LoginViewModel
    private var cancellables = Set<AnyCancellable>()
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "일정 관리"
        label.font = .preferredFont(for: .largeTitle, weight: .bold)
        label.textColor = .label
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "SNS 계정으로 로그인"
        label.font = .preferredFont(for: .callout, weight: .bold)
        label.textColor = .systemGray
        return label
    }()
    
    private lazy var naverButton: LoginButton = {
        let button = LoginButton(image: UIImage(named: "naver"))
        button.addTarget(self, action: #selector(naverButtonDidTap(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var kakaoButton: LoginButton = {
        let button = LoginButton(image: UIImage(named: "kakao"))
        button.addTarget(self, action: #selector(kakaoButtonDidTap(_:)), for: .touchUpInside )
        return button
    }()
    
    private lazy var loginButtonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [naverButton, kakaoButton])
        stackView.axis = .horizontal
        stackView.spacing = 16
        return stackView
    }()
}

private extension LoginViewController {
    func bind() {
        viewModel.output.isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                if isLoading {
                    
                } else {
                    
                }
            }
            .store(in: &cancellables)
    }
    
    func setupLayout() {
        view.backgroundColor = .systemBackground
        view.addSubviews(titleLabel, descriptionLabel, loginButtonStackView)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100.0),
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: 100.0),
            loginButtonStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButtonStackView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20.0)
        ])
    }
    
    @objc func naverButtonDidTap(_ sender: LoginButton) {
        
    }
    
    @objc func kakaoButtonDidTap(_ sender: LoginButton) {
        viewModel.input.kakaoButtonDidTap()
    }
}
