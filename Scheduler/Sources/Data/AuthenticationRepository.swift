//
//  AuthRepository.swift
//  Scheduler
//
//  Created by rae on 2023/02/24.
//

import Foundation
import Combine
import KakaoSDKUser

protocol AuthenticationRepository {
    func kakaoAuthorize() -> AnyPublisher<Authentication, Error>
}

final class DefaultAuthenticationRepository: AuthenticationRepository {
    func kakaoAuthorize() -> AnyPublisher<Authentication, Error> {
        let authentication = PassthroughSubject<Authentication, Error>()
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk { oauthToken, error in
                if let error = error {
                    authentication.send(completion: .failure(error))
                }
                else {
                    UserApi.shared.me { user, error in
                        if let error = error {
                            authentication.send(completion: .failure(error))
                        } else {
                            authentication.send(
                                Authentication(
                                    accessToken: oauthToken?.accessToken,
                                    refreshToken: oauthToken?.refreshToken,
                                    snsUserName: user?.kakaoAccount?.profile?.nickname,
                                    snsUserEmail: user?.kakaoAccount?.email,
                                    snsUserId: user?.id?.description,
                                    snsProfileUrl: user?.kakaoAccount?.profile?.profileImageUrl?.absoluteString
                                )
                            )
                            authentication.send(completion: .finished)
                        }
                    }
                }
            }
        } else {
            UserApi.shared.loginWithKakaoAccount { oauthToken, error in
                if let error {
                    authentication.send(completion: .failure(error))
                } else {
                    UserApi.shared.me { user, error in
                        if let error = error {
                            authentication.send(completion: .failure(error))
                        } else {
                            authentication.send(
                                Authentication(
                                    accessToken: oauthToken?.accessToken,
                                    refreshToken: oauthToken?.refreshToken,
                                    snsUserName: user?.kakaoAccount?.profile?.nickname,
                                    snsUserEmail: user?.kakaoAccount?.email,
                                    snsUserId: user?.id?.description,
                                    snsProfileUrl: user?.kakaoAccount?.profile?.profileImageUrl?.absoluteString
                                )
                            )
                            authentication.send(completion: .finished)
                        }
                    }
                }
            }
        }
        return authentication.eraseToAnyPublisher()
    }
}
