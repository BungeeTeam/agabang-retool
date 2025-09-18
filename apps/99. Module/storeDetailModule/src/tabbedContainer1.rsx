<Container
  id="tabbedContainer1"
  currentViewKey="{{ self.viewKeys[0] }}"
  footerPadding="4px 12px"
  headerPadding="0px 4px"
  margin="0"
  padding="0"
  showBody={true}
  showHeader={true}
>
  <Header>
    <Tabs
      id="tabs2"
      itemMode="static"
      targetContainerId="tabbedContainer1"
      value="{{ self.values[0] }}"
    >
      <Option id="d33bf" label="전체" value="'-1'" />
      <Option id="c5e21" label="아가방" value="'A1'" />
      <Option id="0c34c" label="에뜨와" value="'A4'" />
      <Option
        id="543c3"
        disabled={false}
        hidden={false}
        iconPosition="left"
        label="디즈니"
        value="'DS'"
      />
    </Tabs>
  </Header>
  <View id="f2e66" label="전체" viewKey="'-1'">
    <Table
      id="table41"
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ shopSalesByMonth.value }}"
      defaultSelectedRow={{ mode: "none", indexType: "display", index: 0 }}
      emptyMessage="No rows found"
      enableSaveActions={true}
      heightType="auto"
      margin="px 8px"
      rowBackgroundColor="{{ currentSourceRow.구분.slice(-2) === '실적' ? '01488f33' : 'ffffff' }}"
      rowHeight="small"
      rowSelection="none"
      showBorder={true}
      showColumnBorders={true}
      showHeader={true}
      style={{ headerBackground: "tokens/356f4e7b" }}
    >
      <Column
        id="fdee4"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="구분"
        label="구분"
        placeholder="Enter value"
        position="center"
        size={121.796875}
        sortMode="disabled"
        summaryAggregationMode="none"
      />
      <Column
        id="a8b37"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="string"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="total"
        label="합계"
        placeholder="Enter value"
        position="center"
        size={114.203125}
        summaryAggregationMode="none"
        textColor="{{ currentSourceRow.구분 === '목표달성율' && currentSourceRow.total < 1  ? 'red' : 
  currentSourceRow.구분 !== '목표달성율' && currentSourceRow.total < 0 ? 'red' : 'black' }}"
        valueOverride="{{ self.data[0].total === 0 ? null : 
  Math.abs(item) < 2 ? (item*100).toFixed(1) + '%' : Number((item/1000).toFixed(0)).toLocaleString() }}"
      />
      <Column
        id="0f13a"
        alignment="right"
        format="string"
        groupAggregationMode="none"
        key="jan"
        label="1월"
        placeholder="Enter value"
        position="center"
        size={99.21875}
        summaryAggregationMode="none"
        textColor="{{ currentSourceRow.구분 === '목표달성율' && currentSourceRow.jan < 1  ? 'red' : 
  currentSourceRow.구분 !== '목표달성율' && currentSourceRow.jan < 0 ? 'red' : 'black' }}"
        valueOverride="{{ item === null ? null : 
  Math.abs(item) === 0 ? 0 : 
  Math.abs(item) < 2 ? (item*100).toFixed(1) + '%' : Number((item/1000).toFixed(0)).toLocaleString() }}"
      />
      <Column
        id="4943a"
        alignment="right"
        format="string"
        groupAggregationMode="none"
        key="feb"
        label="2월"
        placeholder="Enter value"
        position="center"
        size={105.65625}
        summaryAggregationMode="none"
        textColor="{{ currentSourceRow.구분 === '목표달성율' && currentSourceRow.feb < 1  ? 'red' : 
  currentSourceRow.구분 !== '목표달성율' && currentSourceRow.feb < 0 ? 'red' : 'black' }}"
        valueOverride="{{ item === null ? null : 
  Math.abs(item) === 0 ? 0 : 
  Math.abs(item) < 2 ? (item*100).toFixed(1) + '%' : Number((item/1000).toFixed(0)).toLocaleString() }}"
      />
      <Column
        id="de687"
        alignment="right"
        format="string"
        groupAggregationMode="none"
        key="mar"
        label="3월"
        placeholder="Enter value"
        position="center"
        size={96.109375}
        summaryAggregationMode="none"
        textColor="{{ currentSourceRow.구분 === '목표달성율' && currentSourceRow.mar < 1  ? 'red' : 
  currentSourceRow.구분 !== '목표달성율' && currentSourceRow.mar < 0 ? 'red' : 'black' }}"
        valueOverride="{{ item === null ? null : 
  Math.abs(item) === 0 ? 0 : 
  Math.abs(item) < 2 ? (item*100).toFixed(1) + '%' : Number((item/1000).toFixed(0)).toLocaleString() }}"
      />
      <Column
        id="98a93"
        alignment="right"
        format="string"
        groupAggregationMode="none"
        key="apr"
        label="4월"
        placeholder="Enter value"
        position="center"
        size={104.234375}
        summaryAggregationMode="none"
        textColor="{{ currentSourceRow.구분 === '목표달성율' && currentSourceRow.apr < 1  ? 'red' : 
  currentSourceRow.구분 !== '목표달성율' && currentSourceRow.apr < 0 ? 'red' : 'black' }}"
        valueOverride="{{ item === null ? null : 
  Math.abs(item) === 0 ? 0 : 
  Math.abs(item) < 2 ? (item*100).toFixed(1) + '%' : Number((item/1000).toFixed(0)).toLocaleString() }}"
      />
      <Column
        id="d6034"
        alignment="right"
        format="string"
        groupAggregationMode="none"
        key="may"
        label="5월"
        placeholder="Enter value"
        position="center"
        size={94.671875}
        summaryAggregationMode="none"
        textColor="{{ currentSourceRow.구분 === '목표달성율' && currentSourceRow.may < 1  ? 'red' : 
  currentSourceRow.구분 !== '목표달성율' && currentSourceRow.may < 0 ? 'red' : 'black' }}"
        valueOverride="{{ item === null ? null : 
  Math.abs(item) === 0 ? 0 : 
  Math.abs(item) < 2 ? (item*100).toFixed(1) + '%' : Number((item/1000).toFixed(0)).toLocaleString() }}"
      />
      <Column
        id="a4eac"
        alignment="right"
        format="string"
        groupAggregationMode="none"
        key="jun"
        label="6월"
        placeholder="Enter value"
        position="center"
        size={98.859375}
        summaryAggregationMode="none"
        textColor="{{ currentSourceRow.구분 === '목표달성율' && currentSourceRow.jun < 1  ? 'red' : 
  currentSourceRow.구분 !== '목표달성율' && currentSourceRow.jun < 0 ? 'red' : 'black' }}"
        valueOverride="{{ item === null ? null : 
  Math.abs(item) === 0 ? 0 : 
  Math.abs(item) < 2 ? (item*100).toFixed(1) + '%' : Number((item/1000).toFixed(0)).toLocaleString() }}"
      />
      <Column
        id="3df39"
        alignment="right"
        format="string"
        groupAggregationMode="none"
        key="jul"
        label="7월"
        placeholder="Enter value"
        position="center"
        size={96.234375}
        summaryAggregationMode="none"
        textColor="{{ currentSourceRow.구분 === '목표달성율' && currentSourceRow.jul < 1  ? 'red' : 
  currentSourceRow.구분 !== '목표달성율' && currentSourceRow.jul < 0 ? 'red' : 'black' }}"
        valueOverride="{{ item === null ? null : 
  Math.abs(item) === 0 ? 0 : 
  Math.abs(item) < 2 ? (item*100).toFixed(1) + '%' : Number((item/1000).toFixed(0)).toLocaleString() }}"
      />
      <Column
        id="ad45a"
        alignment="right"
        format="string"
        groupAggregationMode="none"
        key="aug"
        label="8월"
        placeholder="Enter value"
        position="center"
        size={89.78125}
        summaryAggregationMode="none"
        textColor="{{ currentSourceRow.구분 === '목표달성율' && currentSourceRow.aug < 1  ? 'red' : 
  currentSourceRow.구분 !== '목표달성율' && currentSourceRow.aug < 0 ? 'red' : 'black' }}"
        valueOverride="{{ item === null ? null : 
  Math.abs(item) === 0 ? 0 : 
  Math.abs(item) < 2 ? (item*100).toFixed(1) + '%' : Number((item/1000).toFixed(0)).toLocaleString() }}"
      />
      <Column
        id="99cf6"
        alignment="right"
        format="string"
        groupAggregationMode="none"
        key="sep"
        label="9월"
        placeholder="Enter value"
        position="center"
        size={90.859375}
        summaryAggregationMode="none"
        textColor="{{ currentSourceRow.구분 === '목표달성율' && currentSourceRow.sep < 1  ? 'red' : 
  currentSourceRow.구분 !== '목표달성율' && currentSourceRow.sep < 0 ? 'red' : 'black' }}"
        valueOverride="{{ item === null ? null : 
  Math.abs(item) === 0 ? 0 : 
  Math.abs(item) < 2 ? (item*100).toFixed(1) + '%' : Number((item/1000).toFixed(0)).toLocaleString() }}"
      />
      <Column
        id="526c3"
        alignment="right"
        format="string"
        groupAggregationMode="none"
        key="oct"
        label="10월"
        placeholder="Enter value"
        position="center"
        size={100.453125}
        summaryAggregationMode="none"
        textColor="{{ currentSourceRow.구분 === '목표달성율' && currentSourceRow.oct < 1  ? 'red' : 
  currentSourceRow.구분 !== '목표달성율' && currentSourceRow.oct < 0 ? 'red' : 'black' }}"
        valueOverride="{{ item === null ? null : 
  Math.abs(item) === 0 ? 0 : 
  Math.abs(item) < 2 ? (item*100).toFixed(1) + '%' : Number((item/1000).toFixed(0)).toLocaleString() }}"
      />
      <Column
        id="d27f0"
        alignment="right"
        format="string"
        groupAggregationMode="none"
        key="nov"
        label="11월"
        placeholder="Enter value"
        position="center"
        size={104.53125}
        summaryAggregationMode="none"
        textColor="{{ currentSourceRow.구분 === '목표달성율' && currentSourceRow.nov < 1  ? 'red' : 
  currentSourceRow.구분 !== '목표달성율' && currentSourceRow.nov < 0 ? 'red' : 'black' }}"
        valueOverride="{{ item === null ? null : 
  Math.abs(item) === 0 ? 0 : 
  Math.abs(item) < 2 ? (item*100).toFixed(1) + '%' : Number((item/1000).toFixed(0)).toLocaleString() }}"
      />
      <Column
        id="d50b0"
        alignment="right"
        format="string"
        groupAggregationMode="none"
        key="dec"
        label="12월"
        placeholder="Enter value"
        position="center"
        size={94.21875}
        summaryAggregationMode="none"
        textColor="{{ currentSourceRow.구분 === '목표달성율' && currentSourceRow.dec < 1  ? 'red' : 
  currentSourceRow.구분 !== '목표달성율' && currentSourceRow.dec < 0 ? 'red' : 'black' }}"
        valueOverride="{{ item === null ? null : 
  Math.abs(item) === 0 ? 0 : 
  Math.abs(item) < 2 ? (item*100).toFixed(1) + '%' : Number((item/1000).toFixed(0)).toLocaleString() }}"
      />
      <Column
        id="eaec1"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        hidden="true"
        key="br_cd"
        label="Br cd"
        placeholder="Enter value"
        position="center"
        size={45.796875}
        summaryAggregationMode="none"
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
                    { includeHiddenColumns: false },
                    {
                      fileName:
                        "[{{head.value.slice(4) }}] {{ tabs2.selectedLabel }} {{ text64.value.slice(7) }} (마감 일자:{{ endDate.value }})",
                    },
                  ],
                },
              },
            ],
          }}
          pluginId="table41"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
    </Table>
  </View>
  <View id="f9df5" label="아가방" viewKey="'01'">
    <Table
      id="table40"
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ shopSalesByMonth.value }}"
      defaultSelectedRow={{ mode: "none", indexType: "display", index: 0 }}
      emptyMessage="No rows found"
      enableSaveActions={true}
      heightType="auto"
      margin="px 8px"
      rowBackgroundColor="{{ currentSourceRow.구분.slice(-2) === '실적' ? '01488f33' : 'ffffff' }}"
      rowHeight="small"
      rowSelection="none"
      showBorder={true}
      showColumnBorders={true}
      showHeader={true}
      style={{ headerBackground: "tokens/356f4e7b" }}
      toolbarPosition="bottom"
    >
      <Column
        id="fdee4"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="구분"
        label="구분"
        placeholder="Enter value"
        position="center"
        size={95.796875}
        summaryAggregationMode="none"
      />
      <Column
        id="a8b37"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="string"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="total"
        label="합계"
        placeholder="Enter value"
        position="center"
        size={110.203125}
        summaryAggregationMode="none"
        textColor="{{ currentSourceRow.구분 === '목표달성율' && currentSourceRow.total < 1  ? 'red' : 
  currentSourceRow.구분 !== '목표달성율' && currentSourceRow.total < 0 ? 'red' : 'black' }}"
        valueOverride="{{ self.data[0].total === 0 ? null : 
  Math.abs(item) < 2 ? (item*100).toFixed(2) + '%' : Number((item/1000).toFixed(0)).toLocaleString() }}"
      />
      <Column
        id="0f13a"
        alignment="right"
        format="string"
        groupAggregationMode="none"
        key="jan"
        label="1월"
        placeholder="Enter value"
        position="center"
        size={96.21875}
        summaryAggregationMode="none"
        textColor="{{ currentSourceRow.구분 === '목표달성율' && currentSourceRow.jan < 1  ? 'red' : 
  currentSourceRow.구분 !== '목표달성율' && currentSourceRow.jan < 0 ? 'red' : 'black' }}"
        valueOverride="{{ item === null ? null : 
  Math.abs(item) === 0 ? 0 : 
  Math.abs(item) < 2 ? (item*100).toFixed(1) + '%' : Number((item/1000).toFixed(0)).toLocaleString() }}"
      />
      <Column
        id="4943a"
        alignment="right"
        format="string"
        groupAggregationMode="none"
        key="feb"
        label="2월"
        placeholder="Enter value"
        position="center"
        size={103.65625}
        summaryAggregationMode="none"
        textColor="{{ currentSourceRow.구분 === '목표달성율' && currentSourceRow.feb < 1  ? 'red' : 
  currentSourceRow.구분 !== '목표달성율' && currentSourceRow.feb < 0 ? 'red' : 'black' }}"
        valueOverride="{{ self.data[0].feb === null ? null : 
  Math.abs(item) < 2 ? (item*100).toFixed(2) + '%' : Number((item/1000).toFixed(0)).toLocaleString() }}"
      />
      <Column
        id="de687"
        alignment="right"
        format="string"
        groupAggregationMode="none"
        key="mar"
        label="3월"
        placeholder="Enter value"
        position="center"
        size={93.109375}
        summaryAggregationMode="none"
        textColor="{{ currentSourceRow.구분 === '목표달성율' && currentSourceRow.mar < 1  ? 'red' : 
  currentSourceRow.구분 !== '목표달성율' && currentSourceRow.mar < 0 ? 'red' : 'black' }}"
        valueOverride="{{ self.data[0].mar === null ? null : 
  Math.abs(item) < 2 ? (item*100).toFixed(2) + '%' : Number((item/1000).toFixed(0)).toLocaleString() }}"
      />
      <Column
        id="98a93"
        alignment="right"
        format="string"
        groupAggregationMode="none"
        key="apr"
        label="4월"
        placeholder="Enter value"
        position="center"
        size={104.234375}
        summaryAggregationMode="none"
        textColor="{{ currentSourceRow.구분 === '목표달성율' && currentSourceRow.apr < 1  ? 'red' : 
  currentSourceRow.구분 !== '목표달성율' && currentSourceRow.apr < 0 ? 'red' : 'black' }}"
        valueOverride="{{ self.data[0].apr === null ? null : 
  Math.abs(item) < 2 ? (item*100).toFixed(2) + '%' : Number((item/1000).toFixed(0)).toLocaleString() }}"
      />
      <Column
        id="d6034"
        alignment="right"
        format="string"
        groupAggregationMode="none"
        key="may"
        label="5월"
        placeholder="Enter value"
        position="center"
        size={94.671875}
        summaryAggregationMode="none"
        textColor="{{ currentSourceRow.구분 === '목표달성율' && currentSourceRow.may < 1  ? 'red' : 
  currentSourceRow.구분 !== '목표달성율' && currentSourceRow.may < 0 ? 'red' : 'black' }}"
        valueOverride="{{ self.data[0].may === null ? null : 
  Math.abs(item) < 2 ? (item*100).toFixed(2) + '%' : Number((item/1000).toFixed(0)).toLocaleString() }}"
      />
      <Column
        id="a4eac"
        alignment="right"
        format="string"
        groupAggregationMode="none"
        key="jun"
        label="6월"
        placeholder="Enter value"
        position="center"
        size={98.859375}
        summaryAggregationMode="none"
        textColor="{{ currentSourceRow.구분 === '목표달성율' && currentSourceRow.jun < 1  ? 'red' : 
  currentSourceRow.구분 !== '목표달성율' && currentSourceRow.jun < 0 ? 'red' : 'black' }}"
        valueOverride="{{ self.data[0].jun === null ? null : 
  Math.abs(item) < 2 ? (item*100).toFixed(2) + '%' : Number((item/1000).toFixed(0)).toLocaleString() }}"
      />
      <Column
        id="3df39"
        alignment="right"
        format="string"
        groupAggregationMode="none"
        key="jul"
        label="7월"
        placeholder="Enter value"
        position="center"
        size={96.234375}
        summaryAggregationMode="none"
        textColor="{{ currentSourceRow.구분 === '목표달성율' && currentSourceRow.jul < 1  ? 'red' : 
  currentSourceRow.구분 !== '목표달성율' && currentSourceRow.jul < 0 ? 'red' : 'black' }}"
        valueOverride="{{ self.data[0].jul === null ? null : 
  Math.abs(item) < 2 ? (item*100).toFixed(2) + '%' : Number((item/1000).toFixed(0)).toLocaleString() }}"
      />
      <Column
        id="ad45a"
        alignment="right"
        format="string"
        groupAggregationMode="none"
        key="aug"
        label="8월"
        placeholder="Enter value"
        position="center"
        size={89.78125}
        summaryAggregationMode="none"
        textColor="{{ currentSourceRow.구분 === '목표달성율' && currentSourceRow.aug < 1  ? 'red' : 
  currentSourceRow.구분 !== '목표달성율' && currentSourceRow.aug < 0 ? 'red' : 'black' }}"
        valueOverride="{{ self.data[0].aug === null ? null : 
  Math.abs(item) < 2 ? (item*100).toFixed(2) + '%' : Number((item/1000).toFixed(0)).toLocaleString() }}"
      />
      <Column
        id="99cf6"
        alignment="right"
        format="string"
        groupAggregationMode="none"
        key="sep"
        label="9월"
        placeholder="Enter value"
        position="center"
        size={90.859375}
        summaryAggregationMode="none"
        textColor="{{ currentSourceRow.구분 === '목표달성율' && currentSourceRow.sep < 1  ? 'red' : 
  currentSourceRow.구분 !== '목표달성율' && currentSourceRow.sep < 0 ? 'red' : 'black' }}"
        valueOverride="{{ self.data[0].sep === null ? null : 
  Math.abs(item) < 2 ? (item*100).toFixed(2) + '%' : Number((item/1000).toFixed(0)).toLocaleString() }}"
      />
      <Column
        id="526c3"
        alignment="right"
        format="string"
        groupAggregationMode="none"
        key="oct"
        label="10월"
        placeholder="Enter value"
        position="center"
        size={100.453125}
        summaryAggregationMode="none"
        textColor="{{ currentSourceRow.구분 === '목표달성율' && currentSourceRow.oct < 1  ? 'red' : 
  currentSourceRow.구분 !== '목표달성율' && currentSourceRow.oct < 0 ? 'red' : 'black' }}"
        valueOverride="{{ self.data[0].oct === null ? null : 
  Math.abs(item) < 2 ? (item*100).toFixed(2) + '%' : Number((item/1000).toFixed(0)).toLocaleString() }}"
      />
      <Column
        id="d27f0"
        alignment="right"
        format="string"
        groupAggregationMode="none"
        key="nov"
        label="11월"
        placeholder="Enter value"
        position="center"
        size={104.53125}
        summaryAggregationMode="none"
        textColor="{{ currentSourceRow.구분 === '목표달성율' && currentSourceRow.nov < 1  ? 'red' : 
  currentSourceRow.구분 !== '목표달성율' && currentSourceRow.nov < 0 ? 'red' : 'black' }}"
        valueOverride="{{ self.data[0].nov === null ? null : 
  Math.abs(item) < 2 ? (item*100).toFixed(2) + '%' : Number((item/1000).toFixed(0)).toLocaleString() }}"
      />
      <Column
        id="d50b0"
        alignment="right"
        format="string"
        groupAggregationMode="none"
        key="dec"
        label="12월"
        placeholder="Enter value"
        position="center"
        size={39.21875}
        summaryAggregationMode="none"
        textColor="{{ currentSourceRow.구분 === '목표달성율' && currentSourceRow.dec < 1  ? 'red' : 
  currentSourceRow.구분 !== '목표달성율' && currentSourceRow.dec < 0 ? 'red' : 'black' }}"
        valueOverride="{{ self.data[0].dec === null ? null : 
  Math.abs(item) < 2 ? (item*100).toFixed(2) + '%' : Number((item/1000).toFixed(0)).toLocaleString() }}"
      />
      <Column
        id="eaec1"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        hidden="true"
        key="br_cd"
        label="Br cd"
        placeholder="Enter value"
        position="center"
        size={45.796875}
        summaryAggregationMode="none"
      />
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
          pluginId="table40"
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
          pluginId="table40"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
    </Table>
  </View>
  <View id="a44cd" label="에뜨와" viewKey="'07'">
    <Table
      id="table39"
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ shopSalesByMonth.value }}"
      defaultSelectedRow={{ mode: "none", indexType: "display", index: 0 }}
      emptyMessage="No rows found"
      enableSaveActions={true}
      heightType="auto"
      margin="px 8px"
      rowBackgroundColor="{{ currentSourceRow.구분.slice(-2) === '실적' ? '01488f33' : 'ffffff' }}"
      rowHeight="small"
      rowSelection="none"
      showBorder={true}
      showColumnBorders={true}
      showHeader={true}
      style={{ headerBackground: "tokens/356f4e7b" }}
      toolbarPosition="bottom"
    >
      <Column
        id="fdee4"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="구분"
        label="구분"
        placeholder="Enter value"
        position="center"
        size={95.796875}
        summaryAggregationMode="none"
      />
      <Column
        id="a8b37"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="string"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="total"
        label="합계"
        placeholder="Enter value"
        position="center"
        size={110.203125}
        summaryAggregationMode="none"
        textColor="{{ currentSourceRow.구분 === '목표달성율' && currentSourceRow.total < 1  ? 'red' : 
  currentSourceRow.구분 !== '목표달성율' && currentSourceRow.total < 0 ? 'red' : 'black' }}"
        valueOverride="{{ self.data[0].total === 0 ? null : 
  Math.abs(item) < 2 ? (item*100).toFixed(2) + '%' : Number((item/1000).toFixed(0)).toLocaleString() }}"
      />
      <Column
        id="0f13a"
        alignment="right"
        format="string"
        groupAggregationMode="none"
        key="jan"
        label="1월"
        placeholder="Enter value"
        position="center"
        size={96.21875}
        summaryAggregationMode="none"
        textColor="{{ currentSourceRow.구분 === '목표달성율' && currentSourceRow.jan < 1  ? 'red' : 
  currentSourceRow.구분 !== '목표달성율' && currentSourceRow.jan < 0 ? 'red' : 'black' }}"
        valueOverride="{{ self.data[0].jan === null ? null : 
  Math.abs(item) < 2 ? (item*100).toFixed(2) + '%' : Number((item/1000).toFixed(0)).toLocaleString() }}"
      />
      <Column
        id="4943a"
        alignment="right"
        format="string"
        groupAggregationMode="none"
        key="feb"
        label="2월"
        placeholder="Enter value"
        position="center"
        size={103.65625}
        summaryAggregationMode="none"
        textColor="{{ currentSourceRow.구분 === '목표달성율' && currentSourceRow.feb < 1  ? 'red' : 
  currentSourceRow.구분 !== '목표달성율' && currentSourceRow.feb < 0 ? 'red' : 'black' }}"
        valueOverride="{{ self.data[0].feb === null ? null : 
  Math.abs(item) < 2 ? (item*100).toFixed(2) + '%' : Number((item/1000).toFixed(0)).toLocaleString() }}"
      />
      <Column
        id="de687"
        alignment="right"
        format="string"
        groupAggregationMode="none"
        key="mar"
        label="3월"
        placeholder="Enter value"
        position="center"
        size={93.109375}
        summaryAggregationMode="none"
        textColor="{{ currentSourceRow.구분 === '목표달성율' && currentSourceRow.mar < 1  ? 'red' : 
  currentSourceRow.구분 !== '목표달성율' && currentSourceRow.mar < 0 ? 'red' : 'black' }}"
        valueOverride="{{ self.data[0].mar === null ? null : 
  Math.abs(item) < 2 ? (item*100).toFixed(2) + '%' : Number((item/1000).toFixed(0)).toLocaleString() }}"
      />
      <Column
        id="98a93"
        alignment="right"
        format="string"
        groupAggregationMode="none"
        key="apr"
        label="4월"
        placeholder="Enter value"
        position="center"
        size={104.234375}
        summaryAggregationMode="none"
        textColor="{{ currentSourceRow.구분 === '목표달성율' && currentSourceRow.apr < 1  ? 'red' : 
  currentSourceRow.구분 !== '목표달성율' && currentSourceRow.apr < 0 ? 'red' : 'black' }}"
        valueOverride="{{ self.data[0].apr === null ? null : 
  Math.abs(item) < 2 ? (item*100).toFixed(2) + '%' : Number((item/1000).toFixed(0)).toLocaleString() }}"
      />
      <Column
        id="d6034"
        alignment="right"
        format="string"
        groupAggregationMode="none"
        key="may"
        label="5월"
        placeholder="Enter value"
        position="center"
        size={94.671875}
        summaryAggregationMode="none"
        textColor="{{ currentSourceRow.구분 === '목표달성율' && currentSourceRow.may < 1  ? 'red' : 
  currentSourceRow.구분 !== '목표달성율' && currentSourceRow.may < 0 ? 'red' : 'black' }}"
        valueOverride="{{ self.data[0].may === null ? null : 
  Math.abs(item) < 2 ? (item*100).toFixed(2) + '%' : Number((item/1000).toFixed(0)).toLocaleString() }}"
      />
      <Column
        id="a4eac"
        alignment="right"
        format="string"
        groupAggregationMode="none"
        key="jun"
        label="6월"
        placeholder="Enter value"
        position="center"
        size={98.859375}
        summaryAggregationMode="none"
        textColor="{{ currentSourceRow.구분 === '목표달성율' && currentSourceRow.jun < 1  ? 'red' : 
  currentSourceRow.구분 !== '목표달성율' && currentSourceRow.jun < 0 ? 'red' : 'black' }}"
        valueOverride="{{ self.data[0].jun === null ? null : 
  Math.abs(item) < 2 ? (item*100).toFixed(2) + '%' : Number((item/1000).toFixed(0)).toLocaleString() }}"
      />
      <Column
        id="3df39"
        alignment="right"
        format="string"
        groupAggregationMode="none"
        key="jul"
        label="7월"
        placeholder="Enter value"
        position="center"
        size={96.234375}
        summaryAggregationMode="none"
        textColor="{{ currentSourceRow.구분 === '목표달성율' && currentSourceRow.jul < 1  ? 'red' : 
  currentSourceRow.구분 !== '목표달성율' && currentSourceRow.jul < 0 ? 'red' : 'black' }}"
        valueOverride="{{ self.data[0].jul === null ? null : 
  Math.abs(item) < 2 ? (item*100).toFixed(2) + '%' : Number((item/1000).toFixed(0)).toLocaleString() }}"
      />
      <Column
        id="ad45a"
        alignment="right"
        format="string"
        groupAggregationMode="none"
        key="aug"
        label="8월"
        placeholder="Enter value"
        position="center"
        size={89.78125}
        summaryAggregationMode="none"
        textColor="{{ currentSourceRow.구분 === '목표달성율' && currentSourceRow.aug < 1  ? 'red' : 
  currentSourceRow.구분 !== '목표달성율' && currentSourceRow.aug < 0 ? 'red' : 'black' }}"
        valueOverride="{{ self.data[0].aug === null ? null : 
  Math.abs(item) < 2 ? (item*100).toFixed(2) + '%' : Number((item/1000).toFixed(0)).toLocaleString() }}"
      />
      <Column
        id="99cf6"
        alignment="right"
        format="string"
        groupAggregationMode="none"
        key="sep"
        label="9월"
        placeholder="Enter value"
        position="center"
        size={90.859375}
        summaryAggregationMode="none"
        textColor="{{ currentSourceRow.구분 === '목표달성율' && currentSourceRow.sep < 1  ? 'red' : 
  currentSourceRow.구분 !== '목표달성율' && currentSourceRow.sep < 0 ? 'red' : 'black' }}"
        valueOverride="{{ self.data[0].sep === null ? null : 
  Math.abs(item) < 2 ? (item*100).toFixed(2) + '%' : Number((item/1000).toFixed(0)).toLocaleString() }}"
      />
      <Column
        id="526c3"
        alignment="right"
        format="string"
        groupAggregationMode="none"
        key="oct"
        label="10월"
        placeholder="Enter value"
        position="center"
        size={100.453125}
        summaryAggregationMode="none"
        textColor="{{ currentSourceRow.구분 === '목표달성율' && currentSourceRow.oct < 1  ? 'red' : 
  currentSourceRow.구분 !== '목표달성율' && currentSourceRow.oct < 0 ? 'red' : 'black' }}"
        valueOverride="{{ self.data[0].oct === null ? null : 
  Math.abs(item) < 2 ? (item*100).toFixed(2) + '%' : Number((item/1000).toFixed(0)).toLocaleString() }}"
      />
      <Column
        id="d27f0"
        alignment="right"
        format="string"
        groupAggregationMode="none"
        key="nov"
        label="11월"
        placeholder="Enter value"
        position="center"
        size={104.53125}
        summaryAggregationMode="none"
        textColor="{{ currentSourceRow.구분 === '목표달성율' && currentSourceRow.nov < 1  ? 'red' : 
  currentSourceRow.구분 !== '목표달성율' && currentSourceRow.nov < 0 ? 'red' : 'black' }}"
        valueOverride="{{ self.data[0].nov === null ? null : 
  Math.abs(item) < 2 ? (item*100).toFixed(2) + '%' : Number((item/1000).toFixed(0)).toLocaleString() }}"
      />
      <Column
        id="d50b0"
        alignment="right"
        format="string"
        groupAggregationMode="none"
        key="dec"
        label="12월"
        placeholder="Enter value"
        position="center"
        size={39.21875}
        summaryAggregationMode="none"
        textColor="{{ currentSourceRow.구분 === '목표달성율' && currentSourceRow.dec < 1  ? 'red' : 
  currentSourceRow.구분 !== '목표달성율' && currentSourceRow.dec < 0 ? 'red' : 'black' }}"
        valueOverride="{{ self.data[0].dec === null ? null : 
  Math.abs(item) < 2 ? (item*100).toFixed(2) + '%' : Number((item/1000).toFixed(0)).toLocaleString() }}"
      />
      <Column
        id="eaec1"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        hidden="true"
        key="br_cd"
        label="Br cd"
        placeholder="Enter value"
        position="center"
        size={45.796875}
        summaryAggregationMode="none"
      />
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
          pluginId="table39"
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
          pluginId="table39"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
    </Table>
  </View>
  <View
    id="0d3cd"
    disabled={false}
    hidden={false}
    iconPosition="left"
    label="디즈니"
    viewKey="'79'"
  >
    <Table
      id="table38"
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ shopSalesByMonth.value }}"
      defaultSelectedRow={{ mode: "none", indexType: "display", index: 0 }}
      emptyMessage="No rows found"
      enableSaveActions={true}
      heightType="auto"
      margin="px 8px"
      primaryKeyColumnId="fdee4"
      rowBackgroundColor="{{ currentSourceRow.구분.slice(-2) === '실적' ? '01488f33' : 'ffffff' }}"
      rowHeight="small"
      rowSelection="none"
      showBorder={true}
      showColumnBorders={true}
      showHeader={true}
      style={{ headerBackground: "tokens/356f4e7b" }}
      toolbarPosition="bottom"
    >
      <Column
        id="fdee4"
        alignment="left"
        editable={false}
        format="string"
        groupAggregationMode="none"
        key="구분"
        label="구분"
        placeholder="Enter value"
        position="center"
        size={95.796875}
        summaryAggregationMode="none"
      />
      <Column
        id="a8b37"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="string"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="total"
        label="합계"
        placeholder="Enter value"
        position="center"
        size={110.203125}
        summaryAggregationMode="none"
        textColor="{{ currentSourceRow.구분 === '목표달성율' && currentSourceRow.total < 1  ? 'red' : 
  currentSourceRow.구분 !== '목표달성율' && currentSourceRow.total < 0 ? 'red' : 'black' }}"
        valueOverride="{{ self.data[0].total === 0 ? null : 
  Math.abs(item) < 2 ? (item*100).toFixed(2) + '%' : Number((item/1000).toFixed(0)).toLocaleString() }}"
      />
      <Column
        id="0f13a"
        alignment="right"
        format="string"
        groupAggregationMode="none"
        key="jan"
        label="1월"
        placeholder="Enter value"
        position="center"
        size={96.21875}
        summaryAggregationMode="none"
        textColor="{{ currentSourceRow.구분 === '목표달성율' && currentSourceRow.jan < 1  ? 'red' : 
  currentSourceRow.구분 !== '목표달성율' && currentSourceRow.jan < 0 ? 'red' : 'black' }}"
        valueOverride="{{ self.data[0].jan === null ? null : 
  Math.abs(item) < 2 ? (item*100).toFixed(2) + '%' : Number((item/1000).toFixed(0)).toLocaleString() }}"
      />
      <Column
        id="4943a"
        alignment="right"
        format="string"
        groupAggregationMode="none"
        key="feb"
        label="2월"
        placeholder="Enter value"
        position="center"
        size={103.65625}
        summaryAggregationMode="none"
        textColor="{{ currentSourceRow.구분 === '목표달성율' && currentSourceRow.feb < 1  ? 'red' : 
  currentSourceRow.구분 !== '목표달성율' && currentSourceRow.feb < 0 ? 'red' : 'black' }}"
        valueOverride="{{ self.data[0].feb === null ? null : 
  Math.abs(item) < 2 ? (item*100).toFixed(2) + '%' : Number((item/1000).toFixed(0)).toLocaleString() }}"
      />
      <Column
        id="de687"
        alignment="right"
        format="string"
        groupAggregationMode="none"
        key="mar"
        label="3월"
        placeholder="Enter value"
        position="center"
        size={93.109375}
        summaryAggregationMode="none"
        textColor="{{ currentSourceRow.구분 === '목표달성율' && currentSourceRow.mar < 1  ? 'red' : 
  currentSourceRow.구분 !== '목표달성율' && currentSourceRow.mar < 0 ? 'red' : 'black' }}"
        valueOverride="{{ self.data[0].mar === null ? null : 
  Math.abs(item) < 2 ? (item*100).toFixed(2) + '%' : Number((item/1000).toFixed(0)).toLocaleString() }}"
      />
      <Column
        id="98a93"
        alignment="right"
        format="string"
        groupAggregationMode="none"
        key="apr"
        label="4월"
        placeholder="Enter value"
        position="center"
        size={104.234375}
        summaryAggregationMode="none"
        textColor="{{ currentSourceRow.구분 === '목표달성율' && currentSourceRow.apr < 1  ? 'red' : 
  currentSourceRow.구분 !== '목표달성율' && currentSourceRow.apr < 0 ? 'red' : 'black' }}"
        valueOverride="{{ self.data[0].apr === null ? null : 
  Math.abs(item) < 2 ? (item*100).toFixed(2) + '%' : Number((item/1000).toFixed(0)).toLocaleString() }}"
      />
      <Column
        id="d6034"
        alignment="right"
        format="string"
        groupAggregationMode="none"
        key="may"
        label="5월"
        placeholder="Enter value"
        position="center"
        size={94.671875}
        summaryAggregationMode="none"
        textColor="{{ currentSourceRow.구분 === '목표달성율' && currentSourceRow.may < 1  ? 'red' : 
  currentSourceRow.구분 !== '목표달성율' && currentSourceRow.may < 0 ? 'red' : 'black' }}"
        valueOverride="{{ self.data[0].may === null ? null : 
  Math.abs(item) < 2 ? (item*100).toFixed(2) + '%' : Number((item/1000).toFixed(0)).toLocaleString() }}"
      />
      <Column
        id="a4eac"
        alignment="right"
        format="string"
        groupAggregationMode="none"
        key="jun"
        label="6월"
        placeholder="Enter value"
        position="center"
        size={98.859375}
        summaryAggregationMode="none"
        textColor="{{ currentSourceRow.구분 === '목표달성율' && currentSourceRow.jun < 1  ? 'red' : 
  currentSourceRow.구분 !== '목표달성율' && currentSourceRow.jun < 0 ? 'red' : 'black' }}"
        valueOverride="{{ self.data[0].jun === null ? null : 
  Math.abs(item) < 2 ? (item*100).toFixed(2) + '%' : Number((item/1000).toFixed(0)).toLocaleString() }}"
      />
      <Column
        id="3df39"
        alignment="right"
        format="string"
        groupAggregationMode="none"
        key="jul"
        label="7월"
        placeholder="Enter value"
        position="center"
        size={96.234375}
        summaryAggregationMode="none"
        textColor="{{ currentSourceRow.구분 === '목표달성율' && currentSourceRow.jul < 1  ? 'red' : 
  currentSourceRow.구분 !== '목표달성율' && currentSourceRow.jul < 0 ? 'red' : 'black' }}"
        valueOverride="{{ self.data[0].jul === null ? null : 
  Math.abs(item) < 2 ? (item*100).toFixed(2) + '%' : Number((item/1000).toFixed(0)).toLocaleString() }}"
      />
      <Column
        id="ad45a"
        alignment="right"
        format="string"
        groupAggregationMode="none"
        key="aug"
        label="8월"
        placeholder="Enter value"
        position="center"
        size={89.78125}
        summaryAggregationMode="none"
        textColor="{{ currentSourceRow.구분 === '목표달성율' && currentSourceRow.aug < 1  ? 'red' : 
  currentSourceRow.구분 !== '목표달성율' && currentSourceRow.aug < 0 ? 'red' : 'black' }}"
        valueOverride="{{ self.data[0].aug === null ? null : 
  Math.abs(item) < 2 ? (item*100).toFixed(2) + '%' : Number((item/1000).toFixed(0)).toLocaleString() }}"
      />
      <Column
        id="99cf6"
        alignment="right"
        format="string"
        groupAggregationMode="none"
        key="sep"
        label="9월"
        placeholder="Enter value"
        position="center"
        size={90.859375}
        summaryAggregationMode="none"
        textColor="{{ currentSourceRow.구분 === '목표달성율' && currentSourceRow.sep < 1  ? 'red' : 
  currentSourceRow.구분 !== '목표달성율' && currentSourceRow.sep < 0 ? 'red' : 'black' }}"
        valueOverride="{{ self.data[0].sep === null ? null : 
  Math.abs(item) < 2 ? (item*100).toFixed(2) + '%' : Number((item/1000).toFixed(0)).toLocaleString() }}"
      />
      <Column
        id="526c3"
        alignment="right"
        format="string"
        groupAggregationMode="none"
        key="oct"
        label="10월"
        placeholder="Enter value"
        position="center"
        size={100.453125}
        summaryAggregationMode="none"
        textColor="{{ currentSourceRow.구분 === '목표달성율' && currentSourceRow.oct < 1  ? 'red' : 
  currentSourceRow.구분 !== '목표달성율' && currentSourceRow.oct < 0 ? 'red' : 'black' }}"
        valueOverride="{{ self.data[0].oct === null ? null : 
  Math.abs(item) < 2 ? (item*100).toFixed(2) + '%' : Number((item/1000).toFixed(0)).toLocaleString() }}"
      />
      <Column
        id="d27f0"
        alignment="right"
        format="string"
        groupAggregationMode="none"
        key="nov"
        label="11월"
        placeholder="Enter value"
        position="center"
        size={104.53125}
        summaryAggregationMode="none"
        textColor="{{ currentSourceRow.구분 === '목표달성율' && currentSourceRow.nov < 1  ? 'red' : 
  currentSourceRow.구분 !== '목표달성율' && currentSourceRow.nov < 0 ? 'red' : 'black' }}"
        valueOverride="{{ self.data[0].nov === null ? null : 
  Math.abs(item) < 2 ? (item*100).toFixed(2) + '%' : Number((item/1000).toFixed(0)).toLocaleString() }}"
      />
      <Column
        id="d50b0"
        alignment="right"
        format="string"
        groupAggregationMode="none"
        key="dec"
        label="12월"
        placeholder="Enter value"
        position="center"
        size={39.21875}
        summaryAggregationMode="none"
        textColor="{{ currentSourceRow.구분 === '목표달성율' && currentSourceRow.dec < 1  ? 'red' : 
  currentSourceRow.구분 !== '목표달성율' && currentSourceRow.dec < 0 ? 'red' : 'black' }}"
        valueOverride="{{ self.data[0].dec === null ? null : 
  Math.abs(item) < 2 ? (item*100).toFixed(2) + '%' : Number((item/1000).toFixed(0)).toLocaleString() }}"
      />
      <Column
        id="eaec1"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        hidden="true"
        key="br_cd"
        label="Br cd"
        placeholder="Enter value"
        position="center"
        size={45.796875}
        summaryAggregationMode="none"
      />
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
          pluginId="table38"
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
          pluginId="table38"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
    </Table>
  </View>
</Container>
