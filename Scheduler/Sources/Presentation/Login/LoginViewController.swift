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
        label.text = "안녕하세요👋\n일정관리에 오신걸 환영해요!"
        label.font = .preferredFont(for: .title2, weight: .semibold)
        label.textColor = .label
        label.numberOfLines = 2
        
        guard let text = label.text else {
            return label
        }
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(.foregroundColor, value: UIColor.red, range: (text as NSString).range(of: "일정관리"))
        label.attributedText = attributedString
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "SNS 계정으로 로그인"
        label.font = .preferredFont(for: .callout, weight: .semibold)
        label.textColor = .systemGray
        return label
    }()
    
    private lazy var naverButton: LoginButton = {
        let button = LoginButton(
            image: UIImage(named: "naver"),
            title: "네이버로 계속하기",
            titleColor: UIColor.naverText,
            backgroundColor: UIColor.naverBackground
        )
        button.addTarget(self, action: #selector(naverButtonDidTap(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var kakaoButton: LoginButton = {
        let button = LoginButton(
            image: UIImage(named: "kakao"),
            title: "카카오톡으로 계속하기",
            titleColor: UIColor.kakaoText,
            backgroundColor: UIColor.kakaoBackground
        )
        button.addTarget(self, action: #selector(kakaoButtonDidTap(_:)), for: .touchUpInside )
        return button
    }()
    
    private lazy var appleButton: LoginButton = {
        let button = LoginButton(
            image: UIImage(named: "apple"),
            title: "Apple로 계속하기",
            titleColor: UIColor.appleText,
            backgroundColor: UIColor.appleBackground
        )
        button.addTarget(self, action: #selector(appleButtonDidTap(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var loginButtonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [naverButton, kakaoButton, appleButton])
        stackView.axis = .vertical
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
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150.0),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0),
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: view.centerYAnchor),
            loginButtonStackView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20.0),
            loginButtonStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16.0),
            loginButtonStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16.0),
        ])
    }
    
    @objc func naverButtonDidTap(_ sender: LoginButton) {
        
    }
    
    @objc func kakaoButtonDidTap(_ sender: LoginButton) {
        viewModel.input.kakaoButtonDidTap()
    }
    
    @objc func appleButtonDidTap(_ sender: LoginButton) {
        
    }
}
