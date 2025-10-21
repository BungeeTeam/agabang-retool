<App>
  <Include src="./functions.rsx" />
  <CustomAppTheme
    id="$appTheme"
    _migrated={true}
    automatic={[
      "#fde68a",
      "#eecff3",
      "#a7f3d0",
      "#bfdbfe",
      "#c7d2fe",
      "#fecaca",
      "#fcd6bb",
    ]}
    borderRadius="4px"
    canvas="#f6f6f6"
    danger="#dc2626"
    defaultFont={{
      size: "12px",
      name: '"Pretendard Variable", Pretendard, -apple-system, BlinkMacSystemFont, system-ui, Roboto, "Helvetica Neue", "Segoe UI", "Apple SD Gothic Neo", "Noto Sans KR", "Malgun Gothic", "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol", sans-serif',
      source:
        "https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard.min.css",
    }}
    h1Font={{ size: "36px" }}
    h2Font={{ size: "28px" }}
    h3Font={{ size: "24px" }}
    h4Font={{ size: "18px" }}
    h5Font={{ size: "16px" }}
    h6Font={{ size: "14px" }}
    highlight="#fde68a"
    info="#3170f9"
    primary="#dd5e2c"
    secondary="#4f6d7a"
    success="#059669"
    surfacePrimary="#ffffff"
    surfacePrimaryBorder=""
    surfaceSecondary="#ffffff"
    surfaceSecondaryBorder=""
    tertiary=""
    textDark="#0d0d0d"
    textLight="#ffffff"
    warning="#cd6f00"
  />
  <AppStyles id="$appStyles" css={include("./lib/$appStyles.css", "string")} />
  <GlobalWidgetProp id="brand_code" description="브랜드 코드 입력" value="01" />
  <Include src="./src/modalFrame1.rsx" />
  <Include src="./sidebar.rsx" />
  <Frame
    id="$main"
    enableFullBleed={false}
    isHiddenOnDesktop={false}
    isHiddenOnMobile={false}
    padding="8px 12px"
    sticky={null}
    type="main"
  >
    <ModuleContainerWidget
      id="moduleContainer"
      backgroundColor="white"
      brand_code="01"
      isGlobalWidgetContainer={true}
      margin="0"
    >
      <Include src="./src/container4.rsx" />
      <Text
        id="modalTitle1"
        heightType="fixed"
        value="#### {{sel_s3_key.value.split('/')[2] }}"
        verticalAlign="center"
      />
      <Image
        id="image3"
        fit="contain"
        heightType="fixed"
        horizontalAlign="center"
        src="https://ettoi-image.s3.ap-northeast-2.amazonaws.com/{{encodeURIComponent(sel_s3_key.value)}}"
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
          pluginId="modalFrame1"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </Button>
      <Container
        id="container6"
        footerPadding="4px 12px"
        headerPadding="4px 12px"
        heightType="fixed"
        padding="12px"
        showBody={true}
        showHeader={true}
      >
        <Header>
          <Text
            id="containerTitle6"
            value="#### 매칭 완료 리스트"
            verticalAlign="center"
          />
        </Header>
        <View id="6940f" viewKey="View 1">
          <TextInput
            id="textInput1"
            iconAfter="bold/interface-search"
            label=""
            labelPosition="top"
            placeholder="Enter value"
            style={{ ordered: [{ borderRadius: "20px" }] }}
          />
          <Table
            id="reorder_match_table"
            actionsOverflowPosition={1}
            cellSelection="none"
            clearChangesetOnSave={true}
            data="{{ get_matched_list.data }}"
            defaultSelectedRow={{
              mode: "index",
              indexType: "display",
              index: 0,
            }}
            emptyMessage="매칭된 아이템이 없습니다."
            enableSaveActions={true}
            rowHeight="medium"
            rowSelection="none"
            searchTerm="{{ textInput1.value }}"
            showFooter={true}
            showHeader={true}
            toolbarPosition="bottom"
          >
            <Column
              id="a0a8c"
              alignment="center"
              format="string"
              groupAggregationMode="none"
              label="No."
              placeholder="Enter value"
              position="center"
              size={75}
              summaryAggregationMode="none"
              valueOverride="{{ i+1 }}"
            />
            <Column
              id="ae864"
              alignment="center"
              format="image"
              formatOptions={{ widthType: "fit" }}
              groupAggregationMode="none"
              hidden="false"
              key="sty_cd"
              label="제품 사진"
              placeholder="Enter value"
              position="center"
              size={87}
              summaryAggregationMode="none"
              valueOverride="https://agabang-image.s3.ap-northeast-2.amazonaws.com/item_final/{{ item }}.jpg
"
            />
            <Column
              id="4103c"
              alignment="center"
              caption="{{ currentSourceRow.reorder_sty_cd }}"
              format="string"
              formatOptions={{ automaticColors: true }}
              groupAggregationMode="none"
              key="reorder_sty_nm"
              label="리오더 스타일"
              placeholder="Enter value"
              position="center"
              size={191.28125}
              summaryAggregationMode="none"
              valueOverride="{{ item }}"
            />
            <Column
              id="d21c8"
              alignment="left"
              format="string"
              groupAggregationMode="none"
              hidden="true"
              key="sty_cd"
              label="Sty cd"
              placeholder="Enter value"
              position="center"
              size={82.28125}
              summaryAggregationMode="none"
            />
            <Column
              id="04606"
              alignment="center"
              caption="{{ currentSourceRow.sty_cd }}"
              format="string"
              groupAggregationMode="none"
              key="sty_nm"
              label="매칭 스타일"
              placeholder="Enter value"
              position="center"
              size={127.28125}
              summaryAggregationMode="none"
            />
            <Column
              id="3c390"
              alignment="left"
              format="string"
              groupAggregationMode="none"
              hidden="true"
              key="reorder_sty_cd"
              label="Reorder sty cd"
              placeholder="Enter value"
              position="center"
              size={100}
              summaryAggregationMode="none"
            />
            <Action id="418b8" icon="bold/interface-delete-bin-2" label="삭제">
              <Event
                event="clickAction"
                method="trigger"
                params={{ ordered: [] }}
                pluginId="delete_match"
                type="datasource"
                waitMs="0"
                waitType="debounce"
              />
              <Event
                event="clickAction"
                method="trigger"
                params={{ ordered: [] }}
                pluginId="get_matched_list"
                type="datasource"
                waitMs="0"
                waitType="debounce"
              />
              <Event
                event="clickAction"
                method="setValue"
                params={{ ordered: [{ value: "{{ currentSourceRow }}" }] }}
                pluginId="delete_item"
                type="state"
                waitMs="0"
                waitType="debounce"
              />
            </Action>
            <ToolbarButton
              id="1a"
              icon="bold/interface-text-formatting-filter-2"
              label="Filter"
              type="filter"
            />
            <ToolbarButton
              id="3c"
              icon="bold/interface-download-button-2"
              label="Download"
              type="custom"
            >
              <Event
                event="clickToolbar"
                method="exportData"
                pluginId="reorder_match_table"
                type="widget"
                waitMs="0"
                waitType="debounce"
              />
            </ToolbarButton>
            <ToolbarButton
              id="4d"
              icon="bold/interface-arrows-round-left"
              label="Refresh"
              type="custom"
            >
              <Event
                event="clickToolbar"
                method="refresh"
                pluginId="reorder_match_table"
                type="widget"
                waitMs="0"
                waitType="debounce"
              />
            </ToolbarButton>
          </Table>
        </View>
      </Container>
    </ModuleContainerWidget>
  </Frame>
</App>
