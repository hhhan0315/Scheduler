//
//  Bundle+extension.swift
//  Scheduler
//
//  Created by rae on 2023/02/23.
//

import Foundation

extension Bundle {
    var kakaoNativeAppKey: String? {
        guard let key = self.infoDictionary?["KAKAO_NATIVE_APP_KEY"] as? String else {
            debugPrint("🚫 KAKAO NATIVE APP KEY를 가져오는데 실패했습니다.")
            return nil
        }
        return key
    }
}
