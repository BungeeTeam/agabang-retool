<App>
  <Include src="./functions.rsx" />
  <GlobalWidgetProp id="brand_code" value="01" />
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
    <ModuleContainerWidget
      id="moduleContainer"
      backgroundColor="white"
      brand_code="01"
      isGlobalWidgetContainer={true}
      margin="0"
    >
      <Include src="./src/container1.rsx" />
      <Container
        id="container2"
        footerPadding="4px 12px"
        headerPadding="4px 12px"
        padding="0"
        showBody={true}
        showHeader={true}
      >
        <Header>
          <Text
            id="containerTitle1"
            margin="0"
            style={{
              ordered: [
                { fontSize: "h6Font" },
                { fontWeight: "h6Font" },
                { fontFamily: "h6Font" },
              ],
            }}
            value="{{moment(date_select.value).year()}}년 신상품 기준({{ season_select.selectedItem.year_cd }})"
            verticalAlign="center"
          />
        </Header>
        <View id="3df7a" viewKey="View 1">
          <Table
            id="table1"
            cellSelection="none"
            clearChangesetOnSave={true}
            data="{{ var_test.value.var_01 }}"
            defaultSelectedRow={{
              mode: "none",
              indexType: "display",
              index: 0,
            }}
            emptyMessage="No rows found"
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
          >
            <Column
              id="7a863"
              alignment="left"
              format="markdown"
              groupAggregationMode="none"
              key="cat_nm"
              label="카테고리"
              placeholder="Enter value"
              position="left"
              size={82}
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
              format="currency"
              formatOptions={{
                currency: "KRW",
                currencySign: "standard",
                notation: "standard",
                showSeparators: true,
                currencyDisplay: "symbol",
              }}
              groupAggregationMode="sum"
              key="tot_ord_tag"
              label="발주금액(TAG)"
              placeholder="Enter value"
              position="center"
              size={96}
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
              size={85}
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
              size={70}
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
              key="in_st"
              label="현재입고컬러수"
              placeholder="Enter value"
              position="center"
              size={93}
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
              key="out_st"
              label="현재출고컬러수"
              placeholder="Enter value"
              position="center"
              size={92}
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
              hidden="false"
              key="not_in_st"
              label="미입고컬러수"
              placeholder="Enter value"
              position="center"
              size={82}
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
              size={70}
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
              size={73}
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
              size={71}
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
              format="currency"
              formatOptions={{
                currency: "KRW",
                currencySign: "standard",
                notation: "standard",
                showSeparators: true,
                currencyDisplay: "symbol",
              }}
              groupAggregationMode="sum"
              key="tot_in_cost_amt"
              label="누적입고구입가(+)"
              placeholder="Enter value"
              position="center"
              size={112}
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
              format="currency"
              formatOptions={{
                currency: "KRW",
                currencySign: "standard",
                notation: "standard",
                showSeparators: true,
                currencyDisplay: "symbol",
              }}
              groupAggregationMode="sum"
              key="tot_in_tag"
              label="누적입고금액(TAG)"
              placeholder="Enter value"
              position="center"
              size={114}
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
              key="tot_sale_tag"
              label="누적판매금액(TAG)"
              placeholder="Enter value"
              position="center"
              size={115}
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
              size={87}
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
              size={92}
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
              size={63}
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
              size={94}
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
              size={69}
              summaryAggregationMode="none"
            />
            <Column
              id="0328e"
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
              key="inven_tag"
              label="재고금액"
              placeholder="Enter value"
              position="center"
              size={76}
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
              size={73}
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
              key="last_week_sale_amt"
              label="전주실판매금액"
              placeholder="Enter value"
              position="center"
              size={96}
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
              format="currency"
              formatOptions={{
                currency: "KRW",
                currencySign: "standard",
                notation: "standard",
                showSeparators: true,
                currencyDisplay: "symbol",
              }}
              groupAggregationMode="sum"
              key="this_week_sale_tag"
              label="금주판매금액(TAG)"
              placeholder="Enter value"
              position="center"
              size={115}
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
              key="this_week_sale_amt"
              label="금주실판매금액"
              placeholder="Enter value"
              position="center"
              size={93}
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
                              "{{ containerTitle1.value}} 무시즌 판매율({{ date_select.value }} 마감)",
                          },
                        ],
                      },
                    },
                  ],
                }}
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
        id="container3"
        footerPadding="4px 12px"
        headerPadding="4px 12px"
        padding="0"
        showBody={true}
        showHeader={true}
      >
        <Header>
          <Text
            id="containerTitle2"
            margin="0"
            style={{
              ordered: [
                { fontSize: "h6Font" },
                { fontWeight: "h6Font" },
                { fontFamily: "h6Font" },
              ],
            }}
            value="{{moment(date_select.value).year()-1}}년 신상품 기준({{ String.fromCharCode(season_select.selectedItem.year_cd.charCodeAt()-1) }})"
            verticalAlign="center"
          />
        </Header>
        <View id="3df7a" viewKey="View 1">
          <Table
            id="table2"
            cellSelection="none"
            clearChangesetOnSave={true}
            data="{{ var_test.value.var_02 }}"
            defaultSelectedRow={{
              mode: "none",
              indexType: "display",
              index: 0,
            }}
            emptyMessage="No rows found"
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
          >
            <Column
              id="7a863"
              alignment="left"
              format="markdown"
              groupAggregationMode="none"
              key="cat_nm"
              label="카테고리"
              placeholder="Enter value"
              position="left"
              size={82}
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
              format="currency"
              formatOptions={{
                currency: "KRW",
                currencySign: "standard",
                notation: "standard",
                showSeparators: true,
                currencyDisplay: "symbol",
              }}
              groupAggregationMode="sum"
              key="tot_ord_tag"
              label="발주금액(TAG)"
              placeholder="Enter value"
              position="center"
              size={96}
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
              size={85}
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
              size={70}
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
              key="in_st"
              label="현재입고컬러수"
              placeholder="Enter value"
              position="center"
              size={93}
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
              key="out_st"
              label="현재출고컬러수"
              placeholder="Enter value"
              position="center"
              size={92}
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
              hidden="false"
              key="not_in_st"
              label="미입고컬러수"
              placeholder="Enter value"
              position="center"
              size={82}
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
              size={70}
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
              size={73}
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
              size={71}
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
              format="currency"
              formatOptions={{
                currency: "KRW",
                currencySign: "standard",
                notation: "standard",
                showSeparators: true,
                currencyDisplay: "symbol",
              }}
              groupAggregationMode="sum"
              key="tot_in_cost_amt"
              label="누적입고구입가(+)"
              placeholder="Enter value"
              position="center"
              size={112}
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
              format="currency"
              formatOptions={{
                currency: "KRW",
                currencySign: "standard",
                notation: "standard",
                showSeparators: true,
                currencyDisplay: "symbol",
              }}
              groupAggregationMode="sum"
              key="tot_in_tag"
              label="누적입고금액(TAG)"
              placeholder="Enter value"
              position="center"
              size={114}
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
              key="tot_sale_tag"
              label="누적판매금액(TAG)"
              placeholder="Enter value"
              position="center"
              size={115}
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
              size={87}
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
              size={92}
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
              size={63}
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
              size={94}
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
              size={69}
              summaryAggregationMode="none"
            />
            <Column
              id="0328e"
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
              key="inven_tag"
              label="재고금액"
              placeholder="Enter value"
              position="center"
              size={76}
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
              size={73}
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
              key="last_week_sale_amt"
              label="전주실판매금액"
              placeholder="Enter value"
              position="center"
              size={96}
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
              format="currency"
              formatOptions={{
                currency: "KRW",
                currencySign: "standard",
                notation: "standard",
                showSeparators: true,
                currencyDisplay: "symbol",
              }}
              groupAggregationMode="sum"
              key="this_week_sale_tag"
              label="금주판매금액(TAG)"
              placeholder="Enter value"
              position="center"
              size={115}
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
              key="this_week_sale_amt"
              label="금주실판매금액"
              placeholder="Enter value"
              position="center"
              size={93}
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
              id="5e3ea"
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
                              "{{ containerTitle2.value}} 무시즌 판매율({{ date_select.value }} 마감)",
                          },
                          { includeHiddenColumns: false },
                        ],
                      },
                    },
                  ],
                }}
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
        id="container4"
        footerPadding="4px 12px"
        headerPadding="4px 12px"
        padding="0"
        showBody={true}
        showHeader={true}
      >
        <Header>
          <Text
            id="containerTitle3"
            margin="0"
            style={{
              ordered: [
                { fontSize: "h6Font" },
                { fontWeight: "h6Font" },
                { fontFamily: "h6Font" },
              ],
            }}
            value="{{moment(date_select.value).year()-2}}년 신상품 기준({{ String.fromCharCode(season_select.selectedItem.year_cd.charCodeAt()-2) }})"
            verticalAlign="center"
          />
        </Header>
        <View id="3df7a" viewKey="View 1">
          <Table
            id="table3"
            cellSelection="none"
            clearChangesetOnSave={true}
            data="{{ var_test.value.var_03 }}"
            defaultSelectedRow={{
              mode: "none",
              indexType: "display",
              index: 0,
            }}
            emptyMessage="No rows found"
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
          >
            <Column
              id="7a863"
              alignment="left"
              format="markdown"
              groupAggregationMode="none"
              key="cat_nm"
              label="카테고리"
              placeholder="Enter value"
              position="left"
              size={82}
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
              format="currency"
              formatOptions={{
                currency: "KRW",
                currencySign: "standard",
                notation: "standard",
                showSeparators: true,
                currencyDisplay: "symbol",
              }}
              groupAggregationMode="sum"
              key="tot_ord_tag"
              label="발주금액(TAG)"
              placeholder="Enter value"
              position="center"
              size={96}
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
              size={85}
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
              size={70}
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
              key="in_st"
              label="현재입고컬러수"
              placeholder="Enter value"
              position="center"
              size={93}
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
              key="out_st"
              label="현재출고컬러수"
              placeholder="Enter value"
              position="center"
              size={92}
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
              hidden="false"
              key="not_in_st"
              label="미입고컬러수"
              placeholder="Enter value"
              position="center"
              size={82}
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
              size={70}
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
              size={73}
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
              size={71}
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
              format="currency"
              formatOptions={{
                currency: "KRW",
                currencySign: "standard",
                notation: "standard",
                showSeparators: true,
                currencyDisplay: "symbol",
              }}
              groupAggregationMode="sum"
              key="tot_in_cost_amt"
              label="누적입고구입가(+)"
              placeholder="Enter value"
              position="center"
              size={112}
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
              format="currency"
              formatOptions={{
                currency: "KRW",
                currencySign: "standard",
                notation: "standard",
                showSeparators: true,
                currencyDisplay: "symbol",
              }}
              groupAggregationMode="sum"
              key="tot_in_tag"
              label="누적입고금액(TAG)"
              placeholder="Enter value"
              position="center"
              size={114}
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
              key="tot_sale_tag"
              label="누적판매금액(TAG)"
              placeholder="Enter value"
              position="center"
              size={115}
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
              size={87}
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
              size={92}
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
              size={63}
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
              size={94}
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
              size={69}
              summaryAggregationMode="none"
            />
            <Column
              id="0328e"
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
              key="inven_tag"
              label="재고금액"
              placeholder="Enter value"
              position="center"
              size={76}
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
              size={73}
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
              key="last_week_sale_amt"
              label="전주실판매금액"
              placeholder="Enter value"
              position="center"
              size={96}
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
              format="currency"
              formatOptions={{
                currency: "KRW",
                currencySign: "standard",
                notation: "standard",
                showSeparators: true,
                currencyDisplay: "symbol",
              }}
              groupAggregationMode="sum"
              key="this_week_sale_tag"
              label="금주판매금액(TAG)"
              placeholder="Enter value"
              position="center"
              size={115}
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
              key="this_week_sale_amt"
              label="금주실판매금액"
              placeholder="Enter value"
              position="center"
              size={93}
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
                              "{{ containerTitle3.value}} 무시즌 판매율({{ date_select.value }} 마감)",
                          },
                        ],
                      },
                    },
                  ],
                }}
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
        id="container5"
        footerPadding="4px 12px"
        headerPadding="4px 12px"
        padding="0"
        showBody={true}
        showHeader={true}
      >
        <Header>
          <Text
            id="containerTitle4"
            margin="0"
            style={{
              ordered: [
                { fontSize: "h6Font" },
                { fontWeight: "h6Font" },
                { fontFamily: "h6Font" },
              ],
            }}
            value="{{moment(date_select.value).year()-3}}년 신상품 기준({{ String.fromCharCode(season_select.selectedItem.year_cd.charCodeAt()-3) }})"
            verticalAlign="center"
          />
        </Header>
        <View id="3df7a" viewKey="View 1">
          <Table
            id="table4"
            cellSelection="none"
            clearChangesetOnSave={true}
            data="{{ var_test.value.var_04 }}"
            defaultSelectedRow={{
              mode: "none",
              indexType: "display",
              index: 0,
            }}
            emptyMessage="No rows found"
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
          >
            <Column
              id="7a863"
              alignment="left"
              format="markdown"
              groupAggregationMode="none"
              key="cat_nm"
              label="카테고리"
              placeholder="Enter value"
              position="left"
              size={82}
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
              format="currency"
              formatOptions={{
                currency: "KRW",
                currencySign: "standard",
                notation: "standard",
                showSeparators: true,
                currencyDisplay: "symbol",
              }}
              groupAggregationMode="sum"
              key="tot_ord_tag"
              label="발주금액(TAG)"
              placeholder="Enter value"
              position="center"
              size={96}
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
              size={85}
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
              size={70}
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
              key="in_st"
              label="현재입고컬러수"
              placeholder="Enter value"
              position="center"
              size={93}
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
              key="out_st"
              label="현재출고컬러수"
              placeholder="Enter value"
              position="center"
              size={92}
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
              hidden="false"
              key="not_in_st"
              label="미입고컬러수"
              placeholder="Enter value"
              position="center"
              size={82}
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
              size={70}
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
              size={73}
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
              size={71}
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
              format="currency"
              formatOptions={{
                currency: "KRW",
                currencySign: "standard",
                notation: "standard",
                showSeparators: true,
                currencyDisplay: "symbol",
              }}
              groupAggregationMode="sum"
              key="tot_in_cost_amt"
              label="누적입고구입가(+)"
              placeholder="Enter value"
              position="center"
              size={112}
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
              format="currency"
              formatOptions={{
                currency: "KRW",
                currencySign: "standard",
                notation: "standard",
                showSeparators: true,
                currencyDisplay: "symbol",
              }}
              groupAggregationMode="sum"
              key="tot_in_tag"
              label="누적입고금액(TAG)"
              placeholder="Enter value"
              position="center"
              size={114}
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
              key="tot_sale_tag"
              label="누적판매금액(TAG)"
              placeholder="Enter value"
              position="center"
              size={115}
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
              size={87}
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
              size={92}
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
              size={63}
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
              size={94}
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
              size={69}
              summaryAggregationMode="none"
            />
            <Column
              id="0328e"
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
              key="inven_tag"
              label="재고금액"
              placeholder="Enter value"
              position="center"
              size={76}
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
              size={73}
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
              key="last_week_sale_amt"
              label="전주실판매금액"
              placeholder="Enter value"
              position="center"
              size={96}
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
              format="currency"
              formatOptions={{
                currency: "KRW",
                currencySign: "standard",
                notation: "standard",
                showSeparators: true,
                currencyDisplay: "symbol",
              }}
              groupAggregationMode="sum"
              key="this_week_sale_tag"
              label="금주판매금액(TAG)"
              placeholder="Enter value"
              position="center"
              size={115}
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
              key="this_week_sale_amt"
              label="금주실판매금액"
              placeholder="Enter value"
              position="center"
              size={93}
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
                              "{{ containerTitle4.value}} 무시즌 판매율({{ date_select.value }} 마감)",
                          },
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
          </Table>
        </View>
      </Container>
    </ModuleContainerWidget>
  </Frame>
</App>
