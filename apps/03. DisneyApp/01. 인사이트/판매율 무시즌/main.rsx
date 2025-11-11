<App>
  <Include src="./functions.rsx" />
  <Include src="./header.rsx" />
  <Include src="./src/drawerFrame1.rsx" />
  <Include src="./src/modal_item_list.rsx" />
  <Frame
    id="$main"
    enableFullBleed={false}
    isHiddenOnDesktop={false}
    isHiddenOnMobile={false}
    padding="8px 12px"
    sticky={null}
    type="main"
  >
    <Include src="./src/container1.rsx" />
    <Container
      id="container4"
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      loading="{{ for_4_years_query.isFetching || for_4_years_middle_cat_query.isFetching }}"
      padding="0"
      showBody={true}
      showHeader={true}
    >
      <Header>
        <Text
          id="containerTitle2"
          margin="0"
          value="###### {{ moment().year() }}년 신상품 기준"
          verticalAlign="center"
        />
        <Text
          id="text22"
          margin="0"
          style={{
            ordered: [
              { fontSize: "10px" },
              { fontWeight: "500" },
              { fontFamily: "pretendard variable" },
            ],
          }}
          value="누계: ~ {{ moment(date_select.value).format('YYYY-MM-DD') }} | 월간: {{ moment(date_select.value).startOf('month').format('YYYY-MM-DD') }} ~{{ moment(date_select.value).format('YYYY-MM-DD') }} | 지난주: {{ moment(date_select.value).subtract('13','days').format('YYYY-MM-DD') }} ~ {{ moment(date_select.value).subtract('7','days').format('YYYY-MM-DD') }} | 이번주: {{ moment(date_select.value).subtract('6','days').format('YYYY-MM-DD') }} ~ {{ moment(date_select.value).format('YYYY-MM-DD') }}"
          verticalAlign="center"
        />
        <Text
          id="text21"
          horizontalAlign="right"
          margin="0"
          style={{
            ordered: [
              { fontSize: "11px" },
              { fontWeight: "600" },
              { fontFamily: "Inter" },
            ],
          }}
          value="단위: 백만원"
          verticalAlign="center"
        />
      </Header>
      <View id="3df7a" viewKey="View 1">
        <Table
          id="table1"
          cellSelection="none"
          clearChangesetOnSave={true}
          data="{{ var_large_cat.value.var_01 }}"
          defaultSelectedRow={{ mode: "none", indexType: "display", index: 0 }}
          emptyMessage="No rows found"
          enableExpandableRows={true}
          enableSaveActions={true}
          heightType="auto"
          margin="0"
          rowBackgroundColor="{{ currentRow.cat_id === 777 ? '#ccebc5':
   currentRow.cat_id === 888 ? '#ccebc5': 
   currentRow.cat_id === 999 ? '#bebada':
  'FFFFF'}}"
          rowHeight="small"
          rowSelection="none"
          showColumnBorders={true}
          showHeader={true}
          toolbarPosition="bottom"
        >
          <Include src="./src/table1ExpandedRow.rsx" />
          <Column
            id="27ccc"
            alignment="left"
            format="tag"
            formatOptions={{ automaticColors: true }}
            groupAggregationMode="none"
            hidden="true"
            key="season_code"
            label="Season code"
            placeholder="Select option"
            position="center"
            size={100}
            summaryAggregationMode="none"
          />
          <Column
            id="7a863"
            alignment="left"
            format="markdown"
            groupAggregationMode="none"
            key="cat_nm"
            label="카테고리"
            placeholder="Enter value"
            position="left"
            size={83.515625}
            summaryAggregationMode="none"
            valueOverride="**{{ item }}**"
          />
          <Column
            id="1db32"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            hidden="true"
            key="cat_id"
            label="Cat ID"
            placeholder="Enter value"
            position="center"
            size={51.03125}
            summaryAggregationMode="none"
          />
          <Column
            id="17164"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            hidden="true"
            key="tot_ord_qty"
            label="발주수량"
            placeholder="Enter value"
            position="center"
            size={65.9375}
            summaryAggregationMode="none"
          />
          <Column
            id="94fa2"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "0",
            }}
            groupAggregationMode="sum"
            key="tot_ord_tag"
            label="발주금액(TAG)"
            placeholder="Enter value"
            position="center"
            size={105.515625}
            summaryAggregationMode="none"
            valueOverride="{{ item/1000000 }}"
          />
          <Column
            id="24d65"
            alignment="center"
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "0",
            }}
            groupAggregationMode="average"
            key="in_rate_tag"
            label="입고율(TAG)"
            placeholder="Enter value"
            position="center"
            size={102.140625}
            summaryAggregationMode="none"
          />
          <Column
            id="5de09"
            alignment="center"
            backgroundColor="{{ currentSourceRow.cat_id === 777 ? '#ccebc5':
   currentSourceRow.cat_id === 888 ? '#ccebc5': 
   currentSourceRow.cat_id === 999 ? '#bebada':
  '#efefef'}}"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="ord_st"
            label="총컬러수"
            placeholder="Enter value"
            position="center"
            size={85.515625}
            summaryAggregationMode="none"
          />
          <Column
            id="e5980"
            alignment="center"
            backgroundColor="{{ currentSourceRow.cat_id === 777 ? '#ccebc5':
   currentSourceRow.cat_id === 888 ? '#ccebc5': 
   currentSourceRow.cat_id === 999 ? '#bebada':
  '#efefef'}}"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            hidden="{{ var_hide_column.value?.[inventory_columns_toggle.value]?.find(i => i === 'in_st') }}"
            key="in_st"
            label="현재입고컬러수"
            placeholder="Enter value"
            position="center"
            size={114.65625}
            summaryAggregationMode="none"
          />
          <Column
            id="52618"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            hidden="true"
            key="in_st_rate"
            label="In st rate"
            placeholder="Enter value"
            position="center"
            size={66.09375}
            summaryAggregationMode="none"
          />
          <Column
            id="972b9"
            alignment="center"
            backgroundColor="{{ currentSourceRow.cat_id === 777 ? '#ccebc5':
   currentSourceRow.cat_id === 888 ? '#ccebc5': 
   currentSourceRow.cat_id === 999 ? '#bebada':
  '#efefef'}}"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            hidden="{{ var_hide_column.value?.[inventory_columns_toggle.value]?.find(i => i === 'out_st') }}"
            key="out_st"
            label="현재출고컬러수"
            placeholder="Enter value"
            position="center"
            size={116.65625}
            summaryAggregationMode="none"
          />
          <Column
            id="e97c7"
            alignment="center"
            backgroundColor="{{ currentSourceRow.cat_id === 777 ? '#ccebc5':
   currentSourceRow.cat_id === 888 ? '#ccebc5': 
   currentSourceRow.cat_id === 999 ? '#bebada':
  '#efefef'}}"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            hidden="{{ var_hide_column.value?.[inventory_columns_toggle.value]?.find(i => i === 'not_in_st') }}"
            key="not_in_st"
            label="미입고컬러수"
            placeholder="Enter value"
            position="center"
            size={110.28125}
            summaryAggregationMode="none"
          />
          <Column
            id="ee4ce"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            hidden="true"
            key="not_out_st"
            label="Not out st"
            placeholder="Enter value"
            position="center"
            size={72.4375}
            summaryAggregationMode="none"
          />
          <Column
            id="92668"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            hidden="true"
            key="out_st_rate"
            label="Out st rate"
            placeholder="Enter value"
            position="center"
            size={76.375}
            summaryAggregationMode="none"
          />
          <Column
            id="d0354"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="tot_in_qty"
            label="총입고수량"
            placeholder="Enter value"
            position="center"
            size={80.9375}
            summaryAggregationMode="none"
          />
          <Column
            id="18d8c"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="tot_sale_qty"
            label="총판매수량"
            placeholder="Enter value"
            position="center"
            size={84.171875}
            summaryAggregationMode="none"
          />
          <Column
            id="84e2f"
            alignment="center"
            backgroundColor="{{ currentSourceRow.cat_id === 999 ? 'FFED6F' : '' }}"
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "1",
            }}
            groupAggregationMode="average"
            key="sale_rate_qty"
            label="수량소진율"
            placeholder="Enter value"
            position="center"
            size={91.90625}
            summaryAggregationMode="none"
          />
          <Column
            id="707af"
            alignment="right"
            backgroundColor="{{ currentSourceRow.cat_id === 777 ? '#ccebc5':
   currentSourceRow.cat_id === 888 ? '#ccebc5': 
   currentSourceRow.cat_id === 999 ? '#bebada':
  '#efefef'}}"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "0",
            }}
            groupAggregationMode="sum"
            key="tot_in_cost_amt"
            label="누적입고구입가(+)"
            placeholder="Enter value"
            position="center"
            size={124.265625}
            summaryAggregationMode="none"
            valueOverride="{{ item/1000000 }}"
          />
          <Column
            id="7c436"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            hidden="true"
            key="mark_up"
            label="Mark up"
            placeholder="Enter value"
            position="center"
            size={62.09375}
            summaryAggregationMode="none"
          />
          <Column
            id="e26d4"
            alignment="right"
            backgroundColor="{{ currentSourceRow.cat_id === 777 ? '#ccebc5':
   currentSourceRow.cat_id === 888 ? '#ccebc5': 
   currentSourceRow.cat_id === 999 ? '#bebada':
  '#efefef'}}"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "0",
            }}
            groupAggregationMode="sum"
            key="tot_in_tag"
            label="누적입고금액(TAG)"
            placeholder="Enter value"
            position="center"
            size={136.28125}
            summaryAggregationMode="none"
            valueOverride="{{ item/1000000 }}"
          />
          <Column
            id="d1306"
            alignment="right"
            backgroundColor="{{ currentSourceRow.cat_id === 777 ? '#ccebc5':
   currentSourceRow.cat_id === 888 ? '#ccebc5': 
   currentSourceRow.cat_id === 999 ? '#bebada':
  '#efefef'}}"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "0",
            }}
            groupAggregationMode="sum"
            key="tot_sale_tag"
            label="누적판매금액(TAG)"
            placeholder="Enter value"
            position="center"
            size={132.28125}
            summaryAggregationMode="none"
            valueOverride="{{ item/1000000 }}"
          />
          <Column
            id="cad57"
            alignment="right"
            backgroundColor="{{ currentSourceRow.cat_id === 777 ? '#ccebc5':
   currentSourceRow.cat_id === 888 ? '#ccebc5': 
   currentSourceRow.cat_id === 999 ? 'FFED6F':
  'efefef'}}
