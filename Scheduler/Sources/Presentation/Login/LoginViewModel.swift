//
//  LoginViewModel.swift
//  Scheduler
//
//  Created by rae on 2023/02/24.
//

import Foundation
import Combine

protocol LoginViewModelInput {
    func kakaoButtonDidTap()
}

protocol LoginViewModelOutput {
    var isLoading: AnyPublisher<Bool, Never> { get }
    var isLoginSuccess: AnyPublisher<Bool, Never> { get }
}

protocol LoginViewModel {
    var input: LoginViewModelInput { get }
    var output: LoginViewModelOutput { get }
    
    var cancellables: Set<AnyCancellable> { get }
}

final class DefaultLoginViewModel: LoginViewModel {
    private(set) var cancellables: Set<AnyCancellable> = .init()
    private let authRepository: AuthenticationRepository
    
    private var _isLoading = CurrentValueSubject<Bool, Never>(false)
    private var _isLoginSuccess = CurrentValueSubject<Bool, Never>(false)
    
    init(
        authRepository: AuthenticationRepository = DefaultAuthenticationRepository()
    ) {
        self.authRepository = authRepository
    }
}

extension DefaultLoginViewModel: LoginViewModelInput {
    var input: LoginViewModelInput { return self }
    
    func kakaoButtonDidTap() {
        _isLoading.send(true)
        // AuthRepository 호출
        authRepository.kakaoAuthorize()
            .sink { [weak self] completion in
//                if case let
            } receiveValue: { [weak self] authentication in
                print(authentication)
            }
            .store(in: &cancellables)

    }
}

extension DefaultLoginViewModel: LoginViewModelOutput {
    var output: LoginViewModelOutput { return self }
    
    var isLoading: AnyPublisher<Bool, Never> { _isLoading.eraseToAnyPublisher() }
    var isLoginSuccess: AnyPublisher<Bool, Never> { _isLoginSuccess.eraseToAnyPublisher() }
}
