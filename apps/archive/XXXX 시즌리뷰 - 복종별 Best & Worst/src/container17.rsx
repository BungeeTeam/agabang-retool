<Container
  id="container17"
  footerPadding="4px 12px"
  headerPadding="4px 12px"
  hidden="{{ get_item_list.data[item] == null }}"
  margin="0"
  padding="0"
  showBody={true}
  showBorder={false}
  style={{ ordered: [{ background: "canvas" }] }}
>
  <Header>
    <Text
      id="containerTitle20"
      value="#### Container title"
      verticalAlign="center"
    />
  </Header>
  <View id="1ed63" viewKey="View 1">
    <Text
      id="text27"
      heightType="fixed"
      horizontalAlign="center"
      margin="0"
      style={{ ordered: [] }}
      value="순위"
      verticalAlign="center"
    />
    <Divider id="divider6" margin="0" textSize="default" />
    <Text
      id="text28"
      heightType="fixed"
      horizontalAlign="center"
      margin="0"
      value="이미지"
      verticalAlign="center"
    />
    <Divider id="divider9" margin="0" textSize="default" />
    <Text
      id="text29"
      heightType="fixed"
      horizontalAlign="center"
      margin="0"
      value="품번"
      verticalAlign="center"
    />
    <Divider id="divider13" margin="0" textSize="default" />
    <Text
      id="text30"
      heightType="fixed"
      horizontalAlign="center"
      margin="0"
      value="품명"
      verticalAlign="center"
    />
    <Divider id="divider14" margin="0" textSize="default" />
    <Text
      id="text33"
      heightType="fixed"
      horizontalAlign="center"
      margin="0"
      value="컬러"
      verticalAlign="center"
    />
    <Divider id="divider15" margin="0" textSize="default" />
    <Text
      id="text32"
      heightType="fixed"
      horizontalAlign="center"
      margin="0"
      value="최초가"
      verticalAlign="center"
    />
    <Divider id="divider16" margin="0" textSize="default" />
    <Text
      id="text31"
      heightType="fixed"
      horizontalAlign="center"
      margin="0"
      value="입고량"
      verticalAlign="center"
    />
    <Divider id="divider17" margin="0" textSize="default" />
    <Text
      id="text34"
      heightType="fixed"
      horizontalAlign="center"
      margin="0"
      value="출고일"
      verticalAlign="center"
    />
    <Divider id="divider18" margin="0" textSize="default" />
    <Container
      id="container18"
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      padding="0"
      showBody={true}
      style={{ ordered: [{ background: "highlight" }, { border: "primary" }] }}
    >
      <Header>
        <Text
          id="containerTitle21"
          value="#### Container title"
          verticalAlign="center"
        />
      </Header>
      <View id="1ed63" viewKey="View 1">
        <Text
          id="text35"
          horizontalAlign="center"
          value="판매수량"
          verticalAlign="center"
        />
        <Text
          id="text36"
          horizontalAlign="center"
          value="소진률"
          verticalAlign="center"
        />
      </View>
    </Container>
    <Divider id="divider19" margin="0" textSize="default" />
    <Text
      id="text37"
      heightType="fixed"
      horizontalAlign="center"
      margin="0"
      value="원가(-)"
      verticalAlign="center"
    />
    <Divider id="divider20" margin="0" textSize="default" />
    <Text
      id="text38"
      heightType="fixed"
      horizontalAlign="center"
      margin="0"
      value="배수"
      verticalAlign="center"
    />
    <Spacer id="spacer13" />
  </View>
</Container>