"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "0",
            }}
            groupAggregationMode="sum"
            key="tot_sale_amt"
            label="누적실판매금액"
            placeholder="Enter value"
            position="center"
            size={99.65625}
            summaryAggregationMode="none"
            valueOverride="{{ item/1000000 }}"
          />
          <Column
            id="730ef"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "1",
            }}
            groupAggregationMode="average"
            key="sale_rate_tag"
            label="소진율(TAG)"
            placeholder="Enter value"
            position="center"
            size={110.140625}
            summaryAggregationMode="none"
          />
          <Column
            id="07ab1"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "1",
            }}
            groupAggregationMode="average"
            key="sale_rate_amt"
            label="소진율(실판매)"
            placeholder="Enter value"
            position="center"
            size={106.96875}
            summaryAggregationMode="none"
          />
          <Column
            id="e829e"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "1",
            }}
            groupAggregationMode="average"
            key="discount_rate"
            label="할인율"
            placeholder="Enter value"
            position="center"
            size={74.140625}
            summaryAggregationMode="none"
          />
          <Column
            id="77c93"
            alignment="right"
            backgroundColor="{{ currentSourceRow.cat_id === 777 ? '#ccebc5':
   currentSourceRow.cat_id === 888 ? '#ccebc5': 
   currentSourceRow.cat_id === 999 ? '#bebada':
  '#fccde5'}}"
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "1",
            }}
            groupAggregationMode="average"
            key="sale_share_in"
            label="입고비중(TAG)"
            placeholder="Enter value"
            position="center"
            size={100}
            summaryAggregationMode="none"
          />
          <Column
            id="4c049"
            alignment="right"
            backgroundColor="{{ currentSourceRow.cat_id === 777 ? '#ccebc5':
   currentSourceRow.cat_id === 888 ? '#ccebc5': 
   currentSourceRow.cat_id === 999 ? '#bebada':
  '#fccde5'}}"
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "1",
            }}
            groupAggregationMode="average"
            key="sale_share_out"
            label="판매비중(TAG)"
            placeholder="Enter value"
            position="center"
            size={100}
            summaryAggregationMode="none"
          />
          <Column
            id="efe46"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="inven_qty"
            label="재고수량"
            placeholder="Enter value"
            position="center"
            size={86.171875}
            summaryAggregationMode="none"
          />
          <Column
            id="0328e"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "0",
            }}
            groupAggregationMode="sum"
            key="inven_tag"
            label="재고금액"
            placeholder="Enter value"
            position="center"
            size={98.78125}
            summaryAggregationMode="none"
            valueOverride="{{ item/1000000 }}"
          />
          <Column
            id="64f70"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            hidden="true"
            key="ttl_index"
            label="Ttl index"
            placeholder="Enter value"
            position="center"
            size={65.046875}
            summaryAggregationMode="none"
          />
          <Column
            id="9e2be"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            hidden="true"
            key="monthly_sale_qty"
            label="Monthly sale qty"
            placeholder="Enter value"
            position="center"
            size={109.953125}
            summaryAggregationMode="none"
          />
          <Column
            id="31380"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            hidden="true"
            key="monthly_sale_tag"
            label="Monthly sale tag"
            placeholder="Enter value"
            position="center"
            size={110.046875}
            summaryAggregationMode="none"
          />
          <Column
            id="7d78f"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            hidden="true"
            key="monthly_sale_amt"
            label="Monthly sale amt"
            placeholder="Enter value"
            position="center"
            size={113.15625}
            summaryAggregationMode="none"
          />
          <Column
            id="f7575"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="last_week_sale_qty"
            label="전주판매량"
            placeholder="Enter value"
            position="center"
            size={85.90625}
            summaryAggregationMode="none"
          />
          <Column
            id="a1204"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="currency"
            formatOptions={{
              currency: "KRW",
              currencySign: "standard",
              notation: "standard",
              showSeparators: true,
              currencyDisplay: "symbol",
              decimalPlaces: "0",
            }}
            groupAggregationMode="sum"
            hidden="true"
            key="last_week_sale_tag"
            label="전주판매금액(TAG)"
            placeholder="Enter value"
            position="center"
            size={110.28125}
            summaryAggregationMode="none"
            valueOverride="{{ item/100000 }}"
          />
          <Column
            id="fb8e5"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "0",
            }}
            groupAggregationMode="sum"
            key="last_week_sale_amt"
            label="전주실판매금액"
            placeholder="Enter value"
            position="center"
            size={108.65625}
            summaryAggregationMode="none"
            valueOverride="{{ item/1000000 }}"
          />
          <Column
            id="c1fef"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "1",
            }}
            groupAggregationMode="average"
            key="last_week_progress_rate"
            label="전주판매진도율"
            placeholder="Enter value"
            position="center"
            size={104.65625}
            summaryAggregationMode="none"
          />
          <Column
            id="e369a"
            alignment="right"
            backgroundColor="{{ currentSourceRow.cat_id === 777 ? '#ccebc5':
   currentSourceRow.cat_id === 888 ? '#ccebc5': 
   currentSourceRow.cat_id === 999 ? '#bebada':
  '#ff9e93'}}"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="this_week_sale_qty"
            label="금주판매량"
            placeholder="Enter value"
            position="center"
            size={93.90625}
            summaryAggregationMode="none"
          />
          <Column
            id="7ed08"
            alignment="right"
            backgroundColor="{{ currentSourceRow.cat_id === 777 ? '#ccebc5':
   currentSourceRow.cat_id === 888 ? '#ccebc5': 
   currentSourceRow.cat_id === 999 ? '#bebada':
  '#ff9e93'}}"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "0",
            }}
            groupAggregationMode="sum"
            key="this_week_sale_tag"
            label="금주판매금액(TAG)"
            placeholder="Enter value"
            position="center"
            size={135.28125}
            summaryAggregationMode="none"
            valueOverride="{{ item/1000000 }}"
          />
          <Column
            id="22f34"
            alignment="right"
            backgroundColor="{{ currentSourceRow.cat_id === 777 ? '#ccebc5':
   currentSourceRow.cat_id === 888 ? '#ccebc5': 
   currentSourceRow.cat_id === 999 ? 'FFED6F':
  '#ff9e93'}}"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "0",
            }}
            groupAggregationMode="sum"
            key="this_week_sale_amt"
            label="금주실판매금액"
            placeholder="Enter value"
            position="center"
            size={107.65625}
            summaryAggregationMode="none"
            valueOverride="{{ item/1000000 }}"
          />
          <Column
            id="e82ba"
            alignment="right"
            backgroundColor="{{ currentSourceRow.cat_id === 777 ? '#ccebc5':
   currentSourceRow.cat_id === 888 ? '#ccebc5': 
   currentSourceRow.cat_id === 999 ? '#bebada':
  '#ff9e93'}}"
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "1",
            }}
            groupAggregationMode="average"
            key="this_week_progress_rate"
            label="금주판매진도율"
            placeholder="Enter value"
            position="center"
            size={92.65625}
            summaryAggregationMode="none"
          />
          <Column
            id="47abc"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "1",
            }}
            groupAggregationMode="average"
            label="진도율차"
            placeholder="Enter value"
            position="center"
            referenceId="진도율차"
            size={65.671875}
            summaryAggregationMode="none"
            valueOverride="{{currentSourceRow.this_week_progress_rate -currentSourceRow.last_week_progress_rate}}"
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
    <Container
      id="container5"
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      loading="{{ for_4_years_query.isFetching || for_4_years_middle_cat_query.isFetching }}"
      padding="0"
      showBody={true}
      showHeader={true}
    >
      <Header>
        <Text
          id="containerTitle3"
          margin="0"
          value="###### {{ moment().subtract('1','years').year() }}년 신상품 기준"
          verticalAlign="center"
        />
        <Text
          id="text23"
          margin="0"
          style={{
            ordered: [
              { fontSize: "10px" },
              { fontWeight: "500" },
              { fontFamily: "pretendard variable" },
            ],
          }}
          value="{{ period_prev_1year.value }}"
          verticalAlign="center"
        />
        <Text
          id="text20"
          horizontalAlign="right"
          margin="0"
          style={{
            ordered: [
              { fontSize: "11px" },
              { fontWeight: "600" },
              { fontFamily: "Inter" },
            ],
          }}
          value="단위: 백만원"
          verticalAlign="center"
        />
      </Header>
      <View id="3df7a" viewKey="View 1">
        <Table
          id="table2"
          cellSelection="none"
          clearChangesetOnSave={true}
          data="{{ var_large_cat.value.var_02 }}"
          defaultSelectedRow={{ mode: "none", indexType: "display", index: 0 }}
          emptyMessage="No rows found"
          enableExpandableRows={true}
          enableSaveActions={true}
          heightType="auto"
          margin="0"
          rowBackgroundColor="{{ currentRow.cat_id === 777 ? '#ccebc5':
   currentRow.cat_id === 888 ? '#ccebc5': 
   currentRow.cat_id === 999 ? '#bebada':
  'FFFFF'}}"
          rowHeight="small"
          showColumnBorders={true}
          showHeader={true}
          toolbarPosition="bottom"
        >
          <Include src="./src/table2ExpandedRow.rsx" />
          <Column
            id="7a863"
            alignment="left"
            format="markdown"
            groupAggregationMode="none"
            key="cat_nm"
            label="카테고리"
            placeholder="Enter value"
            position="left"
            size={85}
            summaryAggregationMode="none"
            valueOverride="**{{ item }}**"
          />
          <Column
            id="1a795"
            alignment="left"
            format="tag"
            formatOptions={{ automaticColors: true }}
            groupAggregationMode="none"
            hidden="true"
            key="season_code"
            label="Season code"
            placeholder="Select option"
            position="center"
            size={100}
            summaryAggregationMode="none"
          />
          <Column
            id="1db32"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            hidden="true"
            key="cat_id"
            label="Cat ID"
            placeholder="Enter value"
            position="center"
            size={100}
            summaryAggregationMode="none"
          />
          <Column
            id="17164"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            hidden="true"
            key="tot_ord_qty"
            label="발주수량"
            placeholder="Enter value"
            position="center"
            size={120}
            summaryAggregationMode="none"
          />
          <Column
            id="94fa2"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "0",
            }}
            groupAggregationMode="sum"
            key="tot_ord_tag"
            label="발주금액(TAG)"
            placeholder="Enter value"
            position="center"
            size={105}
            summaryAggregationMode="none"
            valueOverride="{{ item/1000000 }}"
          />
          <Column
            id="24d65"
            alignment="center"
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "0",
            }}
            groupAggregationMode="average"
            key="in_rate_tag"
            label="입고율(TAG)"
            placeholder="Enter value"
            position="center"
            size={101}
            summaryAggregationMode="none"
          />
          <Column
            id="5de09"
            alignment="center"
            backgroundColor="{{ currentSourceRow.cat_id === 777 ? '#ccebc5':
   currentSourceRow.cat_id === 888 ? '#ccebc5': 
   currentSourceRow.cat_id === 999 ? '#bebada':
  '#efefef'}}"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="ord_st"
            label="총컬러수"
            placeholder="Enter value"
            position="center"
            size={89}
            summaryAggregationMode="none"
          />
          <Column
            id="e5980"
            alignment="center"
            backgroundColor="{{ currentSourceRow.cat_id === 777 ? '#ccebc5':
   currentSourceRow.cat_id === 888 ? '#ccebc5': 
   currentSourceRow.cat_id === 999 ? '#bebada':
  '#efefef'}}"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            hidden="{{ var_hide_column.value?.[inventory_columns_toggle.value]?.find(i => i === 'in_st') }}"
            key="in_st"
            label="현재입고컬러수"
            placeholder="Enter value"
            position="center"
            size={113}
            summaryAggregationMode="none"
          />
          <Column
            id="52618"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            hidden="true"
            key="in_st_rate"
            label="In st rate"
            placeholder="Enter value"
            position="center"
            size={100}
            summaryAggregationMode="none"
          />
          <Column
            id="972b9"
            alignment="center"
            backgroundColor="{{ currentSourceRow.cat_id === 777 ? '#ccebc5':
   currentSourceRow.cat_id === 888 ? '#ccebc5': 
   currentSourceRow.cat_id === 999 ? '#bebada':
  '#efefef'}}"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            hidden="{{ var_hide_column.value?.[inventory_columns_toggle.value]?.find(i => i === 'out_st') }}"
            key="out_st"
            label="현재출고컬러수"
            placeholder="Enter value"
            position="center"
            size={118}
            summaryAggregationMode="none"
          />
          <Column
            id="e97c7"
            alignment="center"
            backgroundColor="{{ currentSourceRow.cat_id === 777 ? '#ccebc5':
   currentSourceRow.cat_id === 888 ? '#ccebc5': 
   currentSourceRow.cat_id === 999 ? '#bebada':
  '#efefef'}}"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            hidden="{{ var_hide_column.value?.[inventory_columns_toggle.value]?.find(i => i === 'not_in_st') }}"
            key="not_in_st"
            label="미입고컬러수"
            placeholder="Enter value"
            position="center"
            size={108}
            summaryAggregationMode="none"
          />
          <Column
            id="ee4ce"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            hidden="true"
            key="not_out_st"
            label="Not out st"
            placeholder="Enter value"
            position="center"
            size={100}
            summaryAggregationMode="none"
          />
          <Column
            id="92668"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            hidden="true"
            key="out_st_rate"
            label="Out st rate"
            placeholder="Enter value"
            position="center"
            size={100}
            summaryAggregationMode="none"
          />
          <Column
            id="d0354"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="tot_in_qty"
            label="총입고수량"
            placeholder="Enter value"
            position="center"
            size={80}
            summaryAggregationMode="none"
          />
          <Column
            id="18d8c"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="tot_sale_qty"
            label="총판매수량"
            placeholder="Enter value"
            position="center"
            size={85}
            summaryAggregationMode="none"
          />
          <Column
            id="84e2f"
            alignment="center"
            backgroundColor="{{ currentSourceRow.cat_id === 999 ? 'FFED6F' : '' }}"
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "1",
            }}
            groupAggregationMode="average"
            key="sale_rate_qty"
            label="수량소진율"
            placeholder="Enter value"
            position="center"
            size={95}
            summaryAggregationMode="none"
          />
          <Column
            id="707af"
            alignment="right"
            backgroundColor="{{ currentSourceRow.cat_id === 777 ? '#ccebc5':
   currentSourceRow.cat_id === 888 ? '#ccebc5': 
   currentSourceRow.cat_id === 999 ? '#bebada':
  '#efefef'}}"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "0",
            }}
            groupAggregationMode="sum"
            key="tot_in_cost_amt"
            label="누적입고구입가(+)"
            placeholder="Enter value"
            position="center"
            size={122}
            summaryAggregationMode="none"
            valueOverride="{{ item/1000000 }}"
          />
          <Column
            id="7c436"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            hidden="true"
            key="mark_up"
            label="Mark up"
            placeholder="Enter value"
            position="center"
            size={71}
            summaryAggregationMode="none"
          />
          <Column
            id="e26d4"
            alignment="right"
            backgroundColor="{{ currentSourceRow.cat_id === 777 ? '#ccebc5':
   currentSourceRow.cat_id === 888 ? '#ccebc5': 
   currentSourceRow.cat_id === 999 ? '#bebada':
  '#efefef'}}"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "0",
            }}
            groupAggregationMode="sum"
            key="tot_in_tag"
            label="누적입고금액(TAG)"
            placeholder="Enter value"
            position="center"
            size={133}
            summaryAggregationMode="none"
            valueOverride="{{ item/1000000 }}"
          />
          <Column
            id="d1306"
            alignment="right"
            backgroundColor="{{ currentSourceRow.cat_id === 777 ? '#ccebc5':
   currentSourceRow.cat_id === 888 ? '#ccebc5': 
   currentSourceRow.cat_id === 999 ? '#bebada':
  '#efefef'}}"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "0",
            }}
            groupAggregationMode="sum"
            key="tot_sale_tag"
            label="누적판매금액(TAG)"
            placeholder="Enter value"
            position="center"
            size={132}
            summaryAggregationMode="none"
            valueOverride="{{ item/1000000 }}"
          />
          <Column
            id="cad57"
            alignment="right"
            backgroundColor="{{ currentSourceRow.cat_id === 777 ? '#ccebc5':
   currentSourceRow.cat_id === 888 ? '#ccebc5': 
   currentSourceRow.cat_id === 999 ? 'FFED6F':
  'efefef'}}
