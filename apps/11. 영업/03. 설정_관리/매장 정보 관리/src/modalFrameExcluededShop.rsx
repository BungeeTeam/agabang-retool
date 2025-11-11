<ModalFrame
  id="modalFrameExcluededShop"
  footerPadding="8px 12px"
  headerPadding="8px 12px"
  hidden={true}
  hideOnEscape={true}
  isHiddenOnMobile={true}
  overlayInteraction={true}
  padding="8px 12px"
  showHeader={true}
  showOverlay={true}
>
  <Header>
    <Text
      id="modalTitle1"
      value="###### 매출 제외 매장 추가"
      verticalAlign="center"
    />
    <Button
      id="modalCloseButton1"
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
        pluginId="modalFrameExcluededShop"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </Button>
  </Header>
  <Body>
    <Container
      id="container11"
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
          id="containerTitle13"
          value="###### 매장 추가"
          verticalAlign="center"
        />
      </Header>
      <View id="70ea3" viewKey="View 1">
        <Select
          id="excludedShopSelect2"
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
          id="excludedShopRemark2"
          autoResize={true}
          label="비고"
          labelPosition="top"
          labelWidth="25"
          minLines="5"
        />
        <Button id="excludedShopAddButton2" heightType="auto" text="추가">
          <Event
            event="click"
            method="setValue"
            params={{
              ordered: [
                {
                  value:
                    "[{\nshop_cd: {{ excludedShopSelect2.selectedItem?.shop_cd }},\nshop_nm: {{ excludedShopSelect2.selectedItem?.shop_nm }},\nremark: {{ excludedShopRemark2.value }}\n}]",
                },
              ],
            }}
            pluginId="varInsertExcludedShopInfo"
            type="state"
            waitMs="0"
            waitType="debounce"
          />
          <Event
            event="click"
            method="trigger"
            params={{ ordered: [] }}
            pluginId="insertExcludedShopInfo"
            type="datasource"
            waitMs="0"
            waitType="debounce"
          />
        </Button>
      </View>
    </Container>
  </Body>
</ModalFrame>
