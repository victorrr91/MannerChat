//
//  MyChatViewCell.swift
//  MannerChat
//
//  Created by Victor Lee on 2023/02/20.
//

import Foundation
import UIKit
import Kingfisher

final class MyChatViewCell: UITableViewCell {

    static let identifier = String(describing: MyChatViewCell.self)

    private let messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        label.textColor = .label
        label.numberOfLines = 0
        return label
    }()

    private let messageBackground: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .yellow
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configurationCell(_ message: Message) {
        self.selectionStyle = .none
        self.messageLabel.text = message.message
    }

    private func setupViews() {
        contentView.addSubview(messageBackground)
        contentView.addSubview(messageLabel)

        NSLayoutConstraint.activate([
            messageBackground.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            messageBackground.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            messageBackground.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),

            messageLabel.topAnchor.constraint(equalTo: messageBackground.topAnchor, constant: 8),
            messageLabel.bottomAnchor.constraint(equalTo: messageBackground.bottomAnchor, constant: -8),
            messageLabel.trailingAnchor.constraint(equalTo: messageBackground.trailingAnchor, constant: -12),
            messageLabel.leadingAnchor.constraint(equalTo: messageBackground.leadingAnchor, constant: 12)
        ])
    }
}

