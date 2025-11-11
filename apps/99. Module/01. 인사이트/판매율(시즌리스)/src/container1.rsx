<Container
  id="container1"
  footerPadding="4px 12px"
  headerPadding="4px 12px"
  padding="0"
  showBody={true}
>
  <View id="7b13c" viewKey="View 1">
    <Select
      id="season_select"
      data="{{ season_list_new.data }}"
      emptyMessage="No options"
      hidden="true"
      label="시즌 선택"
      labelPosition="top"
      labels="{{ item.year_nm}}"
      overlayMaxHeight={375}
      placeholder="Select an option"
      showSelectionIndicator={true}
      value="{{ self.data[0].year_sesn_cd }}"
      values="{{ item.year_sesn_cd}}"
    >
      <Event
        event="change"
        method="setValue"
        params={{ ordered: [] }}
        pluginId="var_sel_season"
        type="state"
        waitMs="0"
        waitType="debounce"
      />
    </Select>
    <Spacer id="spacer2" />
    <Text
      id="text13"
      style={{ ordered: [] }}
      value="#### 최근 4개년 무시즌 판매율"
      verticalAlign="center"
    />
    <Container
      id="stack1"
      _flexWrap={true}
      _gap="0px"
      _justify="end"
      _type="stack"
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      margin="0"
      padding="0"
      showBody={true}
      showBorder={false}
    >
      <View id="4b43b" viewKey="View 1">
        <Date
          id="date_select"
          dateFormat="yyyy-MM-dd"
          datePlaceholder="{{ self.dateFormat.toUpperCase() }}"
          hideLabel={true}
          label="마감기준일"
          labelPosition="top"
          margin="4px 40px 2px 0px"
          textBefore="마감기준일"
          value="{{ new Date().toISOString().split('T')[0] }}"
        />
      </View>
    </Container>
    <Text
      id="text14"
      margin="0"
      style={{
        ordered: [
          { fontSize: "11px" },
          { fontWeight: "400" },
          { fontFamily: "pretendard variable" },
        ],
      }}
      value="💡 무시즌 아이템의 카테고리별 판매율을 확인하고 복종, 아이템, 매장까지 세부적으로 분석할 수 있습니다."
      verticalAlign="center"
    />
    <Spacer id="spacer1" />
  </View>
</Container>
