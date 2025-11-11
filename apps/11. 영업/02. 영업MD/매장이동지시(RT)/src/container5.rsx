<Container
  id="container5"
  footerPadding="4px 12px"
  headerPadding="4px 12px"
  margin="4px 4px"
  padding="0"
  showBody={true}
  style={{ ordered: [{ background: "rgba(255, 255, 255, 0)" }] }}
>
  <Header>
    <Text
      id="containerTitle9"
      value="#### Container title"
      verticalAlign="center"
    />
  </Header>
  <View id="ed310" viewKey="View 1">
    <Text id="text7" value="매장재고보유기간" verticalAlign="center" />
    <Text id="text29" value="보유재고수량" verticalAlign="center" />
    <Container
      id="stack2"
      _gap="0px"
      _type="stack"
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      margin="0"
      padding="0"
      showBody={true}
      style={{
        ordered: [
          { background: "rgba(255, 255, 255, 0)" },
          { borderRadius: "4px" },
          { border: "rgba(0, 0, 0, 0)" },
        ],
      }}
    >
      <View id="3ec83" viewKey="View 1">
        <Text
          id="text6"
          heightType="fill"
          margin="0"
          value="일 이상"
          verticalAlign="center"
        />
        <NumberInput
          id="durationNumberInput"
          currency="USD"
          inputValue={0}
          label=""
          placeholder="Enter value"
          showSeparators={true}
          showStepper={true}
          value="28"
        />
      </View>
    </Container>
    <Container
      id="stack11"
      _gap="0px"
      _type="stack"
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      margin="0"
      padding="0"
      showBody={true}
      style={{
        ordered: [
          { background: "rgba(255, 255, 255, 0)" },
          { borderRadius: "4px" },
          { border: "rgba(0, 0, 0, 0)" },
        ],
      }}
    >
      <View id="3ec83" viewKey="View 1">
        <Text
          id="text30"
          heightType="fill"
          margin="0"
          value="개 이상"
          verticalAlign="center"
        />
        <NumberInput
          id="minHoldInput"
          currency="USD"
          inputValue={0}
          label=""
          placeholder="Enter value"
          showSeparators={true}
          showStepper={true}
          value="2"
        />
      </View>
    </Container>
    <Text id="text23" value="물류보유재고" verticalAlign="center" />
    <Text id="text11" value="판매수량" verticalAlign="center" />
    <Container
      id="stack4"
      _gap="0px"
      _type="stack"
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      margin="0"
      padding="0"
      showBody={true}
      style={{
        ordered: [
          { background: "rgba(255, 255, 255, 0)" },
          { borderRadius: "4px" },
          { border: "rgba(0, 0, 0, 0)" },
        ],
      }}
    >
      <View id="3ec83" viewKey="View 1">
        <Text
          id="text10"
          heightType="fill"
          margin="0"
          value="개 이하"
          verticalAlign="center"
        />
        <NumberInput
          id="salesNumberInput"
          currency="USD"
          inputValue={0}
          label=""
          placeholder="Enter value"
          showSeparators={true}
          showStepper={true}
          value="1"
        />
      </View>
    </Container>
    <Container
      id="stack8"
      _gap="0px"
      _type="stack"
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      margin="0"
      padding="0"
      showBody={true}
      style={{
        ordered: [
          { background: "rgba(255, 255, 255, 0)" },
          { borderRadius: "4px" },
          { border: "rgba(0, 0, 0, 0)" },
        ],
      }}
    >
      <View id="3ec83" viewKey="View 1">
        <Text
          id="text22"
          heightType="fill"
          margin="0"
          value="개 이하"
          verticalAlign="center"
        />
        <NumberInput
          id="inventoryInput"
          currency="USD"
          inputValue={0}
          label=""
          placeholder="Enter value"
          showSeparators={true}
          showStepper={true}
          value="3"
        />
      </View>
    </Container>
    <Text id="text9" value="판매율" verticalAlign="center" />
    <Container
      id="stack3"
      _gap="0px"
      _type="stack"
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      margin="0"
      padding="0"
      showBody={true}
      style={{
        ordered: [
          { background: "rgba(255, 255, 255, 0)" },
          { borderRadius: "4px" },
          { border: "rgba(0, 0, 0, 0)" },
        ],
      }}
    >
      <View id="3ec83" viewKey="View 1">
        <Text
          id="text8"
          heightType="fill"
          margin="0"
          value="(%) 이하"
          verticalAlign="center"
        />
        <NumberInput
          id="salesPercentNumberInput"
          currency="USD"
          inputValue={0}
          label=""
          placeholder="Enter value"
          showSeparators={true}
          showStepper={true}
          value="30"
        />
      </View>
    </Container>
  </View>
</Container>
