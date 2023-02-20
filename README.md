<img width="250" alt="스크린샷 2023-02-20 오후 4 38 40" src="https://user-images.githubusercontent.com/76080066/220042563-2b19ab38-a95f-4b89-8457-40b618166433.png"> <img width="247" alt="스크린샷 2023-02-20 오후 4 39 23" src="https://user-images.githubusercontent.com/76080066/220042632-24a81541-9e11-41b3-a358-6128b10a9fe2.png">

사용한 API: SendBirdChat API
  링크: [https://sendbird.com/docs](https://sendbird.com/docs)

구현 사항

- 디바이스 별 UUID를 생성하여 키체인에 저장하는 방식으로 디바이스 고유의 ID로 계정 가입
- 키체인에서 UUID를 불러와 유저 정보 불러오기 및 유저 정보 업데이트
- 채팅 시스템 구현

배운 점

- 자신의 채팅과 다른 유저의 채팅을 TableView 등을 통해 다르게 그려낼 수 있음
    
- SendBird의 API를 사용해보며 채팅에 필요한 API와 데이터 구성 형태 등을 알 수 있었음
    
    → 하지만 API 보다는 SDK를 활용하여 다양한 델리게이트를 활용해보는 것도 좋았을듯
    → 추후에 다뤄볼 예정
    
- 텍스트 인풋과 관련해서 다뤄야하는 키보드와 뷰의 관계를 확실히 정립
    → 뷰의 애니메이션을 키보드의 애니메이션과 동일하게 맞춰주는 등 디테일해야 부드러운 UI를 만들 수 있다

포트폴리오 사이트: [https://victorios.imweb.me/Projects](https://victorios.imweb.me/Projects)
