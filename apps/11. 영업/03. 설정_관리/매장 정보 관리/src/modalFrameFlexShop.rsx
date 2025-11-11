<ModalFrame
  id="modalFrameFlexShop"
  footerPadding="8px 12px"
  headerPadding="8px 12px"
  hidden={true}
  hideOnEscape={true}
  isHiddenOnMobile={true}
  overlayInteraction={true}
  padding="0"
  showHeader={true}
  showOverlay={true}
>
  <Header>
    <Text
      id="modalTitle3"
      value="###### 플렉스 매장 추가"
      verticalAlign="center"
    />
    <Button
      id="modalCloseButton3"
      ariaLabel="Close"
      horizontalAlign="right"
      iconBefore="bold/interface-delete-1"
      style={{ ordered: [{ border: "transparent" }] }}
      styleVariant="outline"
    >
      <Event
        event="click"
        method="setHidden"
        params={{ ordered: [{ hidden: true }] }}
        pluginId="modalFrameFlexShop"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </Button>
  </Header>
  <Body>
    <Container
      id="container10"
      _align="center"
      _direction="vertical"
      _gap="10px"
      _type="stack"
      footerPadding="4px 12px"
      headerPadding="0"
      padding="10px"
      showBody={true}
      showBorder={false}
    >
      <Header>
        <Text
          id="containerTitle12"
          style={{
            ordered: [
              { fontSize: "12px" },
              { fontWeight: "500" },
              { fontFamily: "Pretendard Variable" },
            ],
          }}
          value="###### 매장 추가"
          verticalAlign="center"
        />
      </Header>
      <View id="70ea3" viewKey="View 1">
        <Select
          id="flexShopSelect"
          captionByIndex="{{ item.shop_cd }}"
          data="{{ getAllShopList.data }}"
          emptyMessage="No options"
          label="매장 선택"
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
        <TextArea
          id="flexShopRemark"
          autoResize={true}
          label="비고"
          labelPosition="top"
          labelWidth="25"
          minLines="5"
          placeholder="매장에 대한 추가 정보를 입력하세요"
        />
        <Button id="flexShopAddButton" heightType="auto" text="추가">
          <Event
            event="click"
            method="setValue"
            params={{
              ordered: [
                {
                  value:
                    "[{\nshop_cd: {{ flexShopSelect.selectedItem?.shop_cd }},\nshop_nm: {{ flexShopSelect.selectedItem?.shop_nm }},\nremark: {{ flexShopRemark.value }}\n}]",
                },
              ],
            }}
            pluginId="varInsertFlexShopInfo"
            type="state"
            waitMs="0"
            waitType="debounce"
          />
          <Event
            event="click"
            method="trigger"
            params={{ ordered: [] }}
            pluginId="insertFlexShopInfo"
            type="datasource"
            waitMs="0"
            waitType="debounce"
          />
          <Event
            event="click"
            method="clearValue"
            params={{ ordered: [{ value: "null" }] }}
            pluginId="flexShopSelect"
            type="widget"
            waitMs="0"
            waitType="debounce"
          />
        </Button>
      </View>
    </Container>
  </Body>
</ModalFrame>
