#  Day 17: Project 1, Part Two

오늘의 학습 내용: https://www.hackingwithswift.com/100/swiftui/17

# 📒 필드 노트

오늘은 16일차에 배운 내용을 실전에 사용하는 날이다. 지난번에 소개한 Form, @State, Picker 등을 직접 사용해보는 시간이다.

금일 학습 주제는 다음과 같다:

- Reading text from the user with TextField (TextField에 사용자가 입력한 텍스트 읽기)
- Creating pickers in a form (Form 내부에 Picker 생성하기)
- Adding a segmented control for tip percentages (팁 퍼센티지 설정을 위한 Segmented Control 추가하기)
- Calculating the total per person (인당 가격 계산하기)
- Hiding the keyboard (키보드 숨기기 기능 추가)

## TextField에 사용자가 입력한 텍스트 읽기

TextField에 two-way binding을 이용하여 상태 값과 연결하려면 달러사인 ($)을 표시해야한다는 것을 지난 시간에 배웠다. 이를 적용해서 텍스트 필드에 상태 값을 보여주도록 한다.

```Swift
TextField("Amount", text: $checkAmount)
```

TextField에는 입력된 텍스트의 포맷을 지정할 수 있는 기능이 있다. 나라별로 통화의 포맷은 상이하기 때문에 format: argument에 .currency(code: ) 값을 통해 포맷을 적용할 수 있다. 이때 Locale.current.currency?.identifier 값을 이용하면 각 유저의 지역에 따른 통화를 보여줄 수 있다. 

```Swift
TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD")))
```


@State 프로퍼티 래퍼 (property wrapper)는 변경사항이 있는지 없는지 지켜보다가, 변경사항이 생기면 body 프로퍼티를 다시 부르면서 UI를 갱신한다.

.keyboardType() modifier를 이용하면 TextField에 포커스 되었을 때 나타나는 키보드의 종류를 설정할 수 있다. 현재 상황에서는 "." 이 들어간 decimalPad가 키보드가 적절하여 이로 설정한다. 그리고 추가적으로 숫자가 아닌 다른 텍스트를 복사 붙여넣기하면 이를 필터링하는 역할도 한다.

## Form 내부에 Picker 생성하기

몇명과 계산서를 나눌지 설정할 때 숫자를 입력해도 되지만, Picker를 이용하여 선택할 수 있다. 여기서는 Picker와 ForEach를 사용해서 인원을 명시하는 방법을 다룬다. 

Picker은 설명을 인자로 받고 그 다음엔 default value를 인자로 받는다. 내부에는 각각 선택지마다 Text를 생성하여 나타낼 수 있다. 현재 경우에는 2명부터 100명까지 선택지를 나타낼 것이므로 ForEach 를 이용하여 여러개의 Text를 생성하도록 작성한다.

```Swift
Picker("Number of people", selection: $numberOfPeople) {
    ForEach(2..<100) {
        Text("\($0) people")
    }
}
```

실행 시에 numberOfPeople 값이 2임에도 불구하고 시뮬레이터에서는 4로 나타나는 것을 볼 수 있다. 이는 numberOfPeople 값이 인덱스로 작용하기 때문이다. 숫자는 2부터 시작하고 0번부터 시작하는 collection에서 2번째 인덱스에는 4가 있기 때문에 4로 나타나는 것이다. (예: [2, 3, 4, ...]) 계산시에는 이 사실을 염두하고 계산하면 된다.

Picker의 style에는 여러가지 종류가 있는데, 추가 화면으로 이동해서 그곳에서 선택하는 네비게이션링크(.navigationLink)와 적은 수의 선택지가 있을 때 사용하기 좋은 세그먼트 (.segmented)가 있다.

```Swift
Picker("Number of people", selection: $numberOfPeople) {
    ForEach(2 ..< 100) {
        Text("\($0) people")
    }
}
.pickerStyle(.navigationLink)
```

,navigationLink를 사용하려면 먼저 화면이 NavigationStack에 감싸여 있어야한다. 기존의 Form을 감싸주고, Form에 .navigationTitle modifier를 추가하여 화면의 타이틀을 추가한다. 팁으로 NavigationStack은 여러 화면을 보여주는 것을 담당하기 때문에 그 내부 요소에 title을 추가하는 것이 적절하다고 한다. 그동안 네비게이션 타이틀은 네비게이션스택에 추가해야 맞지 않나 생각해왔는데 설명을 듣고 납득이 되었다.

```Swift
var body: some View {
    NavigationStack {
        Form {
            // everything inside your form
        }
        .navigationTitle("WeSplit")
    }
}
```

## 팁 퍼센티지 설정을 위한 Segmented Control 추가하기

팁 선택을 위해 Picker를 추가하는데 여기서는 segmented style로 추가한다. 

SwiftUI는 Section header과 foote에 뷰를 추가할 수 있는 기능을 제공한다. 텍스트를 넣어서 해당 섹션에 대한 짧은 설명도 추가할 수 있다.

```Swift
Section("How much tip do you want to leave?") {
    Picker("Tip percentage", selection: $tipPercentage) {
        ForEach(tipPercentages, id: \.self) {
            Text($0, format: .percent)
        }
    }
    .pickerStyle(.segmented)
}
```

## 키보드 숨기기 기능 추가

텍스트필드에 포커스가 올라가고키보드가 한번 나타나면 사라지지 않는다. 이를 해결하기 위해 @FocusState 프로퍼티 래퍼를 소개한다.

UI에 입력 포커스를 다루기 위한 것이라는 부분만 제외하면 @FocusState 프로퍼티 래퍼는 @State 프로퍼티 래퍼와 같다.  

포커스 상태인지 아닌지 상태를 담는 Bool 타입 변수 amountIsFocused 를 ContentView에 추가한다.

```Swift
@FocusState private var amountIsFocused: Bool
```

그리고 TextField에 .focused modifier를 추가하여 해당 변수를 two-way binding으로연결한다. 

```Swift
.focused($amountIsFocused)
```

포커스 상태를 전환 시켜줄 버튼이 필요하다. Form에 아래 modifier를 추가하여 실행하면 상단 네비게이션 바에 버튼이 추가된 것을 볼 수 있다. 이를 통해 입력이 끝나면 포커스 상태를 전환하여 키보드를 숨길 수 있다.

```Swift
.toolbar {
    if amountIsFocused {
        Button("Done") {
            amountIsFocused = false
        }
    }
}
```

