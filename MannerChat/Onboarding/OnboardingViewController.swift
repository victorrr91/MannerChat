//
//  OnboadingViewController.swift
//  MannerChat
//
//  Created by Victor Lee on 2023/02/12.
//

import UIKit
import SendbirdChatSDK
import TAKUUID

class OnboardingViewController: UIViewController {

    private var OnboardingVM: OnboardingViewModel = OnboardingViewModel()

    private var inputBottomConstraint : NSLayoutConstraint? = nil

    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "NanumGothicOTF", size: 16)
        label.text = "Manner Chat에 오신 것을 환영합니다!"
        label.textColor = .secondaryLabel

        return label
    }()

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: view.frame.width, height: 500 - 24)
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.decelerationRate = .fast
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false

        collectionView.dataSource = self
        collectionView.delegate = self

        collectionView.register(OnboardingViewCell.self, forCellWithReuseIdentifier: "OnboardingViewCell")


        return collectionView
    }()

    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.numberOfPages = 3
        pageControl.currentPage = 0
        pageControl.isUserInteractionEnabled = false
        pageControl.currentPageIndicatorTintColor = UIColor(hex: "#2358E1")
        pageControl.pageIndicatorTintColor = UIColor(hex: "#D2D2D2")
        return pageControl
    }()

    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = .systemFont(ofSize: 18, weight: .semibold)
        textField.textColor = .label

        textField.addLeftPadding()
        textField.placeholder = "이메일을 입력해주세요."
        textField.delegate = self

        textField.layer.borderColor = UIColor(hex: "#2358E1")?.cgColor
        textField.layer.borderWidth = 1.5
        textField.layer.cornerRadius = 8
        textField.backgroundColor = .tertiarySystemBackground
        return textField
    }()

    private lazy var startButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("채팅 시작하기", for: .normal)
        button.titleLabel?.font = UIFont(name: "NanumGothicOTFBold", size: 16)
        button.backgroundColor = UIColor(hex: "#2358E1")
        button.setBackgroundColor(.systemGray2, for: .disabled)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true

        button.addTarget(self, action: #selector(didTapStartButton), for: .touchUpInside)
        return button
    }()

    @objc
    func didTapStartButton() {
        view.endEditing(true)
        guard let nickName = emailTextField.text else { return }

        SendbirdChat.connect(userId: nickName) { [weak self] user, error in
            guard let user = user, error == nil else {
                print(error)
                return
            }
            print("\(user)가 입장했습니다.11")

            if user.nickname == "" {
                self?.presentEnterNicknameAlert()
            } else {
                let openChatViewController = OpenChatViewController()
                self?.navigationController?.pushViewController(openChatViewController, animated: true)
            }
        }
    }

    func presentEnterNicknameAlert() {
        let alertController = UIAlertController(title: "닉네임 생성", message: "원하시는 닉네임을 입력해주세요.", preferredStyle: .alert)
        let confirm = UIAlertAction(title: "생성", style: .default) { nickname in
            guard let textField = alertController.textFields else { return }
            let nickname = textField[0].text

            let params = UserUpdateParams()
            params.nickname = nickname

            SendbirdChat.updateCurrentUserInfo(params: params) { [weak self] error in
                guard error == nil else {
                    return
                }
                let openChatViewController = OpenChatViewController()
                self?.navigationController?.pushViewController(openChatViewController, animated: true)
            }
        }

        let cancel = UIAlertAction(title: "취소", style: .cancel)

        alertController.addTextField()
        alertController.addAction(confirm)
        alertController.addAction(cancel)

        self.present(alertController, animated: true)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        setKeyboardObserver()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()

        SendbirdChat.addConnectionDelegate(self, identifier: "connect_delegate")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        removeKeyboardObserver()
        SendbirdChat.disconnect()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    private func setupViews() {
        view.addSubview(collectionView)
        view.addSubview(pageControl)
        view.addSubview(emailTextField)
        view.addSubview(startButton)

        inputBottomConstraint = startButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24)

        if let inputBottomConstraint = inputBottomConstraint {
            inputBottomConstraint.isActive = true
        }

        NSLayoutConstraint.activate([
            collectionView.heightAnchor.constraint(equalToConstant: 500),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: pageControl.topAnchor, constant: -8),

            pageControl.bottomAnchor.constraint(equalTo: emailTextField.topAnchor, constant: -56),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            emailTextField.bottomAnchor.constraint(equalTo: startButton.topAnchor, constant: -24),
            emailTextField.leadingAnchor.constraint(equalTo: startButton.leadingAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: startButton.trailingAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: 48),

            startButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            startButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            startButton.heightAnchor.constraint(equalToConstant: 48),
        ])
    }
}

extension OnboardingViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return OnboardingVM.OnboardingArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "OnboardingViewCell",
            for: indexPath
        ) as? OnboardingViewCell else {
            return UICollectionViewCell()
        }

        cell.setInfo(OnboardingVM.OnboardingArray[indexPath.row])

        return cell
    }
}

extension OnboardingViewController: UIScrollViewDelegate {

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.frame.maxX)
    }
}

extension OnboardingViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.startButton.isEnabled = true
    }
}

private extension OnboardingViewController {

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

            UIView.animate(withDuration: animationDuration,
                           delay: 0,
                           options: animationOptions) {
                self.inputBottomConstraint?.constant = -keyboardHeight
                self.view.layoutIfNeeded()
            } completion: { _ in }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        DispatchQueue.main.async {
            self.inputBottomConstraint?.constant = -24
            self.view.layoutIfNeeded()
        }
    }
}

extension OnboardingViewController: ConnectionDelegate, BaseChannelDelegate {
    func didConnect(userId: String) {
        print("\(userId)가 입장했습니다.")
    }

    func didDisconnect(userId: String) {
        print("\(userId)의 연결이 종료됐습니다.")
    }
}
