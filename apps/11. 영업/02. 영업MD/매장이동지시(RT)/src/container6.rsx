<Container
  id="container6"
  footerPadding="4px 12px"
  headerPadding="4px 12px"
  margin="4px 4px"
  padding="0"
  showBody={true}
  style={{ ordered: [{ background: "rgba(255, 255, 255, 0)" }] }}
>
  <Header>
    <Text
      id="containerTitle10"
      value="#### Container title"
      verticalAlign="center"
    />
  </Header>
  <View id="ed310" viewKey="View 1">
    <Text id="text13" value="최소판매수량" verticalAlign="center" />
    <Text id="text27" value="추천점수" verticalAlign="center" />
    <Container
      id="stack5"
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
          id="text12"
          heightType="fill"
          margin="0"
          value="개 이상"
          verticalAlign="center"
        />
        <NumberInput
          id="minSalesInput"
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
    <Container
      id="stack10"
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
          id="text28"
          heightType="fill"
          margin="0"
          value="점 이상"
          verticalAlign="center"
        />
        <NumberInput
          id="minScoreInput"
          currency="USD"
          decimalPlaces="1"
          inputValue={0}
          label=""
          padDecimal={true}
          placeholder="Enter value"
          showSeparators={true}
          showStepper={true}
          value="3.2"
        >
          <Event
            event="submit"
            method="trigger"
            params={{ ordered: [] }}
            pluginId="rtListQuery"
            type="datasource"
            waitMs="0"
            waitType="debounce"
          />
        </NumberInput>
      </View>
    </Container>
    <Text id="text20" value="제외유통채널" verticalAlign="center" />
    <Text id="text26" value="제외매장" verticalAlign="center" />
    <Multiselect
      id="tpMultiSelect"
      data="{{ tpList.data }}"
      emptyMessage="No options"
      label=""
      labelPosition="top"
      labels="{{ item.tp_nm }}"
      overlayMaxHeight={375}
      placeholder="Select options"
      showSelectionIndicator={true}
      value={'["47"]'}
      values="{{ item.tp_cd }}"
      wrapTags={true}
    />
    <Multiselect
      id="shopMultiSelect"
      data="{{ shopList.data }}"
      emptyMessage="No options"
      label=""
      labelPosition="top"
      labels="{{ item.shop_nm }}"
      overlayMaxHeight={375}
      placeholder="Select options"
      showSelectionIndicator={true}
      values="{{ item.shop_cd }}"
      wrapTags={true}
    />
    <Text id="text17" value="보유재고수량" verticalAlign="center" />
    <Text id="text24" value="최근 판매일" verticalAlign="center" />
    <Container
      id="stack7"
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
          id="text16"
          heightType="fill"
          margin="0"
          value="개 이하"
          verticalAlign="center"
        />
        <NumberInput
          id="stockInput"
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
      id="stack9"
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
          id="text25"
          heightType="fill"
          margin="0"
          value="일 이내"
          verticalAlign="center"
        />
        <NumberInput
          id="salesPeriodInput"
          currency="USD"
          inputValue={0}
          label=""
          placeholder="Enter value"
          showSeparators={true}
          showStepper={true}
          value="14"
        />
      </View>
    </Container>
  </View>
</Container>
