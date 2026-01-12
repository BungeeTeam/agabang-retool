<Container
  id="stack4"
  _align="center"
  _direction="vertical"
  _flexWrap={true}
  _gap="0px"
  _type="stack"
  footerPadding="4px 12px"
  headerPadding="4px 12px"
  padding="12px"
  showBody={true}
  showBorder={false}
>
  <View id="210f0" viewKey="View 1">
    <Spacer id="spacer26" />
    <Text
      id="text15"
      horizontalAlign="center"
      value="#### 관련 페이지 링크를 입력해주세요"
      verticalAlign="center"
    />
    <Text
      id="text16"
      horizontalAlign="center"
      style={{
        ordered: [
          { fontSize: "15px" },
          { fontWeight: "400" },
          { fontFamily: "Pretendard Variable" },
        ],
      }}
      value="문의가 발생한 웹 페이지 주소를 아래 입력란에 붙여넣고 **다음** 버튼을 눌러주세요.
입력란이 이미 채워져 있다면 바로 **다음**을 눌러주시면 됩니다."
      verticalAlign="center"
    />
    <Spacer id="spacer6" />
    <TextInput
      id="url1"
      label=""
      labelPosition="top"
      placeholder="https://agabang.cleave.work/"
      style={{ ordered: [{ borderRadius: "400px" }] }}
      value="{{ url.hashParams?.url ?? '' }}"
    />
  </View>
</Container>
