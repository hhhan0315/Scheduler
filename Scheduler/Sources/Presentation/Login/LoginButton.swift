//
//  LoginButton.swift
//  Scheduler
//
//  Created by rae on 2023/02/24.
//

import UIKit

final class LoginButton: UIButton {
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 44.0, height: 44.0)
    }
    
    convenience init(image: UIImage?) {
        self.init(frame: .zero)
        let image = image?.withRenderingMode(.alwaysOriginal)
        setImage(image, for: .normal)
    }
}