"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "0",
            }}
            groupAggregationMode="sum"
            key="tot_sale_amt"
            label="누적실판매금액"
            placeholder="Enter value"
            position="center"
            size={105}
            summaryAggregationMode="none"
            valueOverride="{{ item/1000000 }}"
          />
          <Column
            id="730ef"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "1",
            }}
            groupAggregationMode="average"
            key="sale_rate_tag"
            label="소진율(TAG)"
            placeholder="Enter value"
            position="center"
            size={108}
            summaryAggregationMode="none"
          />
          <Column
            id="07ab1"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "1",
            }}
            groupAggregationMode="average"
            key="sale_rate_amt"
            label="소진율(실판매)"
            placeholder="Enter value"
            position="center"
            size={108}
            summaryAggregationMode="none"
          />
          <Column
            id="e829e"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "1",
            }}
            groupAggregationMode="average"
            key="discount_rate"
            label="할인율"
            placeholder="Enter value"
            position="center"
            size={74}
            summaryAggregationMode="none"
          />
          <Column
            id="f5554"
            alignment="center"
            backgroundColor="{{ currentSourceRow.cat_id === 777 ? '#ccebc5':
   currentSourceRow.cat_id === 888 ? '#ccebc5': 
   currentSourceRow.cat_id === 999 ? '#bebada':
  '#fccde5'}}"
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "1",
            }}
            groupAggregationMode="average"
            key="sale_share_in"
            label="입고비중(TAG)"
            placeholder="Enter value"
            position="center"
            size={101}
            summaryAggregationMode="none"
          />
          <Column
            id="1164d"
            alignment="center"
            backgroundColor="{{ currentSourceRow.cat_id === 777 ? '#ccebc5':
   currentSourceRow.cat_id === 888 ? '#ccebc5': 
   currentSourceRow.cat_id === 999 ? '#bebada':
  '#fccde5'}}"
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "1",
            }}
            groupAggregationMode="average"
            key="sale_share_out"
            label="판매비중(TAG)"
            placeholder="Enter value"
            position="center"
            size={100}
            summaryAggregationMode="none"
          />
          <Column
            id="efe46"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="inven_qty"
            label="재고수량"
            placeholder="Enter value"
            position="center"
            size={88}
            summaryAggregationMode="none"
          />
          <Column
            id="0328e"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "0",
            }}
            groupAggregationMode="sum"
            key="inven_tag"
            label="재고금액"
            placeholder="Enter value"
            position="center"
            size={98}
            summaryAggregationMode="none"
            valueOverride="{{ item/1000000 }}"
          />
          <Column
            id="64f70"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            hidden="true"
            key="ttl_index"
            label="Ttl index"
            placeholder="Enter value"
            position="center"
            size={100}
            summaryAggregationMode="none"
          />
          <Column
            id="9e2be"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            hidden="true"
            key="monthly_sale_qty"
            label="Monthly sale qty"
            placeholder="Enter value"
            position="center"
            size={100}
            summaryAggregationMode="none"
          />
          <Column
            id="31380"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            hidden="true"
            key="monthly_sale_tag"
            label="Monthly sale tag"
            placeholder="Enter value"
            position="center"
            size={100}
            summaryAggregationMode="none"
          />
          <Column
            id="7d78f"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            hidden="true"
            key="monthly_sale_amt"
            label="Monthly sale amt"
            placeholder="Enter value"
            position="center"
            size={100}
            summaryAggregationMode="none"
          />
          <Column
            id="f7575"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="last_week_sale_qty"
            label="전주판매량"
            placeholder="Enter value"
            position="center"
            size={87}
            summaryAggregationMode="none"
          />
          <Column
            id="a1204"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="currency"
            formatOptions={{
              currency: "KRW",
              currencySign: "standard",
              notation: "standard",
              showSeparators: true,
              currencyDisplay: "symbol",
              decimalPlaces: "0",
            }}
            groupAggregationMode="sum"
            hidden="true"
            key="last_week_sale_tag"
            label="전주판매금액(TAG)"
            placeholder="Enter value"
            position="center"
            size={117}
            summaryAggregationMode="none"
            valueOverride="{{ item/100000 }}"
          />
          <Column
            id="fb8e5"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "0",
            }}
            groupAggregationMode="sum"
            key="last_week_sale_amt"
            label="전주실판매금액"
            placeholder="Enter value"
            position="center"
            size={109}
            summaryAggregationMode="none"
            valueOverride="{{ item/1000000 }}"
          />
          <Column
            id="c1fef"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "1",
            }}
            groupAggregationMode="average"
            key="last_week_progress_rate"
            label="전주판매진도율"
            placeholder="Enter value"
            position="center"
            size={104}
            summaryAggregationMode="none"
          />
          <Column
            id="e369a"
            alignment="right"
            backgroundColor="{{ currentSourceRow.cat_id === 777 ? '#ccebc5':
   currentSourceRow.cat_id === 888 ? '#ccebc5': 
   currentSourceRow.cat_id === 999 ? '#bebada':
  '#ff9e93'}}"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="this_week_sale_qty"
            label="금주판매량"
            placeholder="Enter value"
            position="center"
            size={95}
            summaryAggregationMode="none"
          />
          <Column
            id="7ed08"
            alignment="right"
            backgroundColor="{{ currentSourceRow.cat_id === 777 ? '#ccebc5':
   currentSourceRow.cat_id === 888 ? '#ccebc5': 
   currentSourceRow.cat_id === 999 ? '#bebada':
  '#ff9e93'}}"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "0",
            }}
            groupAggregationMode="sum"
            key="this_week_sale_tag"
            label="금주판매금액(TAG)"
            placeholder="Enter value"
            position="center"
            size={129}
            summaryAggregationMode="none"
            valueOverride="{{ item/1000000 }}"
          />
          <Column
            id="22f34"
            alignment="right"
            backgroundColor="{{ currentSourceRow.cat_id === 777 ? '#ccebc5':
   currentSourceRow.cat_id === 888 ? '#ccebc5': 
   currentSourceRow.cat_id === 999 ? 'FFED6F':
  '#ff9e93'}}"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "0",
            }}
            groupAggregationMode="sum"
            key="this_week_sale_amt"
            label="금주실판매금액"
            placeholder="Enter value"
            position="center"
            size={115}
            summaryAggregationMode="none"
            valueOverride="{{ item/1000000 }}"
          />
          <Column
            id="e82ba"
            alignment="right"
            backgroundColor="{{ currentSourceRow.cat_id === 777 ? '#ccebc5':
   currentSourceRow.cat_id === 888 ? '#ccebc5': 
   currentSourceRow.cat_id === 999 ? '#bebada':
  '#ff9e93'}}"
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "1",
            }}
            groupAggregationMode="average"
            key="this_week_progress_rate"
            label="금주판매진도율"
            placeholder="Enter value"
            position="center"
            size={95}
            summaryAggregationMode="none"
          />
          <Column
            id="47abc"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="average"
            label="진도율차"
            placeholder="Enter value"
            position="center"
            referenceId="진도율차"
            size={100}
            summaryAggregationMode="none"
            valueOverride="{{currentSourceRow.this_week_progress_rate -currentSourceRow.last_week_progress_rate}}"
          />
          <Column
            id="42514"
            alignment="left"
            format="tag"
            formatOptions={{ automaticColors: true }}
            groupAggregationMode="none"
            hidden="true"
            key="year_cd"
            label="Year cd"
            placeholder="Select option"
            position="center"
            size={100}
            summaryAggregationMode="none"
            valueOverride="{{ _.startCase(item) }}"
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
              pluginId="table2"
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
              pluginId="table2"
              type="widget"
              waitMs="0"
              waitType="debounce"
            />
          </ToolbarButton>
        </Table>
      </View>
    </Container>
    <Container
      id="container6"
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      loading="{{ for_4_years_query.isFetching || for_4_years_middle_cat_query.isFetching }}"
      padding="0"
      showBody={true}
      showHeader={true}
    >
      <Header>
        <Text
          id="containerTitle4"
          margin="0"
          value="###### {{ moment().subtract('2','years').year() }}년 신상품 기준"
          verticalAlign="center"
        />
        <Text
          id="text24"
          margin="0"
          style={{
            ordered: [
              { fontSize: "10px" },
              { fontWeight: "500" },
              { fontFamily: "pretendard variable" },
            ],
          }}
          value="{{ period_prev_2year.value }}"
          verticalAlign="center"
        />
        <Text
          id="text19"
          horizontalAlign="right"
          margin="0"
          style={{
            ordered: [
              { fontSize: "11px" },
              { fontWeight: "600" },
              { fontFamily: "Inter" },
            ],
          }}
          value="단위: 백만원"
          verticalAlign="center"
        />
      </Header>
      <View id="3df7a" viewKey="View 1">
        <Table
          id="table3"
          cellSelection="none"
          clearChangesetOnSave={true}
          data="{{ var_large_cat.value.var_03 }}"
          defaultSelectedRow={{ mode: "none", indexType: "display", index: 0 }}
          emptyMessage="No rows found"
          enableExpandableRows={true}
          enableSaveActions={true}
          heightType="auto"
          margin="0"
          rowBackgroundColor="{{ currentRow.cat_id === 777 ? '#ccebc5':
   currentRow.cat_id === 888 ? '#ccebc5': 
   currentRow.cat_id === 999 ? '#bebada':
  'FFFFF'}}"
          rowHeight="small"
          showColumnBorders={true}
          showHeader={true}
          toolbarPosition="bottom"
        >
          <Include src="./src/table3ExpandedRow.rsx" />
          <Column
            id="7a863"
            alignment="left"
            format="markdown"
            groupAggregationMode="none"
            key="cat_nm"
            label="카테고리"
            placeholder="Enter value"
            position="left"
            size={85}
            summaryAggregationMode="none"
            valueOverride="**{{ item }}**"
          />
          <Column
            id="cc286"
            alignment="left"
            format="tag"
            formatOptions={{ automaticColors: true }}
            groupAggregationMode="none"
            hidden="true"
            key="season_code"
            label="Season code"
            placeholder="Select option"
            position="center"
            size={100}
            summaryAggregationMode="none"
          />
          <Column
            id="1db32"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            hidden="true"
            key="cat_id"
            label="Cat ID"
            placeholder="Enter value"
            position="center"
            size={100}
            summaryAggregationMode="none"
          />
          <Column
            id="17164"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            hidden="true"
            key="tot_ord_qty"
            label="발주수량"
            placeholder="Enter value"
            position="center"
            size={72}
            summaryAggregationMode="none"
          />
          <Column
            id="94fa2"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "0",
            }}
            groupAggregationMode="sum"
            key="tot_ord_tag"
            label="발주금액(TAG)"
            placeholder="Enter value"
            position="center"
            size={105}
            summaryAggregationMode="none"
            valueOverride="{{ item/1000000 }}"
          />
          <Column
            id="24d65"
            alignment="center"
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "0",
            }}
            groupAggregationMode="average"
            key="in_rate_tag"
            label="입고율(TAG)"
            placeholder="Enter value"
            position="center"
            size={101}
            summaryAggregationMode="none"
          />
          <Column
            id="5de09"
            alignment="center"
            backgroundColor="{{ currentSourceRow.cat_id === 777 ? '#ccebc5':
   currentSourceRow.cat_id === 888 ? '#ccebc5': 
   currentSourceRow.cat_id === 999 ? '#bebada':
  '#efefef'}}"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="ord_st"
            label="총컬러수"
            placeholder="Enter value"
            position="center"
            size={90}
            summaryAggregationMode="none"
          />
          <Column
            id="e5980"
            alignment="center"
            backgroundColor="{{ currentSourceRow.cat_id === 777 ? '#ccebc5':
   currentSourceRow.cat_id === 888 ? '#ccebc5': 
   currentSourceRow.cat_id === 999 ? '#bebada':
  '#efefef'}}"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            hidden="{{ var_hide_column.value?.[inventory_columns_toggle.value]?.find(i => i === 'in_st') }}"
            key="in_st"
            label="현재입고컬러수"
            placeholder="Enter value"
            position="center"
            size={116}
            summaryAggregationMode="none"
          />
          <Column
            id="52618"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            hidden="true"
            key="in_st_rate"
            label="In st rate"
            placeholder="Enter value"
            position="center"
            size={100}
            summaryAggregationMode="none"
          />
          <Column
            id="972b9"
            alignment="center"
            backgroundColor="{{ currentSourceRow.cat_id === 777 ? '#ccebc5':
   currentSourceRow.cat_id === 888 ? '#ccebc5': 
   currentSourceRow.cat_id === 999 ? '#bebada':
  '#efefef'}}"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            hidden="{{ var_hide_column.value?.[inventory_columns_toggle.value]?.find(i => i === 'out_st') }}"
            key="out_st"
            label="현재출고컬러수"
            placeholder="Enter value"
            position="center"
            size={115}
            summaryAggregationMode="none"
          />
          <Column
            id="e97c7"
            alignment="center"
            backgroundColor="{{ currentSourceRow.cat_id === 777 ? '#ccebc5':
   currentSourceRow.cat_id === 888 ? '#ccebc5': 
   currentSourceRow.cat_id === 999 ? '#bebada':
  '#efefef'}}"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            hidden="{{ var_hide_column.value?.[inventory_columns_toggle.value]?.find(i => i === 'not_in_st') }}"
            key="not_in_st"
            label="미입고컬러수"
            placeholder="Enter value"
            position="center"
            size={106}
            summaryAggregationMode="none"
          />
          <Column
            id="ee4ce"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            hidden="true"
            key="not_out_st"
            label="Not out st"
            placeholder="Enter value"
            position="center"
            size={100}
            summaryAggregationMode="none"
          />
          <Column
            id="92668"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            hidden="true"
            key="out_st_rate"
            label="Out st rate"
            placeholder="Enter value"
            position="center"
            size={100}
            summaryAggregationMode="none"
          />
          <Column
            id="d0354"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="tot_in_qty"
            label="총입고수량"
            placeholder="Enter value"
            position="center"
            size={84}
            summaryAggregationMode="none"
          />
          <Column
            id="18d8c"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="tot_sale_qty"
            label="총판매수량"
            placeholder="Enter value"
            position="center"
            size={82}
            summaryAggregationMode="none"
          />
          <Column
            id="84e2f"
            alignment="center"
            backgroundColor="{{ currentSourceRow.cat_id === 999 ? 'FFED6F' : '' }}"
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "1",
            }}
            groupAggregationMode="average"
            key="sale_rate_qty"
            label="수량소진율"
            placeholder="Enter value"
            position="center"
            size={99}
            summaryAggregationMode="none"
          />
          <Column
            id="707af"
            alignment="right"
            backgroundColor="{{ currentSourceRow.cat_id === 777 ? '#ccebc5':
   currentSourceRow.cat_id === 888 ? '#ccebc5': 
   currentSourceRow.cat_id === 999 ? '#bebada':
  '#efefef'}}"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "0",
            }}
            groupAggregationMode="sum"
            key="tot_in_cost_amt"
            label="누적입고구입가(+)"
            placeholder="Enter value"
            position="center"
            size={120}
            summaryAggregationMode="none"
            valueOverride="{{ item/1000000 }}"
          />
          <Column
            id="7c436"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            hidden="true"
            key="mark_up"
            label="Mark up"
            placeholder="Enter value"
            position="center"
            size={71}
            summaryAggregationMode="none"
          />
          <Column
            id="e26d4"
            alignment="right"
            backgroundColor="{{ currentSourceRow.cat_id === 777 ? '#ccebc5':
   currentSourceRow.cat_id === 888 ? '#ccebc5': 
   currentSourceRow.cat_id === 999 ? '#bebada':
  '#efefef'}}"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "0",
            }}
            groupAggregationMode="sum"
            key="tot_in_tag"
            label="누적입고금액(TAG)"
            placeholder="Enter value"
            position="center"
            size={128}
            summaryAggregationMode="none"
            valueOverride="{{ item/1000000 }}"
          />
          <Column
            id="d1306"
            alignment="right"
            backgroundColor="{{ currentSourceRow.cat_id === 777 ? '#ccebc5':
   currentSourceRow.cat_id === 888 ? '#ccebc5': 
   currentSourceRow.cat_id === 999 ? '#bebada':
  '#efefef'}}"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "0",
            }}
            groupAggregationMode="sum"
            key="tot_sale_tag"
            label="누적판매금액(TAG)"
            placeholder="Enter value"
            position="center"
            size={131}
            summaryAggregationMode="none"
            valueOverride="{{ item/1000000 }}"
          />
          <Column
            id="cad57"
            alignment="right"
            backgroundColor="{{ currentSourceRow.cat_id === 777 ? '#ccebc5':
   currentSourceRow.cat_id === 888 ? '#ccebc5': 
   currentSourceRow.cat_id === 999 ? 'FFED6F':
  'efefef'}}
