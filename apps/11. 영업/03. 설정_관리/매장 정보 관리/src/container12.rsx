<Container
  id="container12"
  _align="end"
  _direction="vertical"
  _gap="10px"
  _type="stack"
  footerPadding="4px 12px"
  headerPadding="0"
  margin="0"
  padding="10px"
  showBody={true}
  showBorder={false}
>
  <Header>
    <Text
      id="containerTitle14"
      value="###### 매장 추가"
      verticalAlign="center"
    />
  </Header>
  <View id="70ea3" viewKey="View 1">
    <Select
      id="shopHandoverSelect3"
      captionByIndex="{{ item.shop_cd }}"
      data="{{ getAllShopList.data }}"
      emptyMessage="No options"
      label="신규매장 선택"
      labelPosition="top"
      labels="{{ item.shop_nm }}"
      labelWidth="25"
      overlayMaxHeight={375}
      placeholder="매장명, 매장코드로 검색해 보세요"
      showClear={true}
      showSelectionIndicator={true}
      values="{{ item.shop_cd }}"
    >
      <Option id="c6e69" value="Option 1" />
      <Option id="11f40" value="Option 2" />
      <Option id="3b8d6" value="Option 3" />
    </Select>
    <Select
      id="shopHandoverSelect4"
      captionByIndex="{{ item.shop_cd }}"
      data="{{ getAllShopList.data }}"
      emptyMessage="No options"
      label="이전매장 선택"
      labelPosition="top"
      labels="{{ item.shop_nm }}"
      labelWidth="25"
      overlayMaxHeight={375}
      placeholder="매장명, 매장코드로 검색해 보세요"
      showClear={true}
      showSelectionIndicator={true}
      values="{{ item.shop_cd }}"
    >
      <Option id="c6e69" value="Option 1" />
      <Option id="11f40" value="Option 2" />
      <Option id="3b8d6" value="Option 3" />
    </Select>
    <Date
      id="shopHandoverDate2"
      dateFormat="yyyy-MM-dd"
      datePlaceholder="{{ self.dateFormat.toUpperCase() }}"
      iconBefore="bold/interface-calendar"
      label="인수인계 날짜"
      labelPosition="top"
      labelWidth="25"
    />
    <TextArea
      id="shopHandoverRemark2"
      autoResize={true}
      label="비고"
      labelPosition="top"
      labelWidth="25"
      minLines="5"
    />
    <Button id="shopHandoverAddButton2" heightType="auto" text="추가">
      <Event
        event="click"
        method="setValue"
        params={{
          ordered: [
            {
              value:
                "[{\nshop_cd: {{ shopHandoverSelect3.selectedItem?.shop_cd }},\nshop_nm: {{ shopHandoverSelect3.selectedItem?.shop_nm }},\nprev_shop_cd: {{ shopHandoverSelect4.selectedItem?.shop_cd }},\nprev_shop_nm: {{ shopHandoverSelect4.selectedItem?.shop_nm }},\nupdate_dt: {{ shopHandoverDate2.value }},\nremark: {{ shopHandoverRemark2.value }}\n}]",
            },
          ],
        }}
        pluginId="varInsertShopHandoverInfo"
        type="state"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        event="click"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="insertShopHandoverInfo"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </Button>
  </View>
</Container>
