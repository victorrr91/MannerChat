//
//  OpenChatListViewController.swift
//  MannerChat
//
//  Created by Victor Lee on 2023/02/17.
//

import UIKit
import SendbirdChatSDK

class OpenChatViewController: UIViewController {

    private var channel: Channel? = nil

    private var inputBottomConstraint : NSLayoutConstraint? = nil

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none

        tableView.register(
            MyChatViewCell.self,
            forCellReuseIdentifier: MyChatViewCell.identifier
        )
        tableView.register(
            OtherChatViewCell.self,
            forCellReuseIdentifier: OtherChatViewCell.identifier
        )

        tableView.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(didTapTableView)
            )
        )

        tableView.dataSource = self

        return tableView
    }()

    private lazy var messageInput: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = .systemFont(ofSize: 18)
        textView.layer.borderColor = UIColor.label.cgColor
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 10
        textView.textContainer.maximumNumberOfLines = 4

        textView.delegate = self

        return textView
    }()

    private lazy var sendButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "paperplane"), for: .disabled)
        button.setImage(UIImage(systemName: "paperplane.fill"), for: .normal)
        button.isEnabled = false
        let config = UIImage.SymbolConfiguration(pointSize: 24)
        button.setPreferredSymbolConfiguration(config, forImageIn: .normal)
        button.addTarget(self, action: #selector(didTapSendButton), for: .touchUpInside)

        return button
    }()

    @objc
    private func didTapSendButton() {
        self.messageInput.text = ""
        self.sendButton.isEnabled = false

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        setKeyboardObserver()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()

        SendbirdChat.addChannelDelegate(self as BaseChannelDelegate, identifier: "aa")
    }

    override func viewWillDisappear(_ animated: Bool) {
        removeKeyboardObserver()
        SendbirdChat.disconnect()
    }

    private func setupViews() {
        view.addSubview(tableView)
        view.addSubview(messageInput)
        view.addSubview(sendButton)

        inputBottomConstraint = messageInput.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)

        if let inputBottomConstraint = inputBottomConstraint {
            inputBottomConstraint.isActive = true
        }

        NSLayoutConstraint.activate([
            messageInput.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            messageInput.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor, constant: -8),
            messageInput.heightAnchor.constraint(equalToConstant: 40),

            sendButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            sendButton.centerYAnchor.constraint(equalTo: messageInput.centerYAnchor),

            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: messageInput.topAnchor)
        ])
    }
}

extension OpenChatViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        return UITableViewCell()
    }
}

extension OpenChatViewController: UITextViewDelegate {

    func textViewDidChange(_ textView: UITextView) {
        if (textView.text != "") {
            sendButton.isEnabled = true
        } else {
            sendButton.isEnabled = false
        }
    }
}

extension OpenChatViewController: GroupChannelDelegate {

    func channel(_ channel: BaseChannel, didReceive message: BaseMessage) {
        print("a", message)
        if message is UserMessage {
            print(message)
        }
    }
}

private extension OpenChatViewController {

    @objc
    func didTapTableView() {
        view.endEditing(true)
    }

    func setKeyboardObserver() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification, object:nil
        )
    }

    func removeKeyboardObserver() {
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        if  let userInfo = notification.userInfo,
            let keyboardFrame: NSValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
            let animationDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
            let animationCurve = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt{
            let keyboardHeight = keyboardFrame.cgRectValue.height

            let animationOptions = UIView.AnimationOptions(rawValue: animationCurve << 16)

            let window = UIApplication.shared.windows.first
            let bottomPadding = window?.safeAreaInsets.bottom ?? 0

            UIView.animate(withDuration: animationDuration,
                           delay: 0,
                           options: animationOptions) {
                self.inputBottomConstraint?.constant = -keyboardHeight + bottomPadding - 8
                self.view.layoutIfNeeded()
            } completion: { _ in }

//            let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
//            self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        DispatchQueue.main.async {
            self.inputBottomConstraint?.constant = -16
            self.view.layoutIfNeeded()
        }
    }
}
