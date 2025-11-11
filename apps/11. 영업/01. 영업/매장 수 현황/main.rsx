<App>
  <Include src="./functions.rsx" />
  <AppStyles id="$appStyles" css={include("./lib/$appStyles.css", "string")} />
  <Include src="./header.rsx" />
  <Frame
    id="$main"
    enableFullBleed={false}
    isHiddenOnDesktop={false}
    isHiddenOnMobile={false}
    padding="0"
    sticky={null}
    type="main"
  >
    <Container
      id="container5"
      _align="center"
      _gap="0px"
      _justify="space-between"
      _type="stack"
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      padding="12px"
      showBody={true}
    >
      <Header>
        <Text
          id="containerTitle5"
          value="#### Container title"
          verticalAlign="center"
        />
      </Header>
      <View id="133d6" viewKey="View 1">
        <Text
          id="text5"
          style={{ ordered: [] }}
          value="#### 매장 수 현황"
          verticalAlign="center"
        />
        <Container
          id="container6"
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
          <Header>
            <Text
              id="containerTitle6"
              value="#### Container title"
              verticalAlign="center"
            />
          </Header>
          <View id="133d6" viewKey="View 1">
            <Select
              id="bizDivSelect"
              data={
                '{{\n(() => {\n  const seen = new Set();\n  const result = shopInfoQuery\n    .data\n    .filter(item => {\n      const key = `${item.biz_cd}-${item.biz_nm}`;\n      if (seen.has(key)) return false;\n      seen.add(key);\n      return true;\n  })\n    //  .sort((a, b) => a.biz_cd - b.biz_cd)\n\n    //  .sort((a, b) => a.biz_nm.localeCompare(b.biz_nm, "ko"))\n\n  //  result.unshift({biz_cd: "-1", biz_nm: "전체"})\n\n  return result\n})()\n}}'
              }
              emptyMessage="No options"
              label=""
              labelPosition="top"
              labels="{{ item.biz_nm }}"
              overlayMaxHeight={375}
              placeholder="Select an option"
              showSelectionIndicator={true}
              textBefore="사업부"
              value="{{ current_user.groups.map(i => i.name).includes('admin') ? 'A1' :
  current_user.groups.map(i => i.name).includes('아가방 부문') ? 'A1' : 
  current_user.groups.map(i => i.name).includes('에뜨와 부문') ? 'A4' : 
  current_user.groups.map(i => i.name).includes('디즈니 부문') ? 'DS':'A1'}}"
              values="{{ item.biz_cd }}"
            />
            <Date
              id="referenceDate"
              dateFormat="yyyy-MM-dd"
              datePlaceholder="{{ self.dateFormat.toUpperCase() }}"
              iconBefore="bold/interface-calendar"
              label=""
              labelPosition="top"
              textBefore="마감일자"
              value="{{ moment().subtract(1,'days').format('YYYY-MM-DD') }}"
            />
          </View>
        </Container>
      </View>
    </Container>
    <Include src="./src/container11.rsx" />
    <Include src="./src/container16.rsx" />
    <Include src="./src/collapsibleContainer1.rsx" />
    <Text
      id="text25"
      value="##### [채널별 매장 수 현황]"
      verticalAlign="center"
    />
    <Text
      id="text50"
      disableMarkdown={true}
      horizontalAlign="right"
      value="* 단위: 매장 - 개, 금액 - 백만원"
      verticalAlign="center"
    />
    <Table
      id="table4"
      autoColumnWidth={true}
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ groupByChannel.value }}"
      defaultSelectedRow={{ mode: "none", indexType: "display", index: 0 }}
      emptyMessage="No rows found"
      enableSaveActions={true}
      heightType="auto"
      rowBackgroundColor="{{ currentSourceRow.tp_nm === '총계' ? '#01488F33' : '' }}"
      showBorder={true}
      showHeader={true}
    >
      <Column
        id="31bba"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="tp_nm"
        label="채널명"
        placeholder="Enter value"
        position="center"
        size={124.28125}
        sortMode="disabled"
        summaryAggregationMode="none"
      />
      <Column
        id="05ff2"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="curr_open"
        label="금년 매장수 (A)"
        placeholder="Enter value"
        position="center"
        size={100}
      />
      <Column
        id="372e6"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="prev_open"
        label="작년 매장수 (B)"
        placeholder="Enter value"
        position="center"
        size={100}
      />
      <Column
        id="8c2e1"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        label="매장 수 증감 (A-B)"
        placeholder="Enter value"
        position="center"
        referenceId="매장수증감AB"
        size={138}
        summaryAggregationMode="none"
        textColor={'{{ item >= 0 ? "black"  : "red" }}'}
        valueOverride="{{ currentSourceRow.curr_open-currentSourceRow.prev_open }}"
      />
      <Column
        id="34589"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="new_opened"
        label="금년 오픈"
        placeholder="Enter value"
        position="center"
        size={100}
      />
      <Column
        id="bc7de"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="opened"
        label="기존 운영"
        placeholder="Enter value"
        position="center"
        size={100}
      />
      <Column
        id="0fefe"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="new_closed"
        label="금년 폐점"
        placeholder="Enter value"
        position="center"
        size={100}
      />
      <Column
        id="c7b72"
        alignment="right"
        cellTooltip="{{ (item*1000000).toLocaleString()}}"
        cellTooltipMode="custom"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        key="rev_01"
        label="금년 매출 (C)"
        placeholder="Enter value"
        position="center"
        size={172}
        summaryAggregationMode="none"
        valueOverride="{{ item/1000000 }}"
      />
      <Column
        id="3a25a"
        alignment="right"
        cellTooltip="{{ (item*1000000).toLocaleString()}}"
        cellTooltipMode="custom"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "o",
        }}
        groupAggregationMode="sum"
        key="rev_02"
        label="작년 매출 (D)"
        placeholder="Enter value"
        position="center"
        referenceId="b"
        size={162}
        summaryAggregationMode="none"
        valueOverride="{{ item/1000000 }}"
      />
      <Column
        id="741c5"
        alignment="right"
        cellTooltip="{{ (item*1000000).toLocaleString()}}"
        cellTooltipMode="custom"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        label="매출증감 (C-D)"
        placeholder="Enter value"
        position="center"
        referenceId="매출 증감CD"
        size={100}
        summaryAggregationMode="none"
        textColor={'{{ item >= 0 ? "black" : "red" }}'}
        valueOverride="{{ (currentSourceRow.rev_01 - currentSourceRow.rev_02)/1000000 }}"
      />
      <Column
        id="0aa21"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "1",
          padDecimal: true,
        }}
        groupAggregationMode="average"
        label="매출증감율"
        placeholder="Enter value"
        position="center"
        referenceId="매출 증감율"
        size={100}
        summaryAggregationMode="none"
        textColor={'{{ item >= 0 ? "black" : "red" }}'}
        valueOverride="{{ (currentSourceRow.rev_01/ currentSourceRow.rev_02)-1}}"
      />
      <ToolbarButton
        id="1a"
        icon="bold/interface-text-formatting-filter-2"
        label="필터"
        type="filter"
      />
      <ToolbarButton
        id="3c"
        icon="bold/interface-download-button-2"
        label="엑셀 다운로드"
        type="custom"
      >
        <Event
          event="clickToolbar"
          method="exportData"
          params={{
            ordered: [
              {
                options: {
                  ordered: [
                    { fileType: "xlsx" },
                    {
                      fileName:
                        "shop_count_by_channel_{{ referenceDate.value }}",
                    },
                    { includeHiddenColumns: false },
                  ],
                },
              },
            ],
          }}
          pluginId="table4"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
      <Event
        event="clickRow"
        method="setValue"
        params={{ ordered: [{ value: "{{ currentSourceRow }}" }] }}
        pluginId="varSelectedChannel"
        type="state"
        waitMs="0"
        waitType="debounce"
      />
    </Table>
    <Container
      id="stack1"
      _align="center"
      _flexWrap={true}
      _gap="0px"
      _type="stack"
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      margin="0"
      padding="0"
      showBody={true}
      showBorder={false}
      style={{ ordered: [{ background: "rgba(255, 255, 255, 0)" }] }}
    >
      <View id="64367" viewKey="View 1">
        <Button
          id="closeButton2"
          ariaLabel="Close"
          heightType="auto"
          horizontalAlign="right"
          iconBefore="bold/interface-arrows-synchronize"
          margin="0"
          style={{ ordered: [{ border: "transparent" }] }}
          styleVariant="outline"
          text="초기화"
        >
          <Event
            event="click"
            method="run"
            params={{ ordered: [{ src: "varSelectedChannel.setValue(null)" }] }}
            pluginId=""
            type="script"
            waitMs="0"
            waitType="debounce"
          />
        </Button>
        <Text
          id="text48"
          value="##### [매장 리스트] ({{addTotal.value.length-1}})"
          verticalAlign="center"
        />
      </View>
    </Container>
    <Tabs
      id="tabs4"
      itemMode="static"
      margin="4px 12px"
      value="{{ self.values[0] }}"
    >
      <Option id="a27a3" label="전체" value="전체" />
      <Option id="232b5" label="금년 오픈" value="금년 오픈" />
      <Option id="a74b6" label="기존 운영" value="기존 운영" />
      <Option
        id="65033"
        disabled={false}
        hidden={false}
        iconPosition="left"
        label="금년 폐점"
        value="금년 폐점"
      />
      <Option
        id="f05a5"
        disabled={false}
        hidden={false}
        iconPosition="left"
        label="과거 폐점"
        value="과거 폐점"
      />
      <Event
        event="change"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="getShopStat"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </Tabs>
    <Text
      id="text51"
      disableMarkdown={true}
      horizontalAlign="right"
      value="* 단위: 매장 - 개, 금액 - 백만원"
      verticalAlign="center"
    />
    <Table
      id="table5"
      autoColumnWidth={true}
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ addTotal.value }}"
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      emptyMessage="No rows found"
      enableSaveActions={true}
      rowBackgroundColor="{{ currentSourceRow.tp_nm === '총계' ? '#01488F33' : '' }}"
      showBorder={true}
      showFooter={true}
      showHeader={true}
    >
      <Column
        id="8f8f0"
        alignment="left"
        format="string"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="tp_nm"
        label="채널명"
        placeholder="Enter value"
        position="left"
        size={67.90625}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="1212c"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="shop_nm"
        label="매장명"
        placeholder="Enter value"
        position="left"
        size={171.703125}
        summaryAggregationMode="none"
      >
        <Event
          event="clickCell"
          method="run"
          params={{
            ordered: [
              {
                src: "utils.copyToClipboard(currentSourceRow.shop_cd)\n\nutils.showNotification(\n  {\n    title: '복사완료',\n   description: '매장코드가 클립보드에 복사되었습니다.',\n    notificationType: \"success\"\n  }\n)",
              },
            ],
          }}
          pluginId=""
          type="script"
          waitMs="0"
          waitType="debounce"
        />
      </Column>
      <Column
        id="d8821"
        alignment="left"
        editableOptions={{ showStepper: true }}
        format="tag"
        formatOptions={{
          automaticColors: false,
          color: "{{ item === '운영' ? 'skyblue' : 'pink' }}",
        }}
        groupAggregationMode="sum"
        key="stat"
        label="운영 여부"
        placeholder="Select option"
        position="left"
        referenceId="open_yn"
        size={60.890625}
        summaryAggregationMode="none"
        valueOverride="{{ item.slice(-2) }}"
      />
      <Column
        id="70882"
        alignment="center"
        format="string"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="stat"
        label="매장 상태"
        placeholder="Enter value"
        position="center"
        referenceId="stat"
        size={60.890625}
        summaryAggregationMode="none"
        valueOverride="{{ item }}"
      />
      <Column
        id="cb02d"
        alignment="center"
        format="date"
        formatOptions={{ dateFormat: "yyyy-MM-dd" }}
        groupAggregationMode="none"
        key="open_dt"
        label="개점일"
        placeholder="Enter value"
        position="center"
        size={86.078125}
        summaryAggregationMode="none"
      />
      <Column
        id="ab29b"
        alignment="center"
        format="date"
        formatOptions={{ dateFormat: "yyyy-MM-dd" }}
        groupAggregationMode="none"
        key="close_dt"
        label="폐점일"
        placeholder="Enter value"
        position="center"
        size={86.328125}
        summaryAggregationMode="none"
        valueOverride="{{ item > '2149-01-01' ? '' : item}}"
      />
      <Column
        id="c7b72"
        alignment="right"
        cellTooltip="{{ (item*1000000).toLocaleString()}}"
        cellTooltipMode="custom"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        key="rev_01"
        label="금년 매출 (C)"
        placeholder="Enter value"
        position="center"
        size={81.6875}
        summaryAggregationMode="none"
        valueOverride="{{ item/1000000 }}"
      />
      <Column
        id="3a25a"
        alignment="right"
        cellTooltip="{{ (item*1000000).toLocaleString()}}"
        cellTooltipMode="custom"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "o",
        }}
        groupAggregationMode="sum"
        key="rev_02"
        label="작년 매출 (D)"
        placeholder="Enter value"
        position="center"
        referenceId="b"
        size={81.59375}
        summaryAggregationMode="none"
        valueOverride="{{ item/1000000 }}"
      />
      <Column
        id="741c5"
        alignment="right"
        cellTooltip="{{ (item*1000000).toLocaleString()}}"
        cellTooltipMode="custom"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        label="매출증감 (C-D)"
        placeholder="Enter value"
        position="center"
        referenceId="매출 증감CD"
        size={92.46875}
        summaryAggregationMode="none"
        textColor={'{{ item >= 0 ? "black" : "red" }}'}
        valueOverride="{{ (currentSourceRow.rev_01 - currentSourceRow.rev_02)/1000000 }}"
      />
      <Column
        id="0aa21"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "1",
          padDecimal: true,
        }}
        groupAggregationMode="average"
        label="매출증감율"
        placeholder="Enter value"
        position="center"
        referenceId="매출 증감율"
        size={67.90625}
        summaryAggregationMode="none"
        textColor={'{{ item >= 0 ? "black" : "red" }}'}
        valueOverride="{{ (currentSourceRow.rev_01/ currentSourceRow.rev_02)-1}}"
      />
      <Column
        id="9069c"
        alignment="left"
        editableOptions={{ showStepper: true }}
        format="string"
        formatOptions={{ showSeparators: false, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="true"
        key="shop_cd"
        label="매장코드"
        placeholder="Enter value"
        position="center"
        size={58.578125}
        summaryAggregationMode="none"
        valueOverride="{{ item }}"
      />
      <ToolbarButton
        id="1a"
        icon="bold/interface-text-formatting-filter-2"
        label="필터"
        type="filter"
      />
      <ToolbarButton
        id="3c"
        icon="bold/interface-download-button-2"
        label="엑셀 다운로드"
        type="custom"
      >
        <Event
          event="clickToolbar"
          method="exportData"
          params={{
            ordered: [
              {
                options: {
                  ordered: [
                    { fileType: "xlsx" },
                    {
                      fileName:
                        "shop_count_by_channel_{{ referenceDate.value }}",
                    },
                    { includeHiddenColumns: false },
                  ],
                },
              },
            ],
          }}
          pluginId="table5"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
    </Table>
  </Frame>
</App>
