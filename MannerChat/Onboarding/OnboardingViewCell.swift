//
//  OnboardingViewCell.swift
//  MannerChat
//
//  Created by Victor Lee on 2023/02/12.
//

import Foundation
import UIKit

class OnboardingViewCell: UICollectionViewCell {

    func setInfo(_ information: OnboardingModel) {
        let attributeString = NSMutableAttributedString(string: information.description)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        attributeString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributeString.length))
        label.attributedText = attributeString

        imageView.image = UIImage(named: information.image)
    }

    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont(name: "NanumGothicOTFBold", size: 30)
        label.textColor = UIColor(hex: "#12348A")

        return label
    }()

    private let imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.sizeToFit()

        return image
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        addSubview(label)
        addSubview(imageView)

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            imageView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 51),
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 300),
            imageView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
}
