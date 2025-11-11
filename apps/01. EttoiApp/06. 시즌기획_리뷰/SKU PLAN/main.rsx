<App>
  <Include src="./functions.rsx" />
  <DocumentTitle id="$customDocumentTitle" value="SKU PLAN | ET" />
  <Include src="./header.rsx" />
  <Include src="./src/drawerFrame1.rsx" />
  <Include src="./src/splitPaneFrame_analysis.rsx" />
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
      id="container_filter"
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      margin="0"
      padding="12px"
      showBody={true}
    >
      <Header>
        <Text
          id="containerTitle1"
          value="#### Container title"
          verticalAlign="center"
        />
      </Header>
      <View id="28726" viewKey="View 1">
        <Select
          id="select_season"
          captionByIndex=""
          colorByIndex=""
          data="{{ season_list_new.data['season'] }}"
          disabledByIndex=""
          emptyMessage="No options"
          fallbackTextByIndex=""
          hiddenByIndex=""
          iconByIndex=""
          imageByIndex=""
          label=""
          labelAlign="right"
          labels="{{ item.year_sesn_nm_kor }}"
          labelWidth="20
"
          overlayMaxHeight={375}
          placeholder="Select an option"
          showSelectionIndicator={true}
          textBefore="시즌"
          tooltipByIndex=""
          value="25WT"
          values="{{ item.year_sesn_cd }}"
        >
          <Event
            event="change"
            method="trigger"
            params={{ ordered: [] }}
            pluginId="set_season_list"
            type="datasource"
            waitMs="0"
            waitType="debounce"
          />
        </Select>
        <NumberInput
          id="numberInput_sale_days"
          currency="USD"
          disabled=""
          inputValue={0}
          label=""
          labelPosition="top"
          placeholder="Enter value"
          showSeparators={true}
          showStepper={true}
          textAfter="일"
          textAlign="right"
          textBefore="판매 시작 후"
          value="100"
        />
        <NumberInput
          id="numberInput_years"
          currency="USD"
          disabled="true"
          inputValue={0}
          label=""
          labelPosition="top"
          placeholder="Enter value"
          showSeparators={true}
          showStepper={true}
          textAfter="년"
          textAlign="right"
          textBefore="이전"
          value="3"
        />
      </View>
    </Container>
    <ListViewBeta
      id="listView1"
      _primaryKeys=""
      data="{{ category_list.data.cat_nm}}"
      heightType="auto"
      itemWidth="200px"
      margin="0"
      numColumns={3}
      padding="0"
    >
      <Container
        id="container1"
        footerPadding="4px 12px"
        headerPadding="4px 12px"
        padding="12px"
        showBody={true}
        showHeader={true}
      >
        <Header>
          <Text
            id="containerTitle2"
            value="#### {{ item }}"
            verticalAlign="center"
          />
          <Button
            id="button_analysis"
            hidden="true"
            iconBefore="bold/interface-edit-magic-wand"
            text="AI 분석"
          >
            <Event
              event="click"
              method="show"
              params={{ ordered: [] }}
              pluginId="splitPaneFrame_analysis"
              type="widget"
              waitMs="0"
              waitType="debounce"
            />
            <Event
              event="click"
              method="setValue"
              params={{ ordered: [{ value: "{{ item }}" }] }}
              pluginId="var_select_category"
              type="state"
              waitMs="0"
              waitType="debounce"
            />
          </Button>
        </Header>
        <View id="64752" viewKey="View 1">
          <Table
            id="table1"
            cellSelection="none"
            clearChangesetOnSave={true}
            data="{{ make_table_data.data[item] }}"
            defaultSelectedRow={{
              mode: "none",
              indexType: "display",
              index: 0,
            }}
            emptyMessage="No rows found"
            enableSaveActions={true}
            heightType="auto"
            margin="0"
            rowHeight="small"
            rowSelection="none"
            showHeader={true}
            style={{
              fontSize: "9px",
              fontWeight: "400",
              fontFamily: "Inter",
              headerFontSize: "9px",
              headerFontWeight: "600",
              headerFontFamily: "Inter",
            }}
            toolbarPosition="bottom"
          >
            <Column
              id="a3069"
              alignment="center"
              editable={false}
              format="string"
              groupAggregationMode="none"
              key="item_raw_nm"
              label="소분류"
              placeholder="Enter value"
              position="left"
              size={72.140625}
              summaryAggregationMode="none"
            />
            <Column
              id="54915"
              alignment="center"
              backgroundColor="rgba(251, 209, 209, 0.25)"
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="sum"
              key="season_1_sku"
              label="{{ var_season_list.value[2] }} SKU"
              placeholder="Enter value"
              position="center"
              size={73.375}
              summaryAggregationMode="none"
            />
            <Column
              id="e9824"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="sum"
              key="season_1_tot_in_qty"
              label="입고수량"
              placeholder="Enter value"
              position="center"
              size={57.765625}
              summaryAggregationMode="none"
              textColor="rgba(35, 59, 232, 1)"
            />
            <Column
              id="42402"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="sum"
              key="season_1_tot_in_amt"
              label="TAG가"
              placeholder="Enter value"
              position="center"
              size={49.6875}
              summaryAggregationMode="none"
              valueOverride="{{ (item/1000000).toFixed(0) }}"
            />
            <Column
              id="58e10"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{
                showSeparators: true,
                notation: "standard",
                decimalPlaces: "1",
              }}
              groupAggregationMode="average"
              key="season_1_tot_in_amt_ratio"
              label="입고비중"
              placeholder="Enter value"
              position="center"
              size={44.609375}
              summaryAggregationMode="none"
            />
            <Column
              id="0cfe6"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="sum"
              key="season_1_tot_sale_qty"
              label="판매수량"
              placeholder="Enter value"
              position="center"
              size={47.765625}
              summaryAggregationMode="none"
              textColor="rgba(237, 37, 37, 1)"
            />
            <Column
              id="1a35b"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="sum"
              key="season_1_tot_sale_amt"
              label="실판가"
              placeholder="Enter value"
              position="center"
              size={40.140625}
              summaryAggregationMode="none"
              valueOverride="{{ (item/1000000).toFixed(0) }}"
            />
            <Column
              id="a2e78"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{
                showSeparators: true,
                notation: "standard",
                decimalPlaces: "1",
              }}
              groupAggregationMode="average"
              label="판매율"
              placeholder="Enter value"
              position="center"
              referenceId="season_1_amt_per"
              size={46.140625}
              summaryAggregationMode="none"
              textColor="rgba(241, 45, 45, 1)"
              valueOverride="{{ currentSourceRow.season_1_tot_sale_amt/currentSourceRow.season_1_tot_in_amt }}"
            />
            <Column
              id="4b17e"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{
                showSeparators: true,
                notation: "standard",
                decimalPlaces: "1",
              }}
              groupAggregationMode="average"
              key="season_1_tot_sale_amt_ratio"
              label="판매비중"
              placeholder="Enter value"
              position="center"
              size={44.609375}
              summaryAggregationMode="none"
            />
            <Column
              id="460ec"
              alignment="center"
              backgroundColor="rgba(251, 209, 209, 0.25)"
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="sum"
              key="season_2_sku"
              label="{{ var_season_list.value[1] }} SKU"
              placeholder="Enter value"
              position="center"
              size={86.765625}
              summaryAggregationMode="none"
            />
            <Column
              id="d7663"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="sum"
              key="season_2_tot_in_qty"
              label="입고수량"
              placeholder="Enter value"
              position="center"
              size={58.1875}
              summaryAggregationMode="none"
              textColor="rgba(50, 68, 234, 1)"
            />
            <Column
              id="c94a5"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="sum"
              key="season_2_tot_in_amt"
              label="TAG가"
              placeholder="Enter value"
              position="center"
              size={51.390625}
              summaryAggregationMode="none"
              valueOverride="{{ (item/1000000).toFixed(0) }}"
            />
            <Column
              id="347cd"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{
                showSeparators: true,
                notation: "standard",
                decimalPlaces: "1",
              }}
              groupAggregationMode="average"
              key="season_2_tot_in_amt_ratio"
              label="입고비중"
              placeholder="Enter value"
              position="center"
              size={50.375}
              summaryAggregationMode="none"
              textColor="rgba(56, 85, 252, 1)"
            />
            <Column
              id="f5c16"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="sum"
              key="season_2_tot_sale_qty"
              label="판매수량"
              placeholder="Enter value"
              position="center"
              size={55.1875}
              summaryAggregationMode="none"
              textColor="rgba(243, 69, 69, 1)"
            />
            <Column
              id="ff86b"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="sum"
              key="season_2_tot_sale_amt"
              label="실판가"
              placeholder="Enter value"
              position="center"
              size={47.40625}
              summaryAggregationMode="none"
              valueOverride="{{ (item/1000000).toFixed(0) }}"
            />
            <Column
              id="41a4a"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{
                showSeparators: true,
                notation: "standard",
                decimalPlaces: "1",
              }}
              groupAggregationMode="average"
              label="판매율"
              placeholder="Enter value"
              position="center"
              referenceId="판매율"
              size={54}
              summaryAggregationMode="none"
              textColor="rgba(244, 54, 54, 1)"
              valueOverride="{{ currentSourceRow.season_2_tot_sale_amt/currentSourceRow.season_2_tot_in_amt }}"
            />
            <Column
              id="361e3"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{
                showSeparators: true,
                notation: "standard",
                decimalPlaces: "1",
              }}
              groupAggregationMode="average"
              key="season_2_tot_sale_amt_ratio"
              label="판매비중"
              placeholder="Enter value"
              position="center"
              size={46.375}
              summaryAggregationMode="none"
            />
            <Column
              id="c970d"
              alignment="center"
              backgroundColor="rgba(251, 209, 209, 0.25)"
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="sum"
              key="season_3_sku"
              label="{{ var_season_list.value[0] }} SKU"
              placeholder="Enter value"
              position="center"
              size={72.765625}
              summaryAggregationMode="none"
            />
            <Column
              id="bf6ef"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="sum"
              key="season_3_tot_in_qty"
              label="입고수량"
              placeholder="Enter value"
              position="center"
              size={59.1875}
              summaryAggregationMode="none"
              textColor="rgba(49, 108, 249, 1)"
            />
            <Column
              id="9c065"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="sum"
              key="season_3_tot_in_amt"
              label="TAG가"
              placeholder="Enter value"
              position="center"
              size={52.390625}
              summaryAggregationMode="none"
              valueOverride="{{ (item/1000000).toFixed(0) }}"
            />
            <Column
              id="544c7"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{
                showSeparators: true,
                notation: "standard",
                decimalPlaces: "1",
              }}
              groupAggregationMode="average"
              key="season_3_tot_in_amt_ratio"
              label="입고비중"
              placeholder="Enter value"
              position="center"
              size={52.1875}
              summaryAggregationMode="none"
              textColor="rgba(72, 92, 232, 1)"
            />
            <Column
              id="bbd08"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="sum"
              key="season_3_tot_sale_qty"
              label="판매수량"
              placeholder="Enter value"
              position="center"
              size={51.40625}
              summaryAggregationMode="none"
              textColor="rgba(243, 62, 62, 1)"
            />
            <Column
              id="6bb08"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="sum"
              key="season_3_tot_sale_amt"
              label="실판가"
              placeholder="Enter value"
              position="center"
              size={42}
              summaryAggregationMode="none"
              valueOverride="{{ (item/1000000).toFixed(0) }}"
            />
            <Column
              id="4af3d"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{
                showSeparators: true,
                notation: "standard",
                decimalPlaces: "1",
              }}
              groupAggregationMode="average"
              label="판매율"
              placeholder="Enter value"
              position="center"
              referenceId="sale_3_amt_per"
              size={45.375}
              summaryAggregationMode="none"
              textColor="rgba(243, 69, 69, 1)"
              valueOverride="{{ currentSourceRow.season_3_tot_sale_amt/currentSourceRow.season_3_tot_in_amt }}"
            />
            <Column
              id="5975c"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{
                showSeparators: true,
                notation: "standard",
                decimalPlaces: "1",
              }}
              groupAggregationMode="average"
              key="season_3_tot_sale_amt_ratio"
              label="판매비중"
              placeholder="Enter value"
              position="center"
              size={45.375}
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
                pluginId="table1"
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
                pluginId="table1"
                type="widget"
                waitMs="0"
                waitType="debounce"
              />
            </ToolbarButton>
          </Table>
        </View>
      </Container>
    </ListViewBeta>
  </Frame>
</App>
