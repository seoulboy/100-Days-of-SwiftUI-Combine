#  Day 18: Project 1, Part Three

오늘의 학습 내용: https://www.hackingwithswift.com/100/swiftui/18

# 📒 필드 노트

오늘은 해당 프로젝트를 뒤돌아보며 배운 것들을 다시 복습하는 날이다. 우선 프로젝트 관련 3가지의 챌린지를 진행하고 이어서 배운 내용에 대한 퀴즈를 진행한다.

- WeSplit: Wrap up (WeSplit: 마무리)
- Review for Project 1: WeSplit (프로젝트 1 돌아보기: WeSplit)


## WeSplit: Wrap up (WeSplit: 마무리)

세가지 챌린지를 준다. 순서대로 진행해보자.

1. 셋째 섹션에 "Amount per person"이라는 내용의 헤더를 추가해보시오

이 부분은 간단하게 해결했다. 섹션을 추가하고 인자로 해당 내용의 텍스트를 넣으면 된다.

```Swift
Section("Amount per person:") {
    // ...    
}
```
2. 금액의 총합을 보여주는 섹션을 추가하시오. (금액 + 팁)

기존에 계산 프로퍼티에서 총합을 계산하는 부분만 추출해서 총합 계산 프로퍼티를 추가했다. Section을 추가한 뒤 Text의 인자로 계산 프로퍼티 값을 넣어서 보여주었다.

```Swift
Section("Grand total:") {
    Text(grandTotal, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
}
```

3. 팁 퍼센티지 피커가 segmented control을 보여주지 않고 새로운 화면으로 이동하도록 변경해보시오. 그리고 0% 부터 100% 까지의 다양한 옵션을 제공하시오.

일단 피커에서 다른 화면으로 이동해서 선택을 하게 하려면 .pickerStyle(.navigationLink) modifier로 변경해야한다. 그리고 Picker 내부에는 보여질 옵션들을 Text로 제공해야하는데 0% 부터 100%까지 보여주려면 ForEach 루프를 사용하는 것이 적절해보여서 이를 사용하여 구현했다.

```Swift
Picker("Tip percentage", selection: $tipPercentage) {
    ForEach(0...100, id: \.self) {
        Text($0, format: .percent)
    }
}
.pickerStyle(.navigationLink)
```


## Review for Project 1: WeSplit (프로젝트 1 돌아보기: WeSplit)

이 부분에서는 이번 프로젝트 관련 12개의 퀴즈가 있었다.

운이 좋게도 12개 문제에서 모두 정답을 골랐다. 이 퀴즈를 통해 이론적인 내용에 대해 복습을 꼼꼼히 할 수 있었다.


