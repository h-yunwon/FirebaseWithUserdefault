## 개요
이 앱은 Userdefault를 활용하여 사용자 개인의 프로필을 작성하고 저장한 뒤, Firebase Realtime Database와 앱을 연동하여 서버에서 데이터를 쓰기, 수정, 삭제할 때마다 실시간으로 데이터를 앱에서 읽을 수 있도록 구현한 프로젝트입니다.

## 학습 목표
- Firebase Realtime Database의 CRUD 작업 이해 및 구현
- Userdefault를 사용하여 데이터 저장 및 불러오기 기능 구현

## 주요 기능
1. 프로필 리스트: 등록된 프로필을 리스트 형식으로 확인할 수 있습니다.
2. 프로필 상세정보: 프로필을 선택하면 해당 프로필의 상세정보를 확인할 수 있습니다. 만약 자신의 프로필인 경우, 삭제 버튼을 통해 업로드한 프로필을 삭제할 수 있습니다.
3. 내 프로필: 자신의 프로필을 작성하고 수정할 수 있으며, 업로드 버튼을 누르면 프로필 리스트에 등록됩니다.

## 시현 영상
![FirebaseWithUserdefault](https://github.com/h-yunwon/FirebaseWithUserdefault/assets/134713788/80c8c39c-88f5-4d8d-82fb-cd9fb0970b8e)

## 사용 기술 및 도구
- 언어: Swift
- 프레임워크: SwiftUI
- 데이터베이스: Firebase Realtime Database
- 디자인패턴: MVVM


## 배운 점

1. Firebase RealTime Database와 앱과의 연동 방법을 배웠습니다. 
2. Firebase Database를 사용하기 위해 데이터 모델링과 JSON 파싱에 대해 복습하였으며, Codable, Identification, CodingKeys 등에 대한 이해도를 높였습니다.
3. UserDefault를 사용하여 데이터를 저장하고 불러오는 방법을 복습했습니다.

## 참고자료 

[SwiftUI Firebase Realtime Database CRUD 제대로 사용하기, elisha0103](https://elisha0103.tistory.com/8)   
