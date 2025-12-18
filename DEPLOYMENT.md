# Hi_Great 웹 앱 배포 가이드

## 개요
이 문서는 Hi_Great Flutter 웹 앱을 iOS App Store에 제출하기 위한 배포 및 패키징 과정을 안내합니다.

## 1. Flutter 웹 앱 빌드

### 웹 빌드 생성
```bash
flutter build web --release --web-renderer canvaskit
```

이 명령은 `build/web` 디렉토리에 최적화된 웹 앱 빌드를 생성합니다.

## 2. iOS App Store 제출 방법 (WebView 래퍼 사용)

Hi_Great 웹 앱을 iOS App Store에 제출하기 위해서는 WebView 래퍼 앱을 사용하는 것이 좋습니다.

### 2.1. Xcode 프로젝트 설정

1. Xcode를 열고 새 iOS 앱 프로젝트를 생성합니다.
2. WebKit 프레임워크를 추가합니다:
   - 프로젝트 설정에서 'General' > 'Frameworks, Libraries, and Embedded Content'로 이동
   - '+'를 클릭하고 WebKit.framework를 선택 후 'Add'

### 2.2. WebView 구현

1. 프로젝트 내 ViewController.swift 파일을 열고 다음 코드로 대체합니다:

```swift
import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    var webView: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.applicationNameForUserAgent = "Hi_Great_iOS_App"
        
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 로컬 HTML 로드 (웹 빌드 파일을 앱 번들에 포함시킨 경우)
        if let url = Bundle.main.url(forResource: "index", withExtension: "html", subdirectory: "web") {
            webView.loadFileURL(url, allowingReadAccessTo: url.deletingLastPathComponent())
        }
        
        // 또는 배포된 웹 URL 로드
        // if let url = URL(string: "https://your-web-app-url.com") {
        //     let request = URLRequest(url: url)
        //     webView.load(request)
        // }
    }
    
    // 오프라인 지원 및 캐싱 구현
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // 필요한 경우 여기에 추가 로직 구현
    }
}
```

### 2.3. 웹 빌드 파일 포함

1. 생성된 Flutter 웹 빌드 파일을 Xcode 프로젝트에 추가합니다:
   - Finder에서 `build/web` 폴더 내 모든 파일을 선택
   - Xcode 프로젝트로 드래그 앤 드롭
   - "Create folder references"를 선택하고 "Copy items if needed" 옵션을 체크
   - 적절한 타겟을 선택하고 "Finish" 클릭

### 2.4. Info.plist 설정

다음 설정을 Info.plist에 추가합니다:

```xml
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsArbitraryLoads</key>
    <true/>
</dict>
<key>UILaunchStoryboardName</key>
<string>LaunchScreen</string>
<key>UIViewControllerBasedStatusBarAppearance</key>
<false/>
<key>UIStatusBarHidden</key>
<true/>
```

### 2.5. App Store 심사 준비

App Store 심사를 위해 다음 사항을 준비하세요:
- 개인 정보 취급 방침
- 앱 설명 및 스크린샷
- 앱 아이콘 (1024x1024 포함)
- 마케팅 자료

## 3. PWA를 통한 iOS 홈 화면 설치 안내

사용자가 Safari 브라우저를 통해 웹앱을 홈 화면에 추가할 수 있도록 다음 안내를 제공하세요:

1. Safari로 웹 앱 열기
2. 공유 버튼 클릭
3. '홈 화면에 추가' 선택
4. 이름 확인 후 '추가' 클릭

## 4. 웹 앱 최적화 확인 사항

- [x] 모바일 반응형 디자인
- [x] PWA 메타 태그 및 매니페스트
- [x] 아이콘 및 스플래시 이미지
- [x] 오프라인 지원 (ServiceWorker)
- [x] 앱 설치 프롬프트

## 5. 문제 해결

일반적인 문제 및 해결 방법:

### 5.1. 빈 화면 또는 로딩 문제
- Flutter 웹 빌드 경로와 base href 설정 확인
- JavaScript 콘솔 오류 체크
- CORS 이슈 확인

### 5.2. 성능 이슈
- 이미지 최적화
- 코드 스플리팅 고려
- 캔버스킷(CanvasKit) 렌더러 사용 여부 확인

## 6. 유지보수 및 업데이트

웹 앱 업데이트 방법:
1. Flutter 코드 수정
2. 새로운 웹 빌드 생성
3. 웹 서버 또는 WebView 래퍼 앱 업데이트
4. 필요시 App Store에 새 버전 제출