"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "0",
            }}
            groupAggregationMode="sum"
            key="tot_sale_amt"
            label="누적실판매금액"
            placeholder="Enter value"
            position="center"
            size={94}
            summaryAggregationMode="none"
            valueOverride="{{ item/1000000 }}"
          />
          <Column
            id="730ef"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "1",
            }}
            groupAggregationMode="average"
            key="sale_rate_tag"
            label="소진율(TAG)"
            placeholder="Enter value"
            position="center"
            size={110}
            summaryAggregationMode="none"
          />
          <Column
            id="07ab1"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "1",
            }}
            groupAggregationMode="average"
            key="sale_rate_amt"
            label="소진율(실판매)"
            placeholder="Enter value"
            position="center"
            size={105}
            summaryAggregationMode="none"
          />
          <Column
            id="e829e"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "1",
            }}
            groupAggregationMode="average"
            key="discount_rate"
            label="할인율"
            placeholder="Enter value"
            position="center"
            size={76}
            summaryAggregationMode="none"
          />
          <Column
            id="f5554"
            alignment="center"
            backgroundColor="{{ currentSourceRow.cat_id === 777 ? '#ccebc5':
   currentSourceRow.cat_id === 888 ? '#ccebc5': 
   currentSourceRow.cat_id === 999 ? '#bebada':
  '#fccde5'}}"
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "1",
            }}
            groupAggregationMode="average"
            key="sale_share_in"
            label="입고비중(TAG)"
            placeholder="Enter value"
            position="center"
            size={106}
            summaryAggregationMode="none"
          />
          <Column
            id="1164d"
            alignment="center"
            backgroundColor="{{ currentSourceRow.cat_id === 777 ? '#ccebc5':
   currentSourceRow.cat_id === 888 ? '#ccebc5': 
   currentSourceRow.cat_id === 999 ? '#bebada':
  '#fccde5'}}"
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "1",
            }}
            groupAggregationMode="average"
            key="sale_share_out"
            label="판매비중(TAG)"
            placeholder="Enter value"
            position="center"
            size={97}
            summaryAggregationMode="none"
          />
          <Column
            id="efe46"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="inven_qty"
            label="재고수량"
            placeholder="Enter value"
            position="center"
            size={88}
            summaryAggregationMode="none"
          />
          <Column
            id="0328e"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "0\\0",
            }}
            groupAggregationMode="sum"
            key="inven_tag"
            label="재고금액"
            placeholder="Enter value"
            position="center"
            size={99}
            summaryAggregationMode="none"
            valueOverride="{{ item/1000000 }}"
          />
          <Column
            id="64f70"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            hidden="true"
            key="ttl_index"
            label="Ttl index"
            placeholder="Enter value"
            position="center"
            size={100}
            summaryAggregationMode="none"
          />
          <Column
            id="9e2be"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            hidden="true"
            key="monthly_sale_qty"
            label="Monthly sale qty"
            placeholder="Enter value"
            position="center"
            size={100}
            summaryAggregationMode="none"
          />
          <Column
            id="31380"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            hidden="true"
            key="monthly_sale_tag"
            label="Monthly sale tag"
            placeholder="Enter value"
            position="center"
            size={100}
            summaryAggregationMode="none"
          />
          <Column
            id="7d78f"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            hidden="true"
            key="monthly_sale_amt"
            label="Monthly sale amt"
            placeholder="Enter value"
            position="center"
            size={100}
            summaryAggregationMode="none"
          />
          <Column
            id="f7575"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="last_week_sale_qty"
            label="전주판매량"
            placeholder="Enter value"
            position="center"
            size={84}
            summaryAggregationMode="none"
          />
          <Column
            id="a1204"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="currency"
            formatOptions={{
              currency: "KRW",
              currencySign: "standard",
              notation: "standard",
              showSeparators: true,
              currencyDisplay: "symbol",
              decimalPlaces: "0",
            }}
            groupAggregationMode="sum"
            hidden="true"
            key="last_week_sale_tag"
            label="전주판매금액(TAG)"
            placeholder="Enter value"
            position="center"
            size={117}
            summaryAggregationMode="none"
            valueOverride="{{ item/100000 }}"
          />
          <Column
            id="fb8e5"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "0",
            }}
            groupAggregationMode="sum"
            key="last_week_sale_amt"
            label="전주실판매금액"
            placeholder="Enter value"
            position="center"
            size={111}
            summaryAggregationMode="none"
            valueOverride="{{ item/1000000 }}"
          />
          <Column
            id="c1fef"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "1",
            }}
            groupAggregationMode="average"
            key="last_week_progress_rate"
            label="전주판매진도율"
            placeholder="Enter value"
            position="center"
            size={108}
            summaryAggregationMode="none"
          />
          <Column
            id="e369a"
            alignment="right"
            backgroundColor="{{ currentSourceRow.cat_id === 777 ? '#ccebc5':
   currentSourceRow.cat_id === 888 ? '#ccebc5': 
   currentSourceRow.cat_id === 999 ? '#bebada':
  '#ff9e93'}}"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="this_week_sale_qty"
            label="금주판매량"
            placeholder="Enter value"
            position="center"
            size={95}
            summaryAggregationMode="none"
          />
          <Column
            id="7ed08"
            alignment="right"
            backgroundColor="{{ currentSourceRow.cat_id === 777 ? '#ccebc5':
   currentSourceRow.cat_id === 888 ? '#ccebc5': 
   currentSourceRow.cat_id === 999 ? '#bebada':
  '#ff9e93'}}"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "0",
            }}
            groupAggregationMode="sum"
            key="this_week_sale_tag"
            label="금주판매금액(TAG)"
            placeholder="Enter value"
            position="center"
            size={126}
            summaryAggregationMode="none"
            valueOverride="{{ item/1000000 }}"
          />
          <Column
            id="22f34"
            alignment="right"
            backgroundColor="{{ currentSourceRow.cat_id === 777 ? '#ccebc5':
   currentSourceRow.cat_id === 888 ? '#ccebc5': 
   currentSourceRow.cat_id === 999 ? 'FFED6F':
  '#ff9e93'}}"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "0",
            }}
            groupAggregationMode="sum"
            key="this_week_sale_amt"
            label="금주실판매금액"
            placeholder="Enter value"
            position="center"
            size={106}
            summaryAggregationMode="none"
            valueOverride="{{ item/1000000 }}"
          />
          <Column
            id="e82ba"
            alignment="right"
            backgroundColor="{{ currentSourceRow.cat_id === 777 ? '#ccebc5':
   currentSourceRow.cat_id === 888 ? '#ccebc5': 
   currentSourceRow.cat_id === 999 ? '#bebada':
  '#ff9e93'}}"
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "1",
            }}
            groupAggregationMode="average"
            key="this_week_progress_rate"
            label="금주판매진도율"
            placeholder="Enter value"
            position="center"
            size={107}
            summaryAggregationMode="none"
          />
          <Column
            id="47abc"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "1",
            }}
            groupAggregationMode="average"
            label="진도율차"
            placeholder="Enter value"
            position="center"
            referenceId="진도율차"
            size={100}
            summaryAggregationMode="none"
            valueOverride="{{currentSourceRow.this_week_progress_rate -currentSourceRow.last_week_progress_rate}}"
          />
          <Column
            id="42514"
            alignment="left"
            format="tag"
            formatOptions={{ automaticColors: true }}
            groupAggregationMode="none"
            hidden="true"
            key="year_cd"
            label="Year cd"
            placeholder="Select option"
            position="center"
            size={100}
            summaryAggregationMode="none"
            valueOverride="{{ _.startCase(item) }}"
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
              pluginId="table3"
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
              pluginId="table3"
              type="widget"
              waitMs="0"
              waitType="debounce"
            />
          </ToolbarButton>
        </Table>
      </View>
    </Container>
    <Container
      id="container7"
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      loading="{{ for_4_years_query.isFetching || for_4_years_middle_cat_query.isFetching }}"
      padding="0"
      showBody={true}
      showHeader={true}
    >
      <Header>
        <Text
          id="containerTitle5"
          margin="0"
          value="###### {{ moment().subtract('3','years').year() }}년 신상품 기준"
          verticalAlign="center"
        />
        <Text
          id="text25"
          margin="0"
          style={{
            ordered: [
              { fontSize: "10px" },
              { fontWeight: "500" },
              { fontFamily: "pretendard variable" },
            ],
          }}
          value="{{ period_prev_3year.value }}"
          verticalAlign="center"
        />
        <Text
          id="text18"
          horizontalAlign="right"
          margin="0"
          style={{
            ordered: [
              { fontSize: "11px" },
              { fontWeight: "600" },
              { fontFamily: "Inter" },
            ],
          }}
          value="단위: 백만원"
          verticalAlign="center"
        />
      </Header>
      <View id="3df7a" viewKey="View 1">
        <Table
          id="table4"
          cellSelection="none"
          clearChangesetOnSave={true}
          data="{{ var_large_cat.value.var_04 }}"
          defaultSelectedRow={{ mode: "none", indexType: "display", index: 0 }}
          emptyMessage="No rows found"
          enableExpandableRows={true}
          enableSaveActions={true}
          heightType="auto"
          margin="0"
          rowBackgroundColor="{{ currentRow.cat_id === 777 ? '#ccebc5':
   currentRow.cat_id === 888 ? '#ccebc5': 
   currentRow.cat_id === 999 ? '#bebada':
  'FFFFF'}}"
          rowHeight="small"
          showColumnBorders={true}
          showHeader={true}
          toolbarPosition="bottom"
        >
          <Include src="./src/table4ExpandedRow.rsx" />
          <Column
            id="7a863"
            alignment="left"
            format="markdown"
            groupAggregationMode="none"
            key="cat_nm"
            label="카테고리"
            placeholder="Enter value"
            position="left"
            size={86}
            summaryAggregationMode="none"
            valueOverride="**{{ item }}**"
          />
          <Column
            id="13107"
            alignment="left"
            format="tag"
            formatOptions={{ automaticColors: true }}
            groupAggregationMode="none"
            hidden="true"
            key="season_code"
            label="Season code"
            placeholder="Select option"
            position="center"
            size={100}
            summaryAggregationMode="none"
          />
          <Column
            id="1db32"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            hidden="true"
            key="cat_id"
            label="Cat ID"
            placeholder="Enter value"
            position="center"
            size={100}
            summaryAggregationMode="none"
          />
          <Column
            id="17164"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            hidden="true"
            key="tot_ord_qty"
            label="발주수량"
            placeholder="Enter value"
            position="center"
            size={72}
            summaryAggregationMode="none"
          />
          <Column
            id="94fa2"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "0",
            }}
            groupAggregationMode="sum"
            key="tot_ord_tag"
            label="발주금액(TAG)"
            placeholder="Enter value"
            position="center"
            size={106}
            summaryAggregationMode="none"
            valueOverride="{{ item/1000000 }}"
          />
          <Column
            id="24d65"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "0",
            }}
            groupAggregationMode="average"
            key="in_rate_tag"
            label="입고율(TAG)"
            placeholder="Enter value"
            position="center"
            size={104}
            summaryAggregationMode="none"
          />
          <Column
            id="5de09"
            alignment="right"
            backgroundColor="{{ currentSourceRow.cat_id === 777 ? '#ccebc5':
   currentSourceRow.cat_id === 888 ? '#ccebc5': 
   currentSourceRow.cat_id === 999 ? '#bebada':
  '#efefef'}}"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="ord_st"
            label="총컬러수"
            placeholder="Enter value"
            position="center"
            size={87}
            summaryAggregationMode="none"
          />
          <Column
            id="e5980"
            alignment="right"
            backgroundColor="{{ currentSourceRow.cat_id === 777 ? '#ccebc5':
   currentSourceRow.cat_id === 888 ? '#ccebc5': 
   currentSourceRow.cat_id === 999 ? '#bebada':
  '#efefef'}}"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            hidden="{{ var_hide_column.value?.[inventory_columns_toggle.value]?.find(i => i === 'in_st') }}"
            key="in_st"
            label="현재입고컬러수"
            placeholder="Enter value"
            position="center"
            size={118}
            summaryAggregationMode="none"
          />
          <Column
            id="52618"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            hidden="true"
            key="in_st_rate"
            label="In st rate"
            placeholder="Enter value"
            position="center"
            size={100}
            summaryAggregationMode="none"
          />
          <Column
            id="972b9"
            alignment="right"
            backgroundColor="{{ currentSourceRow.cat_id === 777 ? '#ccebc5':
   currentSourceRow.cat_id === 888 ? '#ccebc5': 
   currentSourceRow.cat_id === 999 ? '#bebada':
  '#efefef'}}"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            hidden="{{ var_hide_column.value?.[inventory_columns_toggle.value]?.find(i => i === 'out_st') }}"
            key="out_st"
            label="현재출고컬러수"
            placeholder="Enter value"
            position="center"
            size={118}
            summaryAggregationMode="none"
          />
          <Column
            id="e97c7"
            alignment="right"
            backgroundColor="{{ currentSourceRow.cat_id === 777 ? '#ccebc5':
   currentSourceRow.cat_id === 888 ? '#ccebc5': 
   currentSourceRow.cat_id === 999 ? '#bebada':
  '#efefef'}}"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            hidden="{{ var_hide_column.value?.[inventory_columns_toggle.value]?.find(i => i === 'not_in_st') }}"
            key="not_in_st"
            label="미입고컬러수"
            placeholder="Enter value"
            position="center"
            size={102}
            summaryAggregationMode="none"
          />
          <Column
            id="ee4ce"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            hidden="true"
            key="not_out_st"
            label="Not out st"
            placeholder="Enter value"
            position="center"
            size={100}
            summaryAggregationMode="none"
          />
          <Column
            id="92668"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            hidden="true"
            key="out_st_rate"
            label="Out st rate"
            placeholder="Enter value"
            position="center"
            size={100}
            summaryAggregationMode="none"
          />
          <Column
            id="d0354"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="tot_in_qty"
            label="입고수량"
            placeholder="Enter value"
            position="center"
            size={87}
            summaryAggregationMode="none"
          />
          <Column
            id="18d8c"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="tot_sale_qty"
            label="판매수량"
            placeholder="Enter value"
            position="center"
            size={87}
            summaryAggregationMode="none"
          />
          <Column
            id="84e2f"
            alignment="right"
            backgroundColor="{{ currentSourceRow.cat_id === 999 ? 'FFED6F' : '' }}"
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "1",
            }}
            groupAggregationMode="average"
            key="sale_rate_qty"
            label="수량소진율"
            placeholder="Enter value"
            position="center"
            size={97}
            summaryAggregationMode="none"
          />
          <Column
            id="707af"
            alignment="right"
            backgroundColor="{{ currentSourceRow.cat_id === 777 ? '#ccebc5':
   currentSourceRow.cat_id === 888 ? '#ccebc5': 
   currentSourceRow.cat_id === 999 ? '#bebada':
  '#efefef'}}"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "0",
            }}
            groupAggregationMode="sum"
            key="tot_in_cost_amt"
            label="누적입고구입가(+)"
            placeholder="Enter value"
            position="center"
            size={129}
            summaryAggregationMode="none"
            valueOverride="{{ item/1000000 }}"
          />
          <Column
            id="7c436"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            hidden="true"
            key="mark_up"
            label="Mark up"
            placeholder="Enter value"
            position="center"
            size={71}
            summaryAggregationMode="none"
          />
          <Column
            id="e26d4"
            alignment="right"
            backgroundColor="{{ currentSourceRow.cat_id === 777 ? '#ccebc5':
   currentSourceRow.cat_id === 888 ? '#ccebc5': 
   currentSourceRow.cat_id === 999 ? '#bebada':
  '#efefef'}}"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "0",
            }}
            groupAggregationMode="sum"
            key="tot_in_tag"
            label="누적입고금액(TAG)"
            placeholder="Enter value"
            position="center"
            size={133}
            summaryAggregationMode="none"
            valueOverride="{{ item/1000000 }}"
          />
          <Column
            id="d1306"
            alignment="right"
            backgroundColor="{{ currentSourceRow.cat_id === 777 ? '#ccebc5':
   currentSourceRow.cat_id === 888 ? '#ccebc5': 
   currentSourceRow.cat_id === 999 ? '#bebada':
  '#efefef'}}"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "0",
            }}
            groupAggregationMode="sum"
            key="tot_sale_tag"
            label="누적판매금액(TAG)"
            placeholder="Enter value"
            position="center"
            size={132}
            summaryAggregationMode="none"
            valueOverride="{{ item/1000000 }}"
          />
          <Column
            id="cad57"
            alignment="right"
            backgroundColor="{{ currentSourceRow.cat_id === 777 ? '#ccebc5':
   currentSourceRow.cat_id === 888 ? '#ccebc5': 
   currentSourceRow.cat_id === 999 ? 'FFED6F':
  'efefef'}}
