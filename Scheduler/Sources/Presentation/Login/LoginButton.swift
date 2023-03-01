//
//  LoginButton.swift
//  Scheduler
//
//  Created by rae on 2023/02/24.
//

import UIKit

final class LoginButton: UIButton {
    override var intrinsicContentSize: CGSize {
        return CGSize(width: .zero, height: 50.0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentHorizontalAlignment = .left
        imageView?.contentMode = .scaleAspectFit
        
        let leftSpacing = (frame.width - (imageView?.frame.width ?? 0) - (titleLabel?.frame.width ?? 0)) / 2
        titleEdgeInsets.left = leftSpacing
    }
    
    convenience init(
        image: UIImage?,
        title: String?,
        titleColor: UIColor?,
        backgroundColor: UIColor?
    ) {
        self.init(frame: .zero)
        
        let image = image?.withRenderingMode(.alwaysOriginal)
        setImage(image, for: .normal)
        
        setTitle(title, for: .normal)
        setTitleColor(titleColor, for: .normal)
        titleLabel?.font = .preferredFont(for: .callout, weight: .semibold)
        
        self.backgroundColor = backgroundColor
        
        layer.cornerRadius = 12
        adjustsImageWhenHighlighted = false
    }
}
