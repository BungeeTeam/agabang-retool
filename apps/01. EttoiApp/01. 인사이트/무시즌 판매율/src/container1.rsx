<Container
  id="container1"
  footerPadding="4px 12px"
  headerPadding="4px 12px"
  padding="0"
  showBody={true}
>
  <View id="7b13c" viewKey="View 1">
    <Spacer id="spacer2" />
    <Text
      id="text13"
      style={{ ordered: [] }}
      value="#### 최근 4개년 무시즌 판매율"
      verticalAlign="center"
    />
    <Date
      id="date_select"
      dateFormat="yyyy-MM-dd"
      datePlaceholder="{{ self.dateFormat.toUpperCase() }}"
      hideLabel={true}
      label="마감기준일"
      labelPosition="top"
      margin="4px 40px 2px 0px"
      textBefore="마감기준일"
      value="{{ urlparams.hash?.deadline_date ?? (() => { const yesterday = new Date(); yesterday.setDate(yesterday.getDate() - 1); return yesterday.toISOString().split('T')[0]; })() }}"
    />
    <Switch
      id="inventory_columns_toggle"
      label="입출고 컬럼 숨기기"
      style={{
        ordered: [
          { checkedBackground: "#00a0e6" },
          { sharedLabelFontSize: "12px" },
          { sharedLabelFontWeight: "500" },
          { sharedLabelFontFamily: "pretendard variable" },
          { sharedLabel: "#464242" },
        ],
      }}
      value="{{ urlparams?.hash?.hide_columns ?? inventory_columns_toggle.value }}"
    />
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