"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "0",
            }}
            groupAggregationMode="sum"
            key="tot_sale_amt"
            label="누적실판매금액"
            placeholder="Enter value"
            position="center"
            size={116}
            summaryAggregationMode="none"
            valueOverride="{{ item/1000000 }}"
          />
          <Column
            id="730ef"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "1",
            }}
            groupAggregationMode="average"
            key="sale_rate_tag"
            label="소진율(TAG)"
            placeholder="Enter value"
            position="center"
            size={105}
            summaryAggregationMode="none"
          />
          <Column
            id="07ab1"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "1",
            }}
            groupAggregationMode="average"
            key="sale_rate_amt"
            label="소진율(실판매)"
            placeholder="Enter value"
            position="center"
            size={104}
            summaryAggregationMode="none"
          />
          <Column
            id="e829e"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "1",
            }}
            groupAggregationMode="average"
            key="discount_rate"
            label="할인율"
            placeholder="Enter value"
            position="center"
            size={87}
            summaryAggregationMode="none"
          />
          <Column
            id="f5554"
            alignment="center"
            backgroundColor="{{ currentSourceRow.cat_id === 777 ? '#ccebc5':
   currentSourceRow.cat_id === 888 ? '#ccebc5': 
   currentSourceRow.cat_id === 999 ? '#bebada':
  '#fccde5'}}"
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "1",
            }}
            groupAggregationMode="average"
            key="sale_share_in"
            label="입고비중(TAG)"
            placeholder="Enter value"
            position="center"
            size={115}
            summaryAggregationMode="none"
          />
          <Column
            id="1164d"
            alignment="center"
            backgroundColor="{{ currentSourceRow.cat_id === 777 ? '#ccebc5':
   currentSourceRow.cat_id === 888 ? '#ccebc5': 
   currentSourceRow.cat_id === 999 ? '#bebada':
  '#fccde5'}}"
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "1",
            }}
            groupAggregationMode="average"
            key="sale_share_out"
            label="판매비중(TAG)"
            placeholder="Enter value"
            position="center"
            size={119}
            summaryAggregationMode="none"
          />
          <Column
            id="efe46"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="inven_qty"
            label="재고수량"
            placeholder="Enter value"
            position="center"
            size={86}
            summaryAggregationMode="none"
          />
          <Column
            id="0328e"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "0",
            }}
            groupAggregationMode="sum"
            key="inven_tag"
            label="재고금액"
            placeholder="Enter value"
            position="center"
            size={88}
            summaryAggregationMode="none"
            valueOverride="{{ item/1000000 }}"
          />
          <Column
            id="64f70"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            hidden="true"
            key="ttl_index"
            label="Ttl index"
            placeholder="Enter value"
            position="center"
            size={100}
            summaryAggregationMode="none"
          />
          <Column
            id="9e2be"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            hidden="true"
            key="monthly_sale_qty"
            label="Monthly sale qty"
            placeholder="Enter value"
            position="center"
            size={100}
            summaryAggregationMode="none"
          />
          <Column
            id="31380"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            hidden="true"
            key="monthly_sale_tag"
            label="Monthly sale tag"
            placeholder="Enter value"
            position="center"
            size={100}
            summaryAggregationMode="none"
          />
          <Column
            id="7d78f"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            hidden="true"
            key="monthly_sale_amt"
            label="Monthly sale amt"
            placeholder="Enter value"
            position="center"
            size={100}
            summaryAggregationMode="none"
          />
          <Column
            id="f7575"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="last_week_sale_qty"
            label="전주판매량"
            placeholder="Enter value"
            position="center"
            size={82}
            summaryAggregationMode="none"
          />
          <Column
            id="a1204"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "0",
            }}
            groupAggregationMode="sum"
            key="last_week_sale_tag"
            label="전주판매금액(TAG)"
            placeholder="Enter value"
            position="center"
            size={130}
            summaryAggregationMode="none"
            valueOverride="{{ item/100000 }}"
          />
          <Column
            id="fb8e5"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "0",
            }}
            groupAggregationMode="sum"
            key="last_week_sale_amt"
            label="전주실판매금액"
            placeholder="Enter value"
            position="center"
            size={116}
            summaryAggregationMode="none"
            valueOverride="{{ item/1000000 }}"
          />
          <Column
            id="c1fef"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "1",
            }}
            groupAggregationMode="average"
            key="last_week_progress_rate"
            label="전주판매진도율"
            placeholder="Enter value"
            position="center"
            size={100}
            summaryAggregationMode="none"
          />
          <Column
            id="e369a"
            alignment="right"
            backgroundColor="{{ currentSourceRow.cat_id === 777 ? '#ccebc5':
   currentSourceRow.cat_id === 888 ? '#ccebc5': 
   currentSourceRow.cat_id === 999 ? '#bebada':
  '#ff9e93'}}"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="this_week_sale_qty"
            label="금주판매량"
            placeholder="Enter value"
            position="center"
            size={78}
            summaryAggregationMode="none"
          />
          <Column
            id="7ed08"
            alignment="right"
            backgroundColor="{{ currentSourceRow.cat_id === 777 ? '#ccebc5':
   currentSourceRow.cat_id === 888 ? '#ccebc5': 
   currentSourceRow.cat_id === 999 ? '#bebada':
  '#ff9e93'}}"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "0",
            }}
            groupAggregationMode="sum"
            key="this_week_sale_tag"
            label="금주판매금액(TAG)"
            placeholder="Enter value"
            position="center"
            size={131}
            summaryAggregationMode="none"
            valueOverride="{{ item/1000000 }}"
          />
          <Column
            id="22f34"
            alignment="right"
            backgroundColor="{{ currentSourceRow.cat_id === 777 ? '#ccebc5':
   currentSourceRow.cat_id === 888 ? '#ccebc5': 
   currentSourceRow.cat_id === 999 ? 'FFED6F':
  '#ff9e93'}}"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "0",
            }}
            groupAggregationMode="sum"
            key="this_week_sale_amt"
            label="금주실판매금액"
            placeholder="Enter value"
            position="center"
            size={102}
            summaryAggregationMode="none"
            valueOverride="{{ item/1000000 }}"
          />
          <Column
            id="e82ba"
            alignment="right"
            backgroundColor="{{ currentSourceRow.cat_id === 777 ? '#ccebc5':
   currentSourceRow.cat_id === 888 ? '#ccebc5': 
   currentSourceRow.cat_id === 999 ? '#bebada':
  '#ff9e93'}}"
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "1",
            }}
            groupAggregationMode="average"
            key="this_week_progress_rate"
            label="금주판매진도율"
            placeholder="Enter value"
            position="center"
            size={96}
            summaryAggregationMode="none"
          />
          <Column
            id="47abc"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "1",
            }}
            groupAggregationMode="average"
            label="진도율차"
            placeholder="Enter value"
            position="center"
            referenceId="진도율차"
            size={100}
            summaryAggregationMode="none"
            valueOverride="{{currentSourceRow.this_week_progress_rate -currentSourceRow.last_week_progress_rate}}"
          />
          <Column
            id="42514"
            alignment="left"
            format="tag"
            formatOptions={{ automaticColors: true }}
            groupAggregationMode="none"
            hidden="true"
            key="year_cd"
            label="Year cd"
            placeholder="Select option"
            position="center"
            size={100}
            summaryAggregationMode="none"
            valueOverride="{{ _.startCase(item) }}"
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
              pluginId="table4"
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
              pluginId="table4"
              type="widget"
              waitMs="0"
              waitType="debounce"
            />
          </ToolbarButton>
        </Table>
      </View>
    </Container>
  </Frame>
</App>
