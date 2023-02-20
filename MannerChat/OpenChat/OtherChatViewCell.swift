//
//  OtherChatViewCell.swift
//  MannerChat
//
//  Created by Victor Lee on 2023/02/20.
//

import Foundation
import UIKit
import Kingfisher

final class OtherChatViewCell: UITableViewCell {

    static let identifier = String(describing: OtherChatViewCell.self)

    private let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        imageView.backgroundColor = .gray
        imageView.clipsToBounds = true

        return imageView
    }()

    private let userNickname: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.textColor = .label
        return label
    }()

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
        if let imageUrl = message.user?.profileURL {
            self.profileImage.kf.setImage(with: URL(string: imageUrl))
        }
        if let nickname = message.user?.nickname {
            self.userNickname.text = nickname
        }
    }

    private func setupViews() {
        contentView.addSubview(messageBackground)
        contentView.addSubview(profileImage)
        contentView.addSubview(userNickname)
        contentView.addSubview(messageLabel)

        NSLayoutConstraint.activate([
            profileImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            profileImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            profileImage.heightAnchor.constraint(equalToConstant: 40),
            profileImage.widthAnchor.constraint(equalToConstant: 40),

            userNickname.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 8),
            userNickname.topAnchor.constraint(equalTo: profileImage.topAnchor),

            messageBackground.topAnchor.constraint(equalTo: userNickname.bottomAnchor, constant: 4),
            messageBackground.leadingAnchor.constraint(equalTo: userNickname.leadingAnchor),
            messageBackground.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),

            messageLabel.topAnchor.constraint(equalTo: messageBackground.topAnchor, constant: 8),
            messageLabel.bottomAnchor.constraint(equalTo: messageBackground.bottomAnchor, constant: -8),
            messageLabel.trailingAnchor.constraint(equalTo: messageBackground.trailingAnchor, constant: -12),
            messageLabel.leadingAnchor.constraint(equalTo: messageBackground.leadingAnchor, constant: 12)
        ])
    }
}

