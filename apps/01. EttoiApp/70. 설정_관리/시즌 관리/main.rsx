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
  <DocumentTitle id="$customDocumentTitle" value="시즌관리 | ET" />
  <Include src="./header.rsx" />
  <Include src="./src/modalFrame1.rsx" />
  <Frame
    id="$main"
    enableFullBleed={false}
    isHiddenOnDesktop={false}
    isHiddenOnMobile={false}
    padding="8px 12px"
    sticky={null}
    type="main"
  >
    <Container
      id="container3"
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      margin="0"
      padding="0"
      showBody={true}
      showBorder={false}
      style={{ ordered: [{ background: "rgba(255, 255, 255, 0)" }] }}
    >
      <Header>
        <Text
          id="containerTitle3"
          value="#### 🖼️ {{ sel_season.value }} 이미지 관리"
          verticalAlign="center"
        />
      </Header>
      <View id="d4dac" viewKey="View 1">
        <Include src="./src/tabbedContainer1.rsx" />
      </View>
    </Container>
    <Table
      id="season_month_table"
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ get_season_month.data }}"
      defaultSelectedRow={{ mode: "none", indexType: "display", index: 0 }}
      disableSave=""
      emptyMessage="No rows found"
      enableSaveActions={true}
      primaryKeyColumnId="a5c4e"
      rowHeight="large"
      showBorder={true}
      showFooter={true}
      showHeader={true}
      toolbarPosition="bottom"
    >
      <Column
        id="a5c4e"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="true"
        key="id"
        label="ID"
        placeholder="Enter value"
        position="center"
        size={54}
      />
      <Column
        id="2c29a"
        alignment="center"
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="season"
        label="시즌"
        placeholder="Select option"
        position="center"
        size={100}
      />
      <Column
        id="a1a8d"
        alignment="center"
        editable="true"
        format="boolean"
        groupAggregationMode="none"
        key="month_1"
        label="1월"
        placeholder="Enter value"
        position="center"
        size={85}
      />
      <Column
        id="4161b"
        alignment="center"
        editable="true"
        format="boolean"
        groupAggregationMode="none"
        key="month_2"
        label="2월"
        placeholder="Enter value"
        position="center"
        size={78}
      />
      <Column
        id="1ff90"
        alignment="center"
        editable="true"
        format="boolean"
        groupAggregationMode="none"
        key="month_3"
        label="3월"
        placeholder="Enter value"
        position="center"
        size={73}
      />
      <Column
        id="2d2a7"
        alignment="center"
        editable="true"
        format="boolean"
        groupAggregationMode="none"
        key="month_4"
        label="4월"
        placeholder="Enter value"
        position="center"
        size={85}
      />
      <Column
        id="4f154"
        alignment="center"
        editable="true"
        format="boolean"
        groupAggregationMode="none"
        key="month_5"
        label="5월"
        placeholder="Enter value"
        position="center"
        size={82}
      />
      <Column
        id="4007d"
        alignment="center"
        editable="true"
        format="boolean"
        groupAggregationMode="none"
        key="month_6"
        label="6월"
        placeholder="Enter value"
        position="center"
        size={57}
      />
      <Column
        id="69965"
        alignment="center"
        cellTooltip="이렇게 호버"
        cellTooltipMode="custom"
        editable="true"
        format="boolean"
        groupAggregationMode="none"
        key="month_7"
        label="7월"
        placeholder="Enter value"
        position="center"
        size={70}
        summaryAggregationMode="none"
      />
      <Column
        id="68bcc"
        alignment="center"
        editable="true"
        format="boolean"
        groupAggregationMode="none"
        key="month_8"
        label="8월"
        placeholder="Enter value"
        position="center"
        size={68}
      />
      <Column
        id="64bf2"
        alignment="center"
        editable="true"
        format="boolean"
        groupAggregationMode="none"
        key="month_9"
        label="9월"
        placeholder="Enter value"
        position="center"
        size={72}
      />
      <Column
        id="51c33"
        alignment="center"
        editable="true"
        format="boolean"
        groupAggregationMode="none"
        key="month_10"
        label="10월"
        placeholder="Enter value"
        position="center"
        size={69}
      />
      <Column
        id="71b35"
        alignment="center"
        editable="true"
        format="boolean"
        groupAggregationMode="none"
        key="month_11"
        label="11월"
        placeholder="Enter value"
        position="center"
        size={74}
      />
      <Column
        id="f9e71"
        alignment="center"
        editable="true"
        format="boolean"
        groupAggregationMode="none"
        key="month_12"
        label="12월"
        placeholder="Enter value"
        position="center"
        size={85}
      />
      <Column
        id="8c98a"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        placeholder="Enter value"
        position="center"
        size={100}
      />
      <Event
        event="save"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="update_chages"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </Table>
  </Frame>
</App>
