# 🎒 Healthy Bag (헬시백)
> **"오늘의 땀방울을 담다, 운동 인증 실시간 공유"**

**Healthy Bag**은 자신의 운동 루틴, 장비, 그리고 운동하는 모습(오운완)을 공유하는 **퍼포먼스 중심의 운동 SNS**입니다. 단순히 기록하는 것을 넘어, 같은 운동 목적을 가진 사람들끼리 자극을 주고받으며 '운동하는 습관'을 함께 만들어갑니다.

---

## 🛠 Tech Stack & Libraries

### **Environment**
- **Framework**: `Flutter 3.3.8 (Stable)`
- **Language**: `Dart 3.10.7`
- **DevTools**: `2.51.1`
- **Backend**: `Firebase Firestore`, `Firebase Storage`

### **Libraries**
- **Authentication**: `Firebase Auth`, `Google Sign In`, `Kakao SDK` (소셜 로그인 연동)
- **State Management**: `Riverpod` & `Riverpod Generator` (Code Generation 기반 상태 관리)
- **Media**: `image_picker` (운동사진 업로드)
- **Database/Storage**: `Cloud Firestore`, `Firebase Storage`
- **Navigation**: `go_router` (앱 내 네비게이션)
- **UI/UX**: 
  - `circle_nav_bar` (커스텀 하단 네비게이션)
  - `flutter_svg`, `cupertino_icons`, `material_symbols_icons`
  - `top_snackbar_flutter` (커스텀 알림 피드백)
  - `flutter_native_splash` (스플래시 화면 제어)


---

## 🚀 Key Features

운동인의 니즈에 맞춘 '인증'과 '소통' 기능을 클린아키텍처 기반으로 구현했습니다.

### 1. 로그인
- **소셜 로그인**: Google/Kakao SDK를 활용한 소셜 로그인 시스템 구현

### 2. 오운완(Today's Workout) 인증 시스템
- **미디어 업로드**: `Firebase Storage`를 통해 그날의 운동 사진을 업로드합니다. 운동 부위나 사용 장비를 태그로 기록할 수 있습니다.

### 3. 리액션 및 소통 (Social Interaction)
- **리액션**: 좋아요와 댓글 기능을 통해 서로의 운동 성취를 응원합니다. 


---

## 📂 Project Structure

```text
lib/
 ├── core/                       # 공통 기능 (네트워크, 테마, 에러 처리)
 │    ├── di/                    # 의존성
 │    ├── theme/                 # 앱 테마
 │    ├── router/                # 앱 내 네비게이션, GoRouter 사용
 │    └── utils/                 # 포맷터, 공통 위젯 등
 ├── domain/              
 │    ├── entities/              # DTO 변환 객체
 │    ├── repositories/          # 인터페이스
 │    └── usecases/              # vm로 넘겨줄 메서드 정의               
 ├── presentation/
 │    ├── pages/                 # UI 및 상태 관리 
 │    │    ├── home/             # 메인 리스트 화면
 │    │    ├── write/            # 운동 기록 작성 화면
 │    │    ├── comment/          # 댓글 확인 화면      
 │    │    ├── welcome/          # 로그인 화면 및 로그인이 되어있을 초기 화면
 │    │    └── splash/           # 화면 초기 splash screen
 │    └── widgets/               # 전역으로 사용되는 위젯 등
 ├── data/                       
 │    ├── datasources/           # API 통신
 │    ├── DTO/                   # Data Transfer Object
 │    └── repositories_impl/     # 구현체              
 └── main.dart                   # 앱 실행
```

## 👥 Contributors & Roles

| 이름 | 역할 | 주요 구현 내용 |
| :--- | :---: | :--- |
| **김동준** | **UI/UX / Core** | - **라우팅**: GoRouter를 활용한 선언적 네비게이션 시스템 및 심층 경로(Deep Link) 기반 구축<br>- **UI 구현**: CircleNavBar 커스텀 네비게이션 및 다양한 디바이스에 대응하는 반응형 운동 피드 레이아웃 제작|
| **박진** | **Backend / Dev** | - **무한스크롤**: Firestore를 활용한 무한스크롤 구현<br>- **데이터 구조**: 앱 서비스와 Firestore 실시간 데이터베이스 간의 안정적인 CRUD 및 비즈니스 로직 연결|
| **김영광** | **Core / Dev** | - **상태 관리**: Riverpod Generator를 활용한 타입 안정성 중심의 전역 상태 관리 설계<br>- **인증 시스템**: Firebase Auth와 Google/Kakao SDK를 연동한 소셜 로그인 시스템 구현  |