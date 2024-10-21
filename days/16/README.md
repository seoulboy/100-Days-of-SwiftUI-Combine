#  Day 16: Project 1, Part One

오늘의 학습 내용: https://www.hackingwithswift.com/100/swiftui/16

# 📒 필드 노트

오늘은 WeSplit이라는 SwiftUI 앱을 만드는 과정의 첫번째 단계를 진행하는 날이다.

금일 학습은 아래 7가지의 토픽에 대해 다룰 예정이며 그 과정에서 `Form`, `NavigationStack`, `@Stack`을 소개한다.  

- WeSplit: Introduction (WeSplit 소개)
- Understanding the basic structure of a SwiftUI app (SwiftUI의 기본 구조 이해)
- Creating a form (Form의 생성)
- Adding a navigation bar (Navigation Bar의 추가)
- Modifying program state (프로그램의 상태 변경)
- Binding state to user interface controls (UI 제어장치에 상태를 바인딩하기)
- Creating views in a loop (루프 안에서 뷰 생성하기)


## WeSplit: Introduction

WeSplit 앱은 미국 음식점을 이용하고 계산서를 받고 같이 동행한 사람들과 나눌 때 유용한 앱이다. 앱에 팁의 양을 설정하고 계산서를 몇명과 나눌지 입력하면 각자가 내야할 금액을 알려준다. 이러한 앱을 만드는 과정을 통해 SwiftUI의 기본적인 개념들을 짚고 넘어갈 것으로 보인다. 새 SwiftUI 프로젝트를 생성하며 커리큘럼을 시작한다.

Organization Identifier에 대한 설명:

  Organization Identifier는 앱을 식별하는 용도로 쓰인다. 바로 아래 보여지는 Bundle Identifier를 보면 Product Name이 맨 뒤에 붙고 그 앞에는 Organization Identifier이 붙는 순서인 것을 알 수 있다. 이런 형식이 필수는 아니지만 웹사이트의 도메인 주소가 unique하기 때문에 이 특성을 그대로 이용하면서 앱을 식별하는데 사용하기 위해 Organization Identifier에 `com.{your_website_domain}` 형식으로 적는 것으로 보인다. 순서를 reverse 시킨 부분은 의문이다. 간단히 추측해보자면 `.com`이 뒤에 붙으면 URL로 인식이 될 가능성을 배제하기 위함이 아닐까 싶다.

## Understanding the basic structure of a SwiftUI app

스위프트 UI에서 화면에 그려지는 모든 것(버튼, 텍스트, 이미지)들은 View 프로토콜을 채택해야한다. body 변수만이 View 프로토콜의 유일한 요구사항이다.

some View 라는 것은 View 프로토콜을 준수하는 모든 타입이다.

modifier는 특정 변경 사항을 입힌 새로운 뷰를 생성하여 반환하는 함수이다.

\#Preview라는 코드는 Xcode가 UI 디자인을 미리 보여주도록 지원하는 특별한 코드이다. 개발시에만 필요하기 때문에 앱의 실행 파일에는 포함되지 않는다. Editor Menu > Canvas를 선택해서 미리보기를 띄울 수 있다. 미리보기 새로고침 키보드 단축키를 통해 간편하게 새로고침할 수 있다: `Option + Cmd + P` 

## Creating a form

Form은 스크롤 가능한 리스트이며 텍스트나 버튼과 같은 것들을 담을 수 있다. 이미지나 텍스트와 같은 정적인 컨트롤부터 텍스트 필드, 버튼, 토글 스위치와 같은 상호작용이 가능한 컨트롤까지 Form에 담을 수 있다. Section 을 사용해서 Form 안의 요소들을 그룹으로 나눌 수 있다.

```Swift
var body: some View {
    Form {
        Section {
            Text("Hello, world!")
        }

        Section {
            Text("Hello, world!")
            Text("Hello, world!")
        }
    }
}
```

## Adding a navigation bar

NavigationBar을 추가하려면 NavigationStack으로 Form을 둘러싸면 된다. 타이틀이 추가되기 전까지는 외관상 달라지지 않는다. 따라서 Form에 modifier로 `.navigationTitle("SwiftUI")`를 추가하면 타이틀이 나타난다. NavigationStack이 아닌 그 하위 항목인 Form에 추가 해주는 것이 중요하다. 기본적으로는 타이틀의 폰트가 크게 나타나므로 네비바 타이틀을 작게 만들기 위해서는 다음 modifier를 추가한다: `.navigationBarTitleDisplayMode(.inline)`

## Modifying Program State
> Views are a function of their state.
> "뷰들은 자신이 가지고 있는 상태의 함수다." 

즉, 뷰와 상태는 서로 연결되어 있어 뷰를 통해 상태를 볼 수 있고 뷰를 변경하면 상태 또한 변경된다. view와 model의 two-way binding과 일맥 상통하는 것으로 보인다. 

@State는 Struct의 프로퍼티 앞에 붙여서 상태를 변경하고 읽을 수 있게 도와주는 키워드이다. mutating 키워드를 사용하지 않아도 이를 통해 값을 변경할 수 있다. Struct에서 프로퍼티는 기본적으로 변경이 불가능하지만 @State 키워드가 붙은 프로퍼티는 따로 SwiftUI를 통해 관리된다. 즉 기존의 프로퍼티가 벨류타입에서 레퍼런스 타입으로 간주되며 힙에 저장되어 관리될 것이라 생각한다. 

## Binding state to user interface controls 
텍스트필드에서는 상태 값을 읽어오기도 하고 필드에 값을 변경했을 때 실제 상태 값 또한 변경할 수 있어야한다. 즉, 상태에 대해 읽기 쓰기가 모두 되어야한다는 얘기다. 하나의 주체가 상태 값을 읽기도 하고 상태 값을 변경하기도 하는 것을 two-way binding이라고 한다. two-way 바인딩을 사용하기 위해서는 @State 키워드가 붙은 프로퍼티를 입력하고 그 앞에 달러사인($)을 붙인다. 예: `TextField("Enter your name", text: $name)` 양방향 바인딩이 아니라 단방향 바인딩만 필요하다면 프로퍼티 선언시 앞에 @State 키워드를 추가하는 것만으로도 충분하다.

## Creating views in a loop

SwiftUI에서는 ForEach 루프를 돌려서 여러개의 뷰를 생성할 수 있도록 지원한다. ForEach에서 배열을 인자로 넣을 때는 배열의 각 아이템을 식별할 수 있는 단서를 제공해야한다. id 필드에 들어가는 값인데 이때 `\.self`를 사용하면 각 배열의 텍스트나 값을 식별자로 사용할 수 있다. 단, 중복이 있는 경우에는 문제가 발생할 수 있다.  

```Swift
struct ContentView: View {
    let students = ["Harry", "Hermione", "Ron"]
    @State private var selectedStudent = "Harry"

    var body: some View {
        NavigationStack {
            Form {
                Picker("Select your student", selection: $selectedStudent) {
                    ForEach(students, id: \.self) {
                        Text($0)
                    }
                }
            }
        }
    }
}
```
