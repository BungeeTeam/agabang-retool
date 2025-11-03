<App>
  <Include src="./functions.rsx" />
  <AppStyles id="$appStyles" css={include("./lib/$appStyles.css", "string")} />
  <DocumentTitle id="$customDocumentTitle" value="시즌 판매율 | ET" />
  <UrlFragments
    id="$urlFragments"
    value={{
      ordered: [
        { deadline_date: "{{ date_select.value }}" },
        { year_sesn_cd: "{{ season_select.value }}" },
        { hide_columns: "{{ inventory_columns_toggle.value }}" },
        {
          comparison_basis: "{{ comparison_basis_select.selectedItem.value }}",
        },
      ],
    }}
  />
  <Include src="./header.rsx" />
  <Include src="./src/drawerFrame_item_detail.rsx" />
  <Include src="./src/drawerFrame_item_detail_new.rsx" />
  <Include src="./src/modal_item_list.rsx" />
  <Include src="./src/shop_sales.rsx" />
  <Frame
    id="$main"
    enableFullBleed={false}
    isHiddenOnDesktop={false}
    isHiddenOnMobile={false}
    padding="0"
    sticky={null}
    type="main"
  >
    <Include src="./src/container10.rsx" />
    <Container
      id="container11"
      _gap="0px"
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      overflowType="hidden"
      padding="0"
      showBody={true}
      showHeader={true}
    >
      <Header>
        <Text
          id="text25"
          margin="0"
          value="##### {{ season_select.selectedItem.year_sesn_nm_kor }} 소진율"
          verticalAlign="center"
        />
        <Text
          id="text27"
          margin="0"
          style={{
            ordered: [
              { fontSize: "10px" },
              { fontWeight: "500" },
              { fontFamily: "pretendard variable" },
            ],
          }}
          value="{{ get_same_weekday.data['cur'] }}"
          verticalAlign="center"
        />
        <Text
          id="text26"
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
      <View id="7b13c" viewKey="View 1">
        <Table
          id="cur_sales_table7"
          cellSelection="none"
          clearChangesetOnSave={true}
          data="{{ salesByLargeCat.value.filter(i=>i.year_cd === season_select.selectedItem.year_cd) }}"
          defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
          dynamicColumnProperties={{ formatByIndex: "auto" }}
          emptyMessage="No rows found"
          enableExpandableRows={true}
          enableSaveActions={true}
          heightType="auto"
          hidden=""
          margin="0"
          primaryKeyColumnId="cb4b0"
          rowBackgroundColor="{{ currentSourceRow.it === '총계' ? '#bebada':
   currentSourceRow.it === '소계' && currentSourceRow.apparel_group != '시즌의류' ? '#ccebc5': 
  '#FFFFF'}}


"
          rowHeight="small"
          rowSelection="none"
          showColumnBorders={true}
          showHeader={true}
          style={{}}
        >
          <Include src="./src/cur_sales_table7ExpandedRow.rsx" />
          <Column
            id="cb4b0"
            alignment="left"
            editable="false"
            format="markdown"
            groupAggregationMode="none"
            key="large_cat"
            label="구분"
            placeholder="Enter value"
            position="left"
            referenceId="large_cat"
            size={88.015625}
            summaryAggregationMode="none"
            valueOverride="**{{ item }}**"
          />
          <Column
            id="b4df6"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="ord_qty"
            label="발주수량"
            placeholder="Enter value"
            position="center"
            referenceId="ord_qty"
            size={90.234375}
            summaryAggregationMode="none"
          />
          <Column
            id="4b73f"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "0",
            }}
            groupAggregationMode="sum"
            key="ord_tag_amt"
            label="발주금액(TAG)"
            placeholder="Enter value"
            position="center"
            referenceId="ord_tag_amt"
            size={81.796875}
            summaryAggregationMode="none"
            valueOverride="{{ item/1000000 }}"
          />
          <Column
            id="8f0d2"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "0",
            }}
            groupAggregationMode="average"
            label="입고율(TAG)"
            placeholder="Enter value"
            position="center"
            referenceId="in_rate"
            size={71}
            summaryAggregationMode="none"
            valueOverride="{{ currentSourceRow.tot_in_tag/currentSourceRow.ord_tag_amt }}"
          />
          <Column
            id="762f1"
            alignment="right"
            backgroundColor="{{ currentSourceRow.it === '총계' ? '#bebada':
   currentSourceRow.it === '소계' && currentSourceRow.apparel_group != '시즌의류' ? '#ccebc5': 
  '#efefef'}}"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="st_count"
            label="총 컬러수"
            placeholder="Enter value"
            position="center"
            size={58.609375}
            summaryAggregationMode="none"
          />
          <Column
            id="9ee60"
            alignment="right"
            backgroundColor="{{ currentSourceRow.it === '총계' ? '#bebada':
   currentSourceRow.it === '소계' && currentSourceRow.apparel_group != '시즌의류' ? '#ccebc5': 
  '#efefef'}}"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            hidden="{{ inventory_columns_toggle.value }}"
            key="in_st_count"
            label="입고 컬러수"
            placeholder="Enter value"
            position="center"
            size={66.796875}
            summaryAggregationMode="none"
          />
          <Column
            id="82fd2"
            alignment="right"
            backgroundColor="{{ currentSourceRow.it === '총계' ? '#bebada':
   currentSourceRow.it === '소계' && currentSourceRow.apparel_group != '시즌의류' ? '#ccebc5': 
  '#efefef'}}"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            hidden="{{ inventory_columns_toggle.value }}"
            label="미입고 컬러수"
            placeholder="Enter value"
            position="center"
            referenceId="not_in_st_count"
            size={63}
            summaryAggregationMode="none"
            valueOverride="{{ currentSourceRow.st_count - currentSourceRow.in_st_count }}"
          />
          <Column
            id="525a0"
            alignment="right"
            backgroundColor="{{ currentSourceRow.it === '총계' ? '#bebada':
   currentSourceRow.it === '소계' && currentSourceRow.apparel_group != '시즌의류' ? '#ccebc5': 
  '#efefef'}}"
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "0",
            }}
            groupAggregationMode="average"
            hidden="{{ inventory_columns_toggle.value }}"
            label="기획대비 컬러 입고율"
            placeholder="Enter value"
            position="center"
            referenceId="in_st_rate"
            size={75}
            summaryAggregationMode="none"
            valueOverride="{{currentSourceRow.in_st_count/currentSourceRow.st_count }}"
          />
          <Column
            id="32bf8"
            alignment="right"
            backgroundColor="{{ currentSourceRow.it === '총계' ? '#bebada':
   currentSourceRow.it === '소계' && currentSourceRow.apparel_group != '시즌의류' ? '#ccebc5': 
  '#efefef'}}"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            hidden="{{ inventory_columns_toggle.value }}"
            key="out_st_count"
            label="출고 컬러수"
            placeholder="Enter value"
            position="center"
            size={62}
            summaryAggregationMode="none"
          />
          <Column
            id="1b10e"
            alignment="right"
            backgroundColor="{{ currentSourceRow.it === '총계' ? '#bebada':
   currentSourceRow.it === '소계' && currentSourceRow.apparel_group != '시즌의류' ? '#ccebc5': 
  '#efefef'}}"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            hidden="{{ inventory_columns_toggle.value }}"
            label="미출고 컬러수"
            placeholder="Enter value"
            position="center"
            referenceId="not_out_st_count"
            size={65}
            summaryAggregationMode="none"
            valueOverride="{{ currentSourceRow.in_st_count - currentSourceRow.out_st_count }}"
          />
          <Column
            id="b52bd"
            alignment="right"
            backgroundColor="{{ currentSourceRow.it === '총계' ? '#bebada':
   currentSourceRow.it === '소계' && currentSourceRow.apparel_group != '시즌의류' ? '#ccebc5': 
  '#efefef'}}"
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "0",
            }}
            groupAggregationMode="average"
            hidden="{{ inventory_columns_toggle.value }}"
            label="입고대비 컬러 출고율"
            placeholder="Enter value"
            position="center"
            referenceId="out_st_rate"
            size={75}
            summaryAggregationMode="none"
            valueOverride="{{ currentSourceRow.out_st_count/currentSourceRow.in_st_count }}"
          />
          <Column
            id="0d659"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="tot_in_qty"
            label="총 입고수량"
            placeholder="Enter value"
            position="center"
            size={99}
            summaryAggregationMode="none"
          />
          <Column
            id="58926"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="tot_sale_qty"
            label="총 판매수량"
            placeholder="Enter value"
            position="center"
            size={100}
            summaryAggregationMode="none"
          />
          <Column
            id="961b1"
            alignment="right"
            backgroundColor="{{ currentSourceRow.it === '총계' ? '#FFED6F' : ''}}"
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "1",
              padDecimal: true,
            }}
            groupAggregationMode="average"
            label="판매율(수량)"
            placeholder="Enter value"
            position="center"
            referenceId="tot_sale_rate_qty"
            size={73}
            summaryAggregationMode="none"
            valueOverride="{{ currentSourceRow.tot_sale_qty/currentSourceRow.tot_in_qty }}"
          />
          <Column
            id="442c8"
            alignment="right"
            backgroundColor="{{ currentSourceRow.it === '총계' ? '#bebada':
   currentSourceRow.it === '소계' && currentSourceRow.apparel_group != '시즌의류' ? '#ccebc5': 
  '#efefef'}}"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "0",
            }}
            groupAggregationMode="sum"
            key="tot_in_cost"
            label="누적 입고구입가(+)"
            placeholder="Enter value"
            position="center"
            size={88.765625}
            summaryAggregationMode="none"
            valueOverride="{{ item/1000000 }}"
          />
          <Column
            id="fb5c1"
            alignment="right"
            backgroundColor="{{ currentSourceRow.it === '총계' ? '#bebada':
   currentSourceRow.it === '소계' && currentSourceRow.apparel_group != '시즌의류' ? '#ccebc5': 
  '#efefef'}}"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "2",
              padDecimal: true,
            }}
            groupAggregationMode="sum"
            label="배수"
            placeholder="Enter value"
            position="center"
            referenceId="markup"
            size={45}
            summaryAggregationMode="none"
            valueOverride="{{ currentSourceRow.tot_in_tag/currentSourceRow.tot_in_cost }}"
          />
          <Column
            id="a0ac0"
            alignment="right"
            backgroundColor="{{ currentSourceRow.it === '총계' ? '#bebada':
   currentSourceRow.it === '소계' && currentSourceRow.apparel_group != '시즌의류' ? '#ccebc5': 
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
            label="누적 입고금액(TAG)"
            placeholder="Enter value"
            position="center"
            size={97}
            summaryAggregationMode="none"
            valueOverride="{{ item/1000000 }}"
          />
          <Column
            id="b0425"
            alignment="right"
            backgroundColor="{{ currentSourceRow.it === '총계' ? '#bebada':
   currentSourceRow.it === '소계' && currentSourceRow.apparel_group != '시즌의류' ? '#ccebc5': 
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
            label="누적 판매금액(TAG)"
            placeholder="Enter value"
            position="center"
            size={94}
            summaryAggregationMode="none"
            valueOverride="{{ item/1000000 }}"
          />
          <Column
            id="7099c"
            alignment="right"
            backgroundColor="{{ currentSourceRow.it === '총계' ? '#FFED6F':
   currentSourceRow.it === '소계' && currentSourceRow.apparel_group != '시즌의류' ? '#ccebc5': 
  '#efefef'}}"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "0",
            }}
            groupAggregationMode="sum"
            key="tot_sale_amt"
            label="누적 실판매 금액"
            placeholder="Enter value"
            position="center"
            size={92}
            summaryAggregationMode="none"
            valueOverride="{{ item/1000000 }}"
          />
          <Column
            id="bf4bc"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{
              showSeparators: false,
              notation: "standard",
              decimalPlaces: "1",
              padDecimal: true,
            }}
            groupAggregationMode="average"
            label="누적 판매율(TAG)"
            placeholder="Enter value"
            position="center"
            referenceId="tot_sale_rate_tag"
            size={82}
            summaryAggregationMode="none"
            valueOverride="{{ currentSourceRow.tot_sale_tag/currentSourceRow.tot_in_tag }}"
          />
          <Column
            id="02ea2"
            alignment="right"
            backgroundColor="{{ currentSourceRow.it === '총계' ? '#FFED6F' : ''}}"
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "1",
              padDecimal: true,
            }}
            groupAggregationMode="average"
            label="누적판매율(실매출)"
            placeholder="Enter value"
            position="center"
            referenceId="tot_sale_rate_amt"
            size={82}
            summaryAggregationMode="none"
            valueOverride="{{ currentSourceRow.tot_sale_amt/currentSourceRow.tot_in_tag }}"
          />
          <Column
            id="e46c2"
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
            label="할인율"
            placeholder="Enter value"
            position="center"
            referenceId="discount_rate"
            size={63}
            summaryAggregationMode="none"
            valueOverride="{{(currentSourceRow.tot_sale_tag-currentSourceRow.tot_sale_amt)/currentSourceRow.tot_sale_tag }}"
          />
          <Column
            id="9fa86"
            alignment="right"
            backgroundColor="{{ currentSourceRow.it === '총계' ? '#bebada':
   currentSourceRow.it === '소계' && currentSourceRow.apparel_group != '시즌의류' ? '#ccebc5': 
  '#fccde5'}}"
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "1",
              padDecimal: true,
            }}
            groupAggregationMode="average"
            key="in_ratio"
            label="입고비중(TAG)"
            placeholder="Enter value"
            position="center"
            size={73.09375}
            summaryAggregationMode="none"
          />
          <Column
            id="d4897"
            alignment="right"
            backgroundColor="{{ currentSourceRow.it === '총계' ? '#bebada':
   currentSourceRow.it === '소계' && currentSourceRow.apparel_group != '시즌의류' ? '#ccebc5': 
  '#fccde5'}}"
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "1",
              padDecimal: true,
            }}
            groupAggregationMode="average"
            key="sale_ratio"
            label="판매비중(TAG)"
            placeholder="Enter value"
            position="center"
            size={75.234375}
            summaryAggregationMode="none"
          />
          <Column
            id="40aca"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            label="재고수량"
            placeholder="Enter value"
            position="center"
            referenceId="inven_qty"
            size={109}
            summaryAggregationMode="none"
            valueOverride="{{ currentSourceRow.tot_in_qty-currentSourceRow.tot_sale_qty }}"
          />
          <Column
            id="119f0"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "0",
            }}
            groupAggregationMode="sum"
            label="재고금액(TAG)"
            placeholder="Enter value"
            position="center"
            referenceId="inven_tag"
            size={90}
            summaryAggregationMode="none"
            valueOverride="{{ (currentSourceRow.tot_in_tag-currentSourceRow.tot_sale_tag)/1000000 }}"
          />
          <Column
            id="2280f"
            alignment="right"
            backgroundColor="{{ currentSourceRow.it === '총계' ? '#bebada':
   currentSourceRow.it === '소계' && currentSourceRow.apparel_group != '시즌의류' ? '#ccebc5': 
  '#afd7f2'}}"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="month_sale_qty"
            label="월간 판매수량"
            placeholder="Enter value"
            position="center"
            size={69.421875}
            summaryAggregationMode="none"
          />
          <Column
            id="0dd33"
            alignment="right"
            backgroundColor="{{ currentSourceRow.it === '총계' ? '#bebada':
   currentSourceRow.it === '소계' && currentSourceRow.apparel_group != '시즌의류' ? '#ccebc5': 
  '#afd7f2'}}"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "0",
            }}
            groupAggregationMode="sum"
            key="month_sale_tag"
            label="월간 판매금액(TAG)"
            placeholder="Enter value"
            position="center"
            size={87.515625}
            summaryAggregationMode="none"
            valueOverride="{{ item/1000000 }}"
          />
          <Column
            id="422c2"
            alignment="right"
            backgroundColor="{{ currentSourceRow.it === '총계' ?'#FFED6F':
   currentSourceRow.it === '소계' && currentSourceRow.apparel_group != '시즌의류' ? '#ccebc5': 
  '#afd7f2'}}"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "0",
            }}
            groupAggregationMode="sum"
            key="month_sale_amt"
            label="월간 실판매금액"
            placeholder="Enter value"
            position="center"
            size={78.625}
            summaryAggregationMode="none"
            valueOverride="{{ item/1000000 }}"
          />
          <Column
            id="c87f2"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="p_week_sale_qty"
            label="전주 판매수량"
            placeholder="Enter value"
            position="center"
            size={77.015625}
            summaryAggregationMode="none"
          />
          <Column
            id="87acb"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "0",
            }}
            groupAggregationMode="sum"
            key="p_week_sale_tag"
            label="전주 판매금액(TAG)"
            placeholder="Enter value"
            position="center"
            size={106.09375}
            summaryAggregationMode="none"
            valueOverride="{{ item/1000000 }}"
          />
          <Column
            id="bed0e"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "0",
            }}
            groupAggregationMode="sum"
            key="p_week_sale_amt"
            label="전주 실판매금액"
            placeholder="Enter value"
            position="center"
            referenceId="w"
            size={85.21875}
            summaryAggregationMode="none"
            valueOverride="{{ item/1000000 }}"
          />
          <Column
            id="a539b"
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
            label="전주 판매 진도율"
            placeholder="Enter value"
            position="center"
            referenceId="p_week_sale_rate"
            size={79.265625}
            summaryAggregationMode="none"
            valueOverride="{{ currentSourceRow.p_week_sale_tag/currentSourceRow.tot_in_tag }}"
          />
          <Column
            id="a37da"
            alignment="right"
            backgroundColor="{{ currentSourceRow.it === '총계' ? '#bebada':
   currentSourceRow.it === '소계' && currentSourceRow.apparel_group != '시즌의류' ? '#ccebc5': 
  '#ff9e93'}}"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="week_sale_qty"
            label="금주 판매수량"
            placeholder="Enter value"
            position="center"
            size={74.265625}
            summaryAggregationMode="none"
          />
          <Column
            id="7a3e0"
            alignment="right"
            backgroundColor="{{ currentSourceRow.it === '총계' ? '#bebada':
   currentSourceRow.it === '소계' && currentSourceRow.apparel_group != '시즌의류' ? '#ccebc5': 
  '#ff9e93'}}"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "0",
            }}
            groupAggregationMode="sum"
            key="week_sale_tag"
            label="금주 판매금액(TAG)"
            placeholder="Enter value"
            position="center"
            size={92.46875}
            summaryAggregationMode="none"
            valueOverride="{{ item/1000000 }}"
          />
          <Column
            id="5c707"
            alignment="right"
            backgroundColor="{{ currentSourceRow.it === '총계' ? '#FFED6F':
   currentSourceRow.it === '소계' && currentSourceRow.apparel_group != '시즌의류' ? '#ccebc5': 
  '#ff9e93'}}"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "0",
            }}
            groupAggregationMode="sum"
            key="week_sale_amt"
            label="금주 실판매금액"
            placeholder="Enter value"
            position="center"
            size={86.46875}
            summaryAggregationMode="none"
            valueOverride="{{ item/1000000 }}"
          />
          <Column
            id="79091"
            alignment="right"
            backgroundColor="{{ currentSourceRow.it === '총계' ? '#bebada':
   currentSourceRow.it === '소계' && currentSourceRow.apparel_group != '시즌의류' ? '#ccebc5': 
  '#ff9e93'}}"
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "1",
              padDecimal: false,
            }}
            groupAggregationMode="average"
            label="금주 판매 진도율"
            placeholder="Enter value"
            position="center"
            referenceId="week_sale_rate"
            size={84}
            summaryAggregationMode="none"
            valueOverride="{{ currentSourceRow.week_sale_tag/currentSourceRow.tot_in_tag }}"
          />
          <Column
            id="9a2a7"
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
            label="진도율 차"
            placeholder="Enter value"
            position="center"
            referenceId="diff_sale_rate"
            size={65}
            summaryAggregationMode="none"
            valueOverride="{{ currentSourceRow.week_sale_tag/currentSourceRow.tot_in_tag-currentSourceRow.p_week_sale_tag/currentSourceRow.tot_in_tag }}"
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
                            "{{ text25.value.slice(6) }}_{{ get_same_weekday_new.data.cur_date }}",
                        },
                        { includeHiddenColumns: false },
                      ],
                    },
                  },
                ],
              }}
              pluginId="cur_sales_table7"
              type="widget"
              waitMs="0"
              waitType="debounce"
            />
          </ToolbarButton>
        </Table>
      </View>
    </Container>
    <Container
      id="container12"
      _gap="0px"
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      overflowType="hidden"
      padding="0"
      showBody={true}
      showHeader={true}
    >
      <Header>
        <Text
          id="text30"
          margin="0"
          value="##### {{ season_select.selectedItem.prev_year_sesn_nm_kor }} 소진율"
          verticalAlign="center"
        />
        <Text
          id="text32"
          margin="0"
          style={{
            ordered: [
              { fontSize: "10px" },
              { fontWeight: "500" },
              { fontFamily: "pretendard variable" },
            ],
          }}
          value="{{ get_same_weekday.data['prev'] }}"
          verticalAlign="center"
        />
        <Text
          id="text31"
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
      <View id="7b13c" viewKey="View 1">
        <Table
          id="cur_sales_table8"
          cellSelection="none"
          clearChangesetOnSave={true}
          data="{{ salesByLargeCat.value.filter(i=>i.year_cd === season_select.selectedItem.prev_year_cd) }}"
          defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
          dynamicColumnProperties={{ formatByIndex: "auto" }}
          emptyMessage="No rows found"
          enableExpandableRows={true}
          enableSaveActions={true}
          heightType="auto"
          hidden=""
          margin="0"
          primaryKeyColumnId="cb4b0"
          rowBackgroundColor="{{ currentSourceRow.it === '총계' ? '#bebada':
   currentSourceRow.it === '소계' && currentSourceRow.apparel_group != '시즌의류' ? '#ccebc5': 
  '#FFFFF'}}


"
          rowHeight="small"
          rowSelection="none"
          showColumnBorders={true}
          showHeader={true}
          style={{}}
        >
          <Include src="./src/cur_sales_table8ExpandedRow.rsx" />
          <Column
            id="cb4b0"
            alignment="left"
            editable="false"
            format="markdown"
            groupAggregationMode="none"
            key="large_cat"
            label="구분"
            placeholder="Enter value"
            position="left"
            referenceId="large_cat"
            size={88.015625}
            summaryAggregationMode="none"
            valueOverride="**{{ item }}**"
          />
          <Column
            id="b4df6"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="ord_qty"
            label="발주수량"
            placeholder="Enter value"
            position="center"
            referenceId="ord_qty"
            size={90.234375}
            summaryAggregationMode="none"
          />
          <Column
            id="4b73f"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "0",
            }}
            groupAggregationMode="sum"
            key="ord_tag_amt"
            label="발주금액(TAG)"
            placeholder="Enter value"
            position="center"
            referenceId="ord_tag_amt"
            size={81.796875}
            summaryAggregationMode="none"
            valueOverride="{{ item/1000000 }}"
          />
          <Column
            id="8f0d2"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "0",
            }}
            groupAggregationMode="average"
            label="입고율(TAG)"
            placeholder="Enter value"
            position="center"
            referenceId="in_rate"
            size={71}
            summaryAggregationMode="none"
            valueOverride="{{ currentSourceRow.tot_in_tag/currentSourceRow.ord_tag_amt }}"
          />
          <Column
            id="762f1"
            alignment="right"
            backgroundColor="{{ currentSourceRow.it === '총계' ? '#bebada':
   currentSourceRow.it === '소계' && currentSourceRow.apparel_group != '시즌의류' ? '#ccebc5': 
  '#efefef'}}"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="st_count"
            label="총 컬러수"
            placeholder="Enter value"
            position="center"
            size={58.609375}
            summaryAggregationMode="none"
          />
          <Column
            id="9ee60"
            alignment="right"
            backgroundColor="{{ currentSourceRow.it === '총계' ? '#bebada':
   currentSourceRow.it === '소계' && currentSourceRow.apparel_group != '시즌의류' ? '#ccebc5': 
  '#efefef'}}"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            hidden="{{ inventory_columns_toggle.value }}"
            key="in_st_count"
            label="입고 컬러수"
            placeholder="Enter value"
            position="center"
            size={66.796875}
            summaryAggregationMode="none"
          />
          <Column
            id="82fd2"
            alignment="right"
            backgroundColor="{{ currentSourceRow.it === '총계' ? '#bebada':
   currentSourceRow.it === '소계' && currentSourceRow.apparel_group != '시즌의류' ? '#ccebc5': 
  '#efefef'}}"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            hidden="{{ inventory_columns_toggle.value }}"
            label="미입고 컬러수"
            placeholder="Enter value"
            position="center"
            referenceId="not_in_st_count"
            size={63}
            summaryAggregationMode="none"
            valueOverride="{{ currentSourceRow.st_count - currentSourceRow.in_st_count }}"
          />
          <Column
            id="525a0"
            alignment="right"
            backgroundColor="{{ currentSourceRow.it === '총계' ? '#bebada':
   currentSourceRow.it === '소계' && currentSourceRow.apparel_group != '시즌의류' ? '#ccebc5': 
  '#efefef'}}"
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "0",
            }}
            groupAggregationMode="average"
            hidden="{{ inventory_columns_toggle.value }}"
            label="기획대비 컬러 입고율"
            placeholder="Enter value"
            position="center"
            referenceId="in_st_rate"
            size={75}
            summaryAggregationMode="none"
            valueOverride="{{currentSourceRow.in_st_count/currentSourceRow.st_count }}"
          />
          <Column
            id="32bf8"
            alignment="right"
            backgroundColor="{{ currentSourceRow.it === '총계' ? '#bebada':
   currentSourceRow.it === '소계' && currentSourceRow.apparel_group != '시즌의류' ? '#ccebc5': 
  '#efefef'}}"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            hidden="{{ inventory_columns_toggle.value }}"
            key="out_st_count"
            label="출고 컬러수"
            placeholder="Enter value"
            position="center"
            size={62}
            summaryAggregationMode="none"
          />
          <Column
            id="1b10e"
            alignment="right"
            backgroundColor="{{ currentSourceRow.it === '총계' ? '#bebada':
   currentSourceRow.it === '소계' && currentSourceRow.apparel_group != '시즌의류' ? '#ccebc5': 
  '#efefef'}}"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            hidden="{{ inventory_columns_toggle.value }}"
            label="미출고 컬러수"
            placeholder="Enter value"
            position="center"
            referenceId="not_out_st_count"
            size={65}
            summaryAggregationMode="none"
            valueOverride="{{ currentSourceRow.in_st_count - currentSourceRow.out_st_count }}"
          />
          <Column
            id="b52bd"
            alignment="right"
            backgroundColor="{{ currentSourceRow.it === '총계' ? '#bebada':
   currentSourceRow.it === '소계' && currentSourceRow.apparel_group != '시즌의류' ? '#ccebc5': 
  '#efefef'}}"
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "0",
            }}
            groupAggregationMode="average"
            hidden="{{ inventory_columns_toggle.value }}"
            label="입고대비 컬러 출고율"
            placeholder="Enter value"
            position="center"
            referenceId="out_st_rate"
            size={75}
            summaryAggregationMode="none"
            valueOverride="{{ currentSourceRow.out_st_count/currentSourceRow.in_st_count }}"
          />
          <Column
            id="0d659"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="tot_in_qty"
            label="총 입고수량"
            placeholder="Enter value"
            position="center"
            size={99}
            summaryAggregationMode="none"
          />
          <Column
            id="58926"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="tot_sale_qty"
            label="총 판매수량"
            placeholder="Enter value"
            position="center"
            size={100}
            summaryAggregationMode="none"
          />
          <Column
            id="961b1"
            alignment="right"
            backgroundColor="{{ currentSourceRow.it === '총계' ? '#FFED6F' : ''}}"
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "1",
              padDecimal: true,
            }}
            groupAggregationMode="average"
            label="판매율(수량)"
            placeholder="Enter value"
            position="center"
            referenceId="tot_sale_rate_qty"
            size={73}
            summaryAggregationMode="none"
            valueOverride="{{ currentSourceRow.tot_sale_qty/currentSourceRow.tot_in_qty }}"
          />
          <Column
            id="442c8"
            alignment="right"
            backgroundColor="{{ currentSourceRow.it === '총계' ? '#bebada':
   currentSourceRow.it === '소계' && currentSourceRow.apparel_group != '시즌의류' ? '#ccebc5': 
  '#efefef'}}"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "0",
            }}
            groupAggregationMode="sum"
            key="tot_in_cost"
            label="누적 입고구입가(+)"
            placeholder="Enter value"
            position="center"
            size={88.765625}
            summaryAggregationMode="none"
            valueOverride="{{ item/1000000 }}"
          />
          <Column
            id="fb5c1"
            alignment="right"
            backgroundColor="{{ currentSourceRow.it === '총계' ? '#bebada':
   currentSourceRow.it === '소계' && currentSourceRow.apparel_group != '시즌의류' ? '#ccebc5': 
  '#efefef'}}"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "2",
              padDecimal: true,
            }}
            groupAggregationMode="sum"
            label="배수"
            placeholder="Enter value"
            position="center"
            referenceId="markup"
            size={45}
            summaryAggregationMode="none"
            valueOverride="{{ currentSourceRow.tot_in_tag/currentSourceRow.tot_in_cost }}"
          />
          <Column
            id="a0ac0"
            alignment="right"
            backgroundColor="{{ currentSourceRow.it === '총계' ? '#bebada':
   currentSourceRow.it === '소계' && currentSourceRow.apparel_group != '시즌의류' ? '#ccebc5': 
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
            label="누적 입고금액(TAG)"
            placeholder="Enter value"
            position="center"
            size={97}
            summaryAggregationMode="none"
            valueOverride="{{ item/1000000 }}"
          />
          <Column
            id="b0425"
            alignment="right"
            backgroundColor="{{ currentSourceRow.it === '총계' ? '#bebada':
   currentSourceRow.it === '소계' && currentSourceRow.apparel_group != '시즌의류' ? '#ccebc5': 
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
            label="누적 판매금액(TAG)"
            placeholder="Enter value"
            position="center"
            size={94}
            summaryAggregationMode="none"
            valueOverride="{{ item/1000000 }}"
          />
          <Column
            id="7099c"
            alignment="right"
            backgroundColor="{{ currentSourceRow.it === '총계' ? '#FFED6F':
   currentSourceRow.it === '소계' && currentSourceRow.apparel_group != '시즌의류' ? '#ccebc5': 
  '#efefef'}}"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "0",
            }}
            groupAggregationMode="sum"
            key="tot_sale_amt"
            label="누적 실판매 금액"
            placeholder="Enter value"
            position="center"
            size={92}
            summaryAggregationMode="none"
            valueOverride="{{ item/1000000 }}"
          />
          <Column
            id="bf4bc"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{
              showSeparators: false,
              notation: "standard",
              decimalPlaces: "1",
              padDecimal: true,
            }}
            groupAggregationMode="average"
            label="누적 판매율(TAG)"
            placeholder="Enter value"
            position="center"
            referenceId="tot_sale_rate_tag"
            size={82}
            summaryAggregationMode="none"
            valueOverride="{{ currentSourceRow.tot_sale_tag/currentSourceRow.tot_in_tag }}"
          />
          <Column
            id="02ea2"
            alignment="right"
            backgroundColor="{{ currentSourceRow.it === '총계' ? '#FFED6F' : ''}}"
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "1",
              padDecimal: true,
            }}
            groupAggregationMode="average"
            label="누적판매율(실매출)"
            placeholder="Enter value"
            position="center"
            referenceId="tot_sale_rate_amt"
            size={82}
            summaryAggregationMode="none"
            valueOverride="{{ currentSourceRow.tot_sale_amt/currentSourceRow.tot_in_tag }}"
          />
          <Column
            id="e46c2"
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
            label="할인율"
            placeholder="Enter value"
            position="center"
            referenceId="discount_rate"
            size={63}
            summaryAggregationMode="none"
            valueOverride="{{(currentSourceRow.tot_sale_tag-currentSourceRow.tot_sale_amt)/currentSourceRow.tot_sale_tag }}"
          />
          <Column
            id="9fa86"
            alignment="right"
            backgroundColor="{{ currentSourceRow.it === '총계' ? '#bebada':
   currentSourceRow.it === '소계' && currentSourceRow.apparel_group != '시즌의류' ? '#ccebc5': 
  '#fccde5'}}"
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "1",
              padDecimal: true,
            }}
            groupAggregationMode="average"
            key="in_ratio"
            label="입고비중(TAG)"
            placeholder="Enter value"
            position="center"
            size={73.09375}
            summaryAggregationMode="none"
          />
          <Column
            id="d4897"
            alignment="right"
            backgroundColor="{{ currentSourceRow.it === '총계' ? '#bebada':
   currentSourceRow.it === '소계' && currentSourceRow.apparel_group != '시즌의류' ? '#ccebc5': 
  '#fccde5'}}"
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "1",
              padDecimal: true,
            }}
            groupAggregationMode="average"
            key="sale_ratio"
            label="판매비중(TAG)"
            placeholder="Enter value"
            position="center"
            size={75.234375}
            summaryAggregationMode="none"
          />
          <Column
            id="40aca"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            label="재고수량"
            placeholder="Enter value"
            position="center"
            referenceId="inven_qty"
            size={109}
            summaryAggregationMode="none"
            valueOverride="{{ currentSourceRow.tot_in_qty-currentSourceRow.tot_sale_qty }}"
          />
          <Column
            id="119f0"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "0",
            }}
            groupAggregationMode="sum"
            label="재고금액(TAG)"
            placeholder="Enter value"
            position="center"
            referenceId="inven_tag"
            size={90}
            summaryAggregationMode="none"
            valueOverride="{{ (currentSourceRow.tot_in_tag-currentSourceRow.tot_sale_tag)/1000000 }}"
          />
          <Column
            id="2280f"
            alignment="right"
            backgroundColor="{{ currentSourceRow.it === '총계' ? '#bebada':
   currentSourceRow.it === '소계' && currentSourceRow.apparel_group != '시즌의류' ? '#ccebc5': 
  '#afd7f2'}}"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="month_sale_qty"
            label="월간 판매수량"
            placeholder="Enter value"
            position="center"
            size={69.421875}
            summaryAggregationMode="none"
          />
          <Column
            id="0dd33"
            alignment="right"
            backgroundColor="{{ currentSourceRow.it === '총계' ? '#bebada':
   currentSourceRow.it === '소계' && currentSourceRow.apparel_group != '시즌의류' ? '#ccebc5': 
  '#afd7f2'}}"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "0",
            }}
            groupAggregationMode="sum"
            key="month_sale_tag"
            label="월간 판매금액(TAG)"
            placeholder="Enter value"
            position="center"
            size={87.515625}
            summaryAggregationMode="none"
            valueOverride="{{ item/1000000 }}"
          />
          <Column
            id="422c2"
            alignment="right"
            backgroundColor="{{ currentSourceRow.it === '총계' ?'#FFED6F':
   currentSourceRow.it === '소계' && currentSourceRow.apparel_group != '시즌의류' ? '#ccebc5': 
  '#afd7f2'}}"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "0",
            }}
            groupAggregationMode="sum"
            key="month_sale_amt"
            label="월간 실판매금액"
            placeholder="Enter value"
            position="center"
            size={78.625}
            summaryAggregationMode="none"
            valueOverride="{{ item/1000000 }}"
          />
          <Column
            id="c87f2"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="p_week_sale_qty"
            label="전주 판매수량"
            placeholder="Enter value"
            position="center"
            size={77.015625}
            summaryAggregationMode="none"
          />
          <Column
            id="87acb"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "0",
            }}
            groupAggregationMode="sum"
            key="p_week_sale_tag"
            label="전주 판매금액(TAG)"
            placeholder="Enter value"
            position="center"
            size={106.09375}
            summaryAggregationMode="none"
            valueOverride="{{ item/1000000 }}"
          />
          <Column
            id="bed0e"
            alignment="right"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "0",
            }}
            groupAggregationMode="sum"
            key="p_week_sale_amt"
            label="전주 실판매금액"
            placeholder="Enter value"
            position="center"
            referenceId="w"
            size={85.21875}
            summaryAggregationMode="none"
            valueOverride="{{ item/1000000 }}"
          />
          <Column
            id="a539b"
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
            label="전주 판매 진도율"
            placeholder="Enter value"
            position="center"
            referenceId="p_week_sale_rate"
            size={79.265625}
            summaryAggregationMode="none"
            valueOverride="{{ currentSourceRow.p_week_sale_tag/currentSourceRow.tot_in_tag }}"
          />
          <Column
            id="a37da"
            alignment="right"
            backgroundColor="{{ currentSourceRow.it === '총계' ? '#bebada':
   currentSourceRow.it === '소계' && currentSourceRow.apparel_group != '시즌의류' ? '#ccebc5': 
  '#ff9e93'}}"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            groupAggregationMode="sum"
            key="week_sale_qty"
            label="금주 판매수량"
            placeholder="Enter value"
            position="center"
            size={74.265625}
            summaryAggregationMode="none"
          />
          <Column
            id="7a3e0"
            alignment="right"
            backgroundColor="{{ currentSourceRow.it === '총계' ? '#bebada':
   currentSourceRow.it === '소계' && currentSourceRow.apparel_group != '시즌의류' ? '#ccebc5': 
  '#ff9e93'}}"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "0",
            }}
            groupAggregationMode="sum"
            key="week_sale_tag"
            label="금주 판매금액(TAG)"
            placeholder="Enter value"
            position="center"
            size={92.46875}
            summaryAggregationMode="none"
            valueOverride="{{ item/1000000 }}"
          />
          <Column
            id="5c707"
            alignment="right"
            backgroundColor="{{ currentSourceRow.it === '총계' ? '#FFED6F':
   currentSourceRow.it === '소계' && currentSourceRow.apparel_group != '시즌의류' ? '#ccebc5': 
  '#ff9e93'}}"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "0",
            }}
            groupAggregationMode="sum"
            key="week_sale_amt"
            label="금주 실판매금액"
            placeholder="Enter value"
            position="center"
            size={86.46875}
            summaryAggregationMode="none"
            valueOverride="{{ item/1000000 }}"
          />
          <Column
            id="79091"
            alignment="right"
            backgroundColor="{{ currentSourceRow.it === '총계' ? '#bebada':
   currentSourceRow.it === '소계' && currentSourceRow.apparel_group != '시즌의류' ? '#ccebc5': 
  '#ff9e93'}}"
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "1",
              padDecimal: false,
            }}
            groupAggregationMode="average"
            label="금주 판매 진도율"
            placeholder="Enter value"
            position="center"
            referenceId="week_sale_rate"
            size={84}
            summaryAggregationMode="none"
            valueOverride="{{ currentSourceRow.week_sale_tag/currentSourceRow.tot_in_tag }}"
          />
          <Column
            id="9a2a7"
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
            label="진도율 차"
            placeholder="Enter value"
            position="center"
            referenceId="diff_sale_rate"
            size={65}
            summaryAggregationMode="none"
            valueOverride="{{ currentSourceRow.week_sale_tag/currentSourceRow.tot_in_tag-currentSourceRow.p_week_sale_tag/currentSourceRow.tot_in_tag }}"
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
                            "{{ text30.value.slice(6) }}_{{get_same_weekday_new.data.same_date}}",
                        },
                      ],
                    },
                  },
                ],
              }}
              pluginId="cur_sales_table8"
              type="widget"
              waitMs="0"
              waitType="debounce"
            />
          </ToolbarButton>
        </Table>
      </View>
    </Container>
    <Include src="./src/container18.rsx" />
    <Table
      id="large_cat_download"
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ salesByLargeCat.value}}"
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      dynamicColumnProperties={{ formatByIndex: "auto" }}
      emptyMessage="No rows found"
      enableExpandableRows={true}
      enableSaveActions={true}
      hidden=""
      margin="0"
      primaryKeyColumnId="cb4b0"
      rowBackgroundColor="{{ currentSourceRow.it === '총계' ? '#bebada':
   currentSourceRow.it === '소계' && currentSourceRow.apparel_group != '시즌의류' ? '#ccebc5': 
  '#FFFFF'}}


"
      rowHeight="small"
      rowSelection="none"
      showColumnBorders={true}
      showHeader={true}
      style={{}}
      toolbarPosition="bottom"
    >
      <Include src="./src/large_cat_downloadExpandedRow.rsx" />
      <Column
        id="a6694"
        alignment="left"
        editableOptions={{ showStepper: true }}
        format="string"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="year_nm"
        label="연도"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="cb4b0"
        alignment="left"
        editable="false"
        format="markdown"
        groupAggregationMode="none"
        key="large_cat"
        label="구분"
        placeholder="Enter value"
        position="left"
        referenceId="large_cat"
        size={88.015625}
        summaryAggregationMode="none"
        valueOverride="**{{ item }}**"
      />
      <Column
        id="b4df6"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="ord_qty"
        label="발주수량"
        placeholder="Enter value"
        position="center"
        referenceId="ord_qty"
        size={90.234375}
        summaryAggregationMode="none"
      />
      <Column
        id="4b73f"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        key="ord_tag_amt"
        label="발주금액(TAG)"
        placeholder="Enter value"
        position="center"
        referenceId="ord_tag_amt"
        size={81.796875}
        summaryAggregationMode="none"
        valueOverride="{{ item/1000000 }}"
      />
      <Column
        id="8f0d2"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="average"
        label="입고율(TAG)"
        placeholder="Enter value"
        position="center"
        referenceId="in_rate"
        size={71}
        summaryAggregationMode="none"
        valueOverride="{{ currentSourceRow.tot_in_tag/currentSourceRow.ord_tag_amt }}"
      />
      <Column
        id="762f1"
        alignment="right"
        backgroundColor="{{ currentSourceRow.it === '총계' ? '#bebada':
   currentSourceRow.it === '소계' && currentSourceRow.apparel_group != '시즌의류' ? '#ccebc5': 
  '#efefef'}}"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="st_count"
        label="총 컬러수"
        placeholder="Enter value"
        position="center"
        size={58.609375}
        summaryAggregationMode="none"
      />
      <Column
        id="9ee60"
        alignment="right"
        backgroundColor="{{ currentSourceRow.it === '총계' ? '#bebada':
   currentSourceRow.it === '소계' && currentSourceRow.apparel_group != '시즌의류' ? '#ccebc5': 
  '#efefef'}}"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="{{ inventory_columns_toggle.value }}"
        key="in_st_count"
        label="입고 컬러수"
        placeholder="Enter value"
        position="center"
        size={66.796875}
        summaryAggregationMode="none"
      />
      <Column
        id="82fd2"
        alignment="right"
        backgroundColor="{{ currentSourceRow.it === '총계' ? '#bebada':
   currentSourceRow.it === '소계' && currentSourceRow.apparel_group != '시즌의류' ? '#ccebc5': 
  '#efefef'}}"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="{{ inventory_columns_toggle.value }}"
        label="미입고 컬러수"
        placeholder="Enter value"
        position="center"
        referenceId="not_in_st_count"
        size={63}
        summaryAggregationMode="none"
        valueOverride="{{ currentSourceRow.st_count - currentSourceRow.in_st_count }}"
      />
      <Column
        id="525a0"
        alignment="right"
        backgroundColor="{{ currentSourceRow.it === '총계' ? '#bebada':
   currentSourceRow.it === '소계' && currentSourceRow.apparel_group != '시즌의류' ? '#ccebc5': 
  '#efefef'}}"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="average"
        hidden="{{ inventory_columns_toggle.value }}"
        label="기획대비 컬러 입고율"
        placeholder="Enter value"
        position="center"
        referenceId="in_st_rate"
        size={75}
        summaryAggregationMode="none"
        valueOverride="{{currentSourceRow.in_st_count/currentSourceRow.st_count }}"
      />
      <Column
        id="32bf8"
        alignment="right"
        backgroundColor="{{ currentSourceRow.it === '총계' ? '#bebada':
   currentSourceRow.it === '소계' && currentSourceRow.apparel_group != '시즌의류' ? '#ccebc5': 
  '#efefef'}}"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="{{ inventory_columns_toggle.value }}"
        key="out_st_count"
        label="출고 컬러수"
        placeholder="Enter value"
        position="center"
        size={62}
        summaryAggregationMode="none"
      />
      <Column
        id="1b10e"
        alignment="right"
        backgroundColor="{{ currentSourceRow.it === '총계' ? '#bebada':
   currentSourceRow.it === '소계' && currentSourceRow.apparel_group != '시즌의류' ? '#ccebc5': 
  '#efefef'}}"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="{{ inventory_columns_toggle.value }}"
        label="미출고 컬러수"
        placeholder="Enter value"
        position="center"
        referenceId="not_out_st_count"
        size={65}
        summaryAggregationMode="none"
        valueOverride="{{ currentSourceRow.in_st_count - currentSourceRow.out_st_count }}"
      />
      <Column
        id="b52bd"
        alignment="right"
        backgroundColor="{{ currentSourceRow.it === '총계' ? '#bebada':
   currentSourceRow.it === '소계' && currentSourceRow.apparel_group != '시즌의류' ? '#ccebc5': 
  '#efefef'}}"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="average"
        hidden="{{ inventory_columns_toggle.value }}"
        label="입고대비 컬러 출고율"
        placeholder="Enter value"
        position="center"
        referenceId="out_st_rate"
        size={75}
        summaryAggregationMode="none"
        valueOverride="{{ currentSourceRow.out_st_count/currentSourceRow.in_st_count }}"
      />
      <Column
        id="0d659"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="tot_in_qty"
        label="총 입고수량"
        placeholder="Enter value"
        position="center"
        size={99}
        summaryAggregationMode="none"
      />
      <Column
        id="58926"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="tot_sale_qty"
        label="총 판매수량"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="961b1"
        alignment="right"
        backgroundColor="{{ currentSourceRow.it === '총계' ? '#FFED6F' : ''}}"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "1",
          padDecimal: true,
        }}
        groupAggregationMode="average"
        label="판매율(수량)"
        placeholder="Enter value"
        position="center"
        referenceId="tot_sale_rate_qty"
        size={73}
        summaryAggregationMode="none"
        valueOverride="{{ currentSourceRow.tot_sale_qty/currentSourceRow.tot_in_qty }}"
      />
      <Column
        id="442c8"
        alignment="right"
        backgroundColor="{{ currentSourceRow.it === '총계' ? '#bebada':
   currentSourceRow.it === '소계' && currentSourceRow.apparel_group != '시즌의류' ? '#ccebc5': 
  '#efefef'}}"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        key="tot_in_cost"
        label="누적 입고구입가(+)"
        placeholder="Enter value"
        position="center"
        size={88.765625}
        summaryAggregationMode="none"
        valueOverride="{{ item/1000000 }}"
      />
      <Column
        id="fb5c1"
        alignment="right"
        backgroundColor="{{ currentSourceRow.it === '총계' ? '#bebada':
   currentSourceRow.it === '소계' && currentSourceRow.apparel_group != '시즌의류' ? '#ccebc5': 
  '#efefef'}}"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "2",
          padDecimal: true,
        }}
        groupAggregationMode="sum"
        label="배수"
        placeholder="Enter value"
        position="center"
        referenceId="markup"
        size={45}
        summaryAggregationMode="none"
        valueOverride="{{ currentSourceRow.tot_in_tag/currentSourceRow.tot_in_cost }}"
      />
      <Column
        id="a0ac0"
        alignment="right"
        backgroundColor="{{ currentSourceRow.it === '총계' ? '#bebada':
   currentSourceRow.it === '소계' && currentSourceRow.apparel_group != '시즌의류' ? '#ccebc5': 
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
        label="누적 입고금액(TAG)"
        placeholder="Enter value"
        position="center"
        size={97}
        summaryAggregationMode="none"
        valueOverride="{{ item/1000000 }}"
      />
      <Column
        id="b0425"
        alignment="right"
        backgroundColor="{{ currentSourceRow.it === '총계' ? '#bebada':
   currentSourceRow.it === '소계' && currentSourceRow.apparel_group != '시즌의류' ? '#ccebc5': 
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
        label="누적 판매금액(TAG)"
        placeholder="Enter value"
        position="center"
        size={94}
        summaryAggregationMode="none"
        valueOverride="{{ item/1000000 }}"
      />
      <Column
        id="7099c"
        alignment="right"
        backgroundColor="{{ currentSourceRow.it === '총계' ? '#FFED6F':
   currentSourceRow.it === '소계' && currentSourceRow.apparel_group != '시즌의류' ? '#ccebc5': 
  '#efefef'}}"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        key="tot_sale_amt"
        label="누적 실판매 금액"
        placeholder="Enter value"
        position="center"
        size={92}
        summaryAggregationMode="none"
        valueOverride="{{ item/1000000 }}"
      />
      <Column
        id="bf4bc"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: false,
          notation: "standard",
          decimalPlaces: "1",
          padDecimal: true,
        }}
        groupAggregationMode="average"
        label="누적 판매율(TAG)"
        placeholder="Enter value"
        position="center"
        referenceId="tot_sale_rate_tag"
        size={82}
        summaryAggregationMode="none"
        valueOverride="{{ currentSourceRow.tot_sale_tag/currentSourceRow.tot_in_tag }}"
      />
      <Column
        id="02ea2"
        alignment="right"
        backgroundColor="{{ currentSourceRow.it === '총계' ? '#FFED6F' : ''}}"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "1",
          padDecimal: true,
        }}
        groupAggregationMode="average"
        label="누적판매율(실매출)"
        placeholder="Enter value"
        position="center"
        referenceId="tot_sale_rate_amt"
        size={82}
        summaryAggregationMode="none"
        valueOverride="{{ currentSourceRow.tot_sale_amt/currentSourceRow.tot_in_tag }}"
      />
      <Column
        id="e46c2"
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
        label="할인율"
        placeholder="Enter value"
        position="center"
        referenceId="discount_rate"
        size={63}
        summaryAggregationMode="none"
        valueOverride="{{(currentSourceRow.tot_sale_tag-currentSourceRow.tot_sale_amt)/currentSourceRow.tot_sale_tag }}"
      />
      <Column
        id="9fa86"
        alignment="right"
        backgroundColor="{{ currentSourceRow.it === '총계' ? '#bebada':
   currentSourceRow.it === '소계' && currentSourceRow.apparel_group != '시즌의류' ? '#ccebc5': 
  '#fccde5'}}"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "1",
          padDecimal: true,
        }}
        groupAggregationMode="average"
        key="in_ratio"
        label="입고비중(TAG)"
        placeholder="Enter value"
        position="center"
        size={73.09375}
        summaryAggregationMode="none"
      />
      <Column
        id="d4897"
        alignment="right"
        backgroundColor="{{ currentSourceRow.it === '총계' ? '#bebada':
   currentSourceRow.it === '소계' && currentSourceRow.apparel_group != '시즌의류' ? '#ccebc5': 
  '#fccde5'}}"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "1",
          padDecimal: true,
        }}
        groupAggregationMode="average"
        key="sale_ratio"
        label="판매비중(TAG)"
        placeholder="Enter value"
        position="center"
        size={75.234375}
        summaryAggregationMode="none"
      />
      <Column
        id="40aca"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        label="재고수량"
        placeholder="Enter value"
        position="center"
        referenceId="inven_qty"
        size={109}
        summaryAggregationMode="none"
        valueOverride="{{ currentSourceRow.tot_in_qty-currentSourceRow.tot_sale_qty }}"
      />
      <Column
        id="119f0"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        label="재고금액(TAG)"
        placeholder="Enter value"
        position="center"
        referenceId="inven_tag"
        size={90}
        summaryAggregationMode="none"
        valueOverride="{{ (currentSourceRow.tot_in_tag-currentSourceRow.tot_sale_tag)/1000000 }}"
      />
      <Column
        id="2280f"
        alignment="right"
        backgroundColor="{{ currentSourceRow.it === '총계' ? '#bebada':
   currentSourceRow.it === '소계' && currentSourceRow.apparel_group != '시즌의류' ? '#ccebc5': 
  '#afd7f2'}}"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="month_sale_qty"
        label="월간 판매수량"
        placeholder="Enter value"
        position="center"
        size={69.421875}
        summaryAggregationMode="none"
      />
      <Column
        id="0dd33"
        alignment="right"
        backgroundColor="{{ currentSourceRow.it === '총계' ? '#bebada':
   currentSourceRow.it === '소계' && currentSourceRow.apparel_group != '시즌의류' ? '#ccebc5': 
  '#afd7f2'}}"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        key="month_sale_tag"
        label="월간 판매금액(TAG)"
        placeholder="Enter value"
        position="center"
        size={87.515625}
        summaryAggregationMode="none"
        valueOverride="{{ item/1000000 }}"
      />
      <Column
        id="422c2"
        alignment="right"
        backgroundColor="{{ currentSourceRow.it === '총계' ?'#FFED6F':
   currentSourceRow.it === '소계' && currentSourceRow.apparel_group != '시즌의류' ? '#ccebc5': 
  '#afd7f2'}}"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        key="month_sale_amt"
        label="월간 실판매금액"
        placeholder="Enter value"
        position="center"
        size={78.625}
        summaryAggregationMode="none"
        valueOverride="{{ item/1000000 }}"
      />
      <Column
        id="c87f2"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="p_week_sale_qty"
        label="전주 판매수량"
        placeholder="Enter value"
        position="center"
        size={77.015625}
        summaryAggregationMode="none"
      />
      <Column
        id="87acb"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        key="p_week_sale_tag"
        label="전주 판매금액(TAG)"
        placeholder="Enter value"
        position="center"
        size={106.09375}
        summaryAggregationMode="none"
        valueOverride="{{ item/1000000 }}"
      />
      <Column
        id="bed0e"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        key="p_week_sale_amt"
        label="전주 실판매금액"
        placeholder="Enter value"
        position="center"
        referenceId="w"
        size={85.21875}
        summaryAggregationMode="none"
        valueOverride="{{ item/1000000 }}"
      />
      <Column
        id="a539b"
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
        label="전주 판매 진도율"
        placeholder="Enter value"
        position="center"
        referenceId="p_week_sale_rate"
        size={79.265625}
        summaryAggregationMode="none"
        valueOverride="{{ currentSourceRow.p_week_sale_tag/currentSourceRow.tot_in_tag }}"
      />
      <Column
        id="a37da"
        alignment="right"
        backgroundColor="{{ currentSourceRow.it === '총계' ? '#bebada':
   currentSourceRow.it === '소계' && currentSourceRow.apparel_group != '시즌의류' ? '#ccebc5': 
  '#ff9e93'}}"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="week_sale_qty"
        label="금주 판매수량"
        placeholder="Enter value"
        position="center"
        size={74.265625}
        summaryAggregationMode="none"
      />
      <Column
        id="7a3e0"
        alignment="right"
        backgroundColor="{{ currentSourceRow.it === '총계' ? '#bebada':
   currentSourceRow.it === '소계' && currentSourceRow.apparel_group != '시즌의류' ? '#ccebc5': 
  '#ff9e93'}}"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        key="week_sale_tag"
        label="금주 판매금액(TAG)"
        placeholder="Enter value"
        position="center"
        size={92.46875}
        summaryAggregationMode="none"
        valueOverride="{{ item/1000000 }}"
      />
      <Column
        id="5c707"
        alignment="right"
        backgroundColor="{{ currentSourceRow.it === '총계' ? '#FFED6F':
   currentSourceRow.it === '소계' && currentSourceRow.apparel_group != '시즌의류' ? '#ccebc5': 
  '#ff9e93'}}"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        key="week_sale_amt"
        label="금주 실판매금액"
        placeholder="Enter value"
        position="center"
        size={86.46875}
        summaryAggregationMode="none"
        valueOverride="{{ item/1000000 }}"
      />
      <Column
        id="79091"
        alignment="right"
        backgroundColor="{{ currentSourceRow.it === '총계' ? '#bebada':
   currentSourceRow.it === '소계' && currentSourceRow.apparel_group != '시즌의류' ? '#ccebc5': 
  '#ff9e93'}}"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "1",
          padDecimal: false,
        }}
        groupAggregationMode="average"
        label="금주 판매 진도율"
        placeholder="Enter value"
        position="center"
        referenceId="week_sale_rate"
        size={84}
        summaryAggregationMode="none"
        valueOverride="{{ currentSourceRow.week_sale_tag/currentSourceRow.tot_in_tag }}"
      />
      <Column
        id="9a2a7"
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
        label="진도율 차"
        placeholder="Enter value"
        position="center"
        referenceId="diff_sale_rate"
        size={65}
        summaryAggregationMode="none"
        valueOverride="{{ currentSourceRow.week_sale_tag/currentSourceRow.tot_in_tag-currentSourceRow.p_week_sale_tag/currentSourceRow.tot_in_tag }}"
      />
    </Table>
    <Table
      id="middle_cat_download"
      autoColumnWidth={true}
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ salesByMiddleCat.value }}"
      defaultSelectedRow={{ mode: "none", indexType: "display", index: 0 }}
      emptyMessage="No rows found"
      enableSaveActions={true}
      margin="8px 6px 3px 6px"
      rowHeight="xsmall"
      showBorder={true}
      showHeader={true}
      style={{
        headerFontSize: "10px",
        headerFontWeight: "600",
        headerFontFamily: "pretendard variable",
      }}
      toolbarPosition="bottom"
    >
      <Column
        id="1a11e"
        alignment="left"
        editableOptions={{ showStepper: true }}
        format="string"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="year_nm"
        label="연도"
        placeholder="Enter value"
        position="center"
        size={44.546875}
        summaryAggregationMode="none"
      />
      <Column
        id="07f28"
        alignment="left"
        format="string"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="large_cat"
        label="대분류"
        placeholder="Enter value"
        position="center"
        size={71.09375}
        summaryAggregationMode="none"
      />
      <Column
        id="c2158"
        alignment="left"
        editable="false"
        format="string"
        groupAggregationMode="none"
        key="middle_cat"
        label="중분류"
        placeholder="Enter value"
        position="center"
        size={71.09375}
        sortMode="disabled"
        summaryAggregationMode="none"
      />
      <Column
        id="b4336"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="st_count"
        label="총 컬러수"
        placeholder="Enter value"
        position="center"
        size={60.5}
        summaryAggregationMode="none"
      />
      <Column
        id="13440"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="tot_in_qty"
        label="총입고수량"
        placeholder="Enter value"
        position="center"
        size={67.859375}
        summaryAggregationMode="none"
      />
      <Column
        id="446de"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="tot_sale_qty"
        label="총판매수량"
        placeholder="Enter value"
        position="center"
        size={67.859375}
        summaryAggregationMode="none"
      />
      <Column
        id="d5c70"
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
        label="판매율(수량)"
        placeholder="Enter value"
        position="center"
        referenceId="tot_sale_rate_qty"
        size={76.03125}
        summaryAggregationMode="none"
        valueOverride="{{ currentSourceRow.tot_sale_qty/currentSourceRow.tot_in_qty }}"
      />
      <Column
        id="5dee7"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        label="재고수량"
        placeholder="Enter value"
        position="center"
        referenceId="inven_qty"
        size={57.484375}
        summaryAggregationMode="none"
        valueOverride="{{ currentSourceRow.tot_in_qty-currentSourceRow.tot_sale_qty }}"
      />
      <Column
        id="08662"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        label="재고금액(TAG)"
        placeholder="Enter value"
        position="center"
        referenceId="inven_tag"
        size={86}
        summaryAggregationMode="none"
        valueOverride="{{ (currentSourceRow.tot_in_tag-currentSourceRow.tot_sale_tag)/1000000 }}"
      />
      <Column
        id="74c26"
        alignment="right"
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
        size={86}
        summaryAggregationMode="none"
        valueOverride="{{ item/1000000 }}"
      />
      <Column
        id="a8a81"
        alignment="right"
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
        size={86}
        summaryAggregationMode="none"
        valueOverride="{{ item/1000000 }}"
      />
      <Column
        id="b1fdd"
        alignment="right"
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
        size={88.59375}
        summaryAggregationMode="none"
        valueOverride="{{ item/1000000 }}"
      />
      <Column
        id="aff56"
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
        label="누적판매율(TAG)"
        placeholder="Enter value"
        position="center"
        referenceId="tot_sale_rate_tag"
        size={86}
        summaryAggregationMode="none"
        textColor="{{ currentRow.tot_sale_rate_tag >= item ? '#fc5b5b' : '#000000' }}"
        valueOverride="{{ currentSourceRow.tot_sale_tag/currentSourceRow.tot_in_tag }}"
      />
      <Column
        id="751b4"
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
        label="누적실판매율"
        placeholder="Enter value"
        position="center"
        referenceId="tot_sale_rate_amt"
        size={78.21875}
        summaryAggregationMode="none"
        textColor="{{ currentRow.tot_sale_rate_amt >= item ? '#fc5b5b' : '#000000' }}"
        valueOverride="{{ currentSourceRow.tot_sale_amt/currentSourceRow.tot_in_tag }}"
      />
      <Column
        id="e1c95"
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
        label="할인율"
        placeholder="Enter value"
        position="center"
        referenceId="discount_rate"
        size={50.984375}
        summaryAggregationMode="none"
        valueOverride="{{(currentSourceRow.tot_sale_tag-currentSourceRow.tot_sale_amt)/currentSourceRow.tot_sale_tag }}"
      />
      <Column
        id="1b2e4"
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
        label="전주 판매 진도율"
        placeholder="Enter value"
        position="center"
        referenceId="p_week_sale_rate"
        size={86}
        summaryAggregationMode="none"
        valueOverride="{{ currentSourceRow.p_week_sale_tag/currentSourceRow.tot_in_tag }}"
      />
      <Column
        id="a4c54"
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
        label="금주 판매 진도율"
        placeholder="Enter value"
        position="center"
        referenceId="week_sale_rate"
        size={86}
        summaryAggregationMode="none"
        valueOverride="{{ currentSourceRow.week_sale_tag/currentSourceRow.tot_in_tag }}"
      />
      <Column
        id="cfef9"
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
        label="진도율차"
        placeholder="Enter value"
        position="center"
        referenceId="diff_sale_rate"
        size={57.484375}
        summaryAggregationMode="none"
        valueOverride="{{ currentSourceRow.week_sale_tag/currentSourceRow.tot_in_tag-currentSourceRow.p_week_sale_tag/currentSourceRow.tot_in_tag }}"
      />
      <Event
        event="clickRow"
        method="setValue"
        params={{ ordered: [{ value: "{{ currentSourceRow }}" }] }}
        pluginId="var_clicked_middle_cat"
        type="state"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        event="clickRow"
        method="show"
        params={{ ordered: [] }}
        pluginId="modal_item_list"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </Table>
    <Table
      id="comparison_large_cat_download"
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ compareByLargeCat.value }}"
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      dynamicColumnProperties={{ formatByIndex: "auto" }}
      emptyMessage="No rows found"
      enableExpandableRows={true}
      enableSaveActions={true}
      hidden=""
      margin="0"
      primaryKeyColumnId="cb4b0"
      rowBackgroundColor="{{ currentSourceRow.it === '총계' ? '#bebada':
   currentSourceRow.it === '소계' && currentSourceRow.apparel_group != '시즌의류' ? '#ccebc5': 
  '#FFFFF'}}


"
      rowHeight="medium"
      rowSelection="none"
      showColumnBorders={true}
      showHeader={true}
      style={{}}
      toolbarPosition="bottom"
    >
      <Include src="./src/comparison_large_cat_downloadExpandedRow.rsx" />
      <Column
        id="cb4b0"
        alignment="left"
        editable="false"
        format="markdown"
        groupAggregationMode="none"
        key="large_cat"
        label="구분"
        placeholder="Enter value"
        position="left"
        referenceId="large_cat"
        size={88.015625}
        sortMode="disabled"
        summaryAggregationMode="none"
        valueOverride="**{{ item }}**"
      />
      <Column
        id="b4df6"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="ord_qty"
        label="발주수량"
        placeholder="Enter value"
        position="center"
        referenceId="ord_qty"
        size={90.234375}
        summaryAggregationMode="none"
      />
      <Column
        id="4b73f"
        alignment="right"
        caption="{{ (compare_yoy.value[i].ord_tag_amt * 100).toFixed(1)+'%'}}"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        key="ord_tag_amt"
        label="발주금액(TAG)"
        placeholder="Enter value"
        position="center"
        referenceId="ord_tag_amt"
        size={81.796875}
        summaryAggregationMode="none"
        valueOverride="{{ item/1000000 }}"
      />
      <Column
        id="8f0d2"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="average"
        key="in_rate"
        label="입고율(TAG)"
        placeholder="Enter value"
        position="center"
        referenceId="in_rate"
        size={71}
        summaryAggregationMode="none"
      />
      <Column
        id="762f1"
        alignment="right"
        backgroundColor="{{ currentSourceRow.it === '총계' ? '#bebada':
   currentSourceRow.it === '소계' && currentSourceRow.apparel_group != '시즌의류' ? '#ccebc5': 
  '#efefef'}}"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="st_count"
        label="총 컬러수"
        placeholder="Enter value"
        position="center"
        size={58.609375}
        summaryAggregationMode="none"
      />
      <Column
        id="9ee60"
        alignment="right"
        backgroundColor="{{ currentSourceRow.it === '총계' ? '#bebada':
   currentSourceRow.it === '소계' && currentSourceRow.apparel_group != '시즌의류' ? '#ccebc5': 
  '#efefef'}}"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="{{ inventory_columns_toggle.value }}"
        key="in_st_count"
        label="입고 컬러수"
        placeholder="Enter value"
        position="center"
        size={66.796875}
        summaryAggregationMode="none"
      />
      <Column
        id="82fd2"
        alignment="right"
        backgroundColor="{{ currentSourceRow.it === '총계' ? '#bebada':
   currentSourceRow.it === '소계' && currentSourceRow.apparel_group != '시즌의류' ? '#ccebc5': 
  '#efefef'}}"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="{{ inventory_columns_toggle.value }}"
        key="not_in_st_count"
        label="미입고 컬러수"
        placeholder="Enter value"
        position="center"
        referenceId="not_in_st_count"
        size={63}
        summaryAggregationMode="none"
      />
      <Column
        id="525a0"
        alignment="right"
        backgroundColor="{{ currentSourceRow.it === '총계' ? '#bebada':
   currentSourceRow.it === '소계' && currentSourceRow.apparel_group != '시즌의류' ? '#ccebc5': 
  '#efefef'}}"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="average"
        hidden="{{ inventory_columns_toggle.value }}"
        label="기획대비 컬러 입고율"
        placeholder="Enter value"
        position="center"
        referenceId="in_st_rate"
        size={75}
        summaryAggregationMode="none"
        valueOverride="{{currentSourceRow.in_st_count/currentSourceRow.st_count }}"
      />
      <Column
        id="32bf8"
        alignment="right"
        backgroundColor="{{ currentSourceRow.it === '총계' ? '#bebada':
   currentSourceRow.it === '소계' && currentSourceRow.apparel_group != '시즌의류' ? '#ccebc5': 
  '#efefef'}}"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="{{ inventory_columns_toggle.value }}"
        key="out_st_count"
        label="출고 컬러수"
        placeholder="Enter value"
        position="center"
        size={62}
        summaryAggregationMode="none"
      />
      <Column
        id="1b10e"
        alignment="right"
        backgroundColor="{{ currentSourceRow.it === '총계' ? '#bebada':
   currentSourceRow.it === '소계' && currentSourceRow.apparel_group != '시즌의류' ? '#ccebc5': 
  '#efefef'}}"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        hidden="{{ inventory_columns_toggle.value }}"
        key="not_out_st_count"
        label="미출고 컬러수"
        placeholder="Enter value"
        position="center"
        referenceId="not_out_st_count"
        size={65}
        summaryAggregationMode="none"
      />
      <Column
        id="b52bd"
        alignment="right"
        backgroundColor="{{ currentSourceRow.it === '총계' ? '#bebada':
   currentSourceRow.it === '소계' && currentSourceRow.apparel_group != '시즌의류' ? '#ccebc5': 
  '#efefef'}}"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="average"
        hidden="{{ inventory_columns_toggle.value }}"
        key="out_st_rate"
        label="입고대비 컬러 출고율"
        placeholder="Enter value"
        position="center"
        referenceId="out_st_rate"
        size={75}
        summaryAggregationMode="none"
      />
      <Column
        id="0d659"
        alignment="right"
        caption="{{ (compare_yoy.value[i].tot_in_qty * 100).toFixed(1)+'%'}}"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="tot_in_qty"
        label="총 입고수량"
        placeholder="Enter value"
        position="center"
        size={99}
        summaryAggregationMode="none"
      />
      <Column
        id="58926"
        alignment="right"
        caption="{{ (compare_yoy.value[i].tot_sale_qty * 100).toFixed(1)+'%'}}"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="tot_sale_qty"
        label="총 판매수량"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="961b1"
        alignment="right"
        backgroundColor="{{ currentSourceRow.it === '총계' ? '#FFED6F' : ''}}"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "1",
          padDecimal: true,
        }}
        groupAggregationMode="average"
        key="tot_sale_rate_qty"
        label="판매율(수량)"
        placeholder="Enter value"
        position="center"
        referenceId="tot_sale_rate_qty"
        size={73}
        summaryAggregationMode="none"
      />
      <Column
        id="442c8"
        alignment="right"
        backgroundColor="{{ currentSourceRow.it === '총계' ? '#bebada':
   currentSourceRow.it === '소계' && currentSourceRow.apparel_group != '시즌의류' ? '#ccebc5': 
  '#efefef'}}"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        key="tot_in_cost"
        label="누적 입고구입가(+)"
        placeholder="Enter value"
        position="center"
        size={88.765625}
        summaryAggregationMode="none"
        valueOverride="{{ item/1000000 }}"
      />
      <Column
        id="fb5c1"
        alignment="right"
        backgroundColor="{{ currentSourceRow.it === '총계' ? '#bebada':
   currentSourceRow.it === '소계' && currentSourceRow.apparel_group != '시즌의류' ? '#ccebc5': 
  '#efefef'}}"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "1",
          padDecimal: true,
        }}
        groupAggregationMode="sum"
        key="markup"
        label="배수"
        placeholder="Enter value"
        position="center"
        referenceId="markup"
        size={67}
        summaryAggregationMode="none"
      />
      <Column
        id="a0ac0"
        alignment="right"
        backgroundColor="{{ currentSourceRow.it === '총계' ? '#bebada':
   currentSourceRow.it === '소계' && currentSourceRow.apparel_group != '시즌의류' ? '#ccebc5': 
  '#efefef'}}"
        caption="{{ (compare_yoy.value[i].tot_in_tag * 100).toFixed(1)+'%'}}"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        key="tot_in_tag"
        label="누적 입고금액(TAG)"
        placeholder="Enter value"
        position="center"
        size={97}
        summaryAggregationMode="none"
        valueOverride="{{ item/1000000 }}"
      />
      <Column
        id="b0425"
        alignment="right"
        backgroundColor="{{ currentSourceRow.it === '총계' ? '#bebada':
   currentSourceRow.it === '소계' && currentSourceRow.apparel_group != '시즌의류' ? '#ccebc5': 
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
        label="누적 판매금액(TAG)"
        placeholder="Enter value"
        position="center"
        size={94}
        summaryAggregationMode="none"
        valueOverride="{{ item/1000000 }}"
      />
      <Column
        id="7099c"
        alignment="right"
        backgroundColor="{{ currentSourceRow.it === '총계' ? '#FFED6F':
   currentSourceRow.it === '소계' && currentSourceRow.apparel_group != '시즌의류' ? '#ccebc5': 
  '#efefef'}}"
        caption="{{ (compare_yoy.value[i].tot_sale_amt * 100).toFixed(1)+'%'}}"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        key="tot_sale_amt"
        label="누적 실판매 금액"
        placeholder="Enter value"
        position="center"
        size={92}
        summaryAggregationMode="none"
        valueOverride="{{ item/1000000 }}"
      />
      <Column
        id="bf4bc"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: false,
          notation: "standard",
          decimalPlaces: "1",
          padDecimal: true,
        }}
        groupAggregationMode="average"
        key="tot_sale_rate_tag"
        label="누적 판매율(TAG)"
        placeholder="Enter value"
        position="center"
        referenceId="tot_sale_rate_tag"
        size={82}
        summaryAggregationMode="none"
      />
      <Column
        id="02ea2"
        alignment="right"
        backgroundColor="{{ currentSourceRow.it === '총계' ? '#FFED6F' : ''}}"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "1",
          padDecimal: true,
        }}
        groupAggregationMode="average"
        key="tot_sale_rate_amt"
        label="누적판매율(실매출)"
        placeholder="Enter value"
        position="center"
        referenceId="tot_sale_rate_amt"
        size={82}
        summaryAggregationMode="none"
      />
      <Column
        id="e46c2"
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
        key="discount_rate"
        label="할인율"
        placeholder="Enter value"
        position="center"
        referenceId="discount_rate"
        size={63}
        summaryAggregationMode="none"
      />
      <Column
        id="9fa86"
        alignment="right"
        backgroundColor="{{ currentSourceRow.it === '총계' ? '#bebada':
   currentSourceRow.it === '소계' && currentSourceRow.apparel_group != '시즌의류' ? '#ccebc5': 
  '#fccde5'}}"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "1",
          padDecimal: true,
        }}
        groupAggregationMode="average"
        key="in_ratio"
        label="입고비중(TAG)"
        placeholder="Enter value"
        position="center"
        size={73.09375}
        summaryAggregationMode="none"
      />
      <Column
        id="d4897"
        alignment="right"
        backgroundColor="{{ currentSourceRow.it === '총계' ? '#bebada':
   currentSourceRow.it === '소계' && currentSourceRow.apparel_group != '시즌의류' ? '#ccebc5': 
  '#fccde5'}}"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "1",
          padDecimal: true,
        }}
        groupAggregationMode="average"
        key="sale_ratio"
        label="판매비중(TAG)"
        placeholder="Enter value"
        position="center"
        size={75.234375}
        summaryAggregationMode="none"
      />
      <Column
        id="40aca"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="inven_qty"
        label="재고수량"
        placeholder="Enter value"
        position="center"
        referenceId="inven_qty"
        size={109}
        summaryAggregationMode="none"
      />
      <Column
        id="119f0"
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
        label="재고금액(TAG)"
        placeholder="Enter value"
        position="center"
        referenceId="inven_tag"
        size={90}
        summaryAggregationMode="none"
        valueOverride="{{ item/1000000 }}"
      />
      <Column
        id="2280f"
        alignment="right"
        backgroundColor="{{ currentSourceRow.it === '총계' ? '#bebada':
   currentSourceRow.it === '소계' && currentSourceRow.apparel_group != '시즌의류' ? '#ccebc5': 
  '#afd7f2'}}"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="month_sale_qty"
        label="월간 판매수량"
        placeholder="Enter value"
        position="center"
        size={69.421875}
        summaryAggregationMode="none"
      />
      <Column
        id="0dd33"
        alignment="right"
        backgroundColor="{{ currentSourceRow.it === '총계' ? '#bebada':
   currentSourceRow.it === '소계' && currentSourceRow.apparel_group != '시즌의류' ? '#ccebc5': 
  '#afd7f2'}}"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        key="month_sale_tag"
        label="월간 판매금액(TAG)"
        placeholder="Enter value"
        position="center"
        size={87.515625}
        summaryAggregationMode="none"
        valueOverride="{{ item/1000000 }}"
      />
      <Column
        id="422c2"
        alignment="right"
        backgroundColor="{{ currentSourceRow.it === '총계' ?'#FFED6F':
   currentSourceRow.it === '소계' && currentSourceRow.apparel_group != '시즌의류' ? '#ccebc5': 
  '#afd7f2'}}"
        caption="{{ (compare_yoy.value[i].month_sale_amt * 100).toFixed(1)+'%'}}"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        key="month_sale_amt"
        label="월간 실판매금액"
        placeholder="Enter value"
        position="center"
        size={78.625}
        summaryAggregationMode="none"
        valueOverride="{{ item/1000000 }}"
      />
      <Column
        id="c87f2"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="p_week_sale_qty"
        label="전주 판매수량"
        placeholder="Enter value"
        position="center"
        size={77.015625}
        summaryAggregationMode="none"
      />
      <Column
        id="87acb"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        key="p_week_sale_tag"
        label="전주 판매금액(TAG)"
        placeholder="Enter value"
        position="center"
        size={106.09375}
        summaryAggregationMode="none"
        valueOverride="{{ item/1000000 }}"
      />
      <Column
        id="bed0e"
        alignment="right"
        caption="{{ (compare_yoy.value[i].p_week_sale_amt * 100).toFixed(1)+'%'}}"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        key="p_week_sale_amt"
        label="전주 실판매금액"
        placeholder="Enter value"
        position="center"
        referenceId="w"
        size={85.21875}
        summaryAggregationMode="none"
        valueOverride="{{ item/1000000 }}"
      />
      <Column
        id="a539b"
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
        key="p_week_sale_rate"
        label="전주 판매 진도율"
        placeholder="Enter value"
        position="center"
        referenceId="p_week_sale_rate"
        size={79.265625}
        summaryAggregationMode="none"
      />
      <Column
        id="a37da"
        alignment="right"
        backgroundColor="{{ currentSourceRow.it === '총계' ? '#bebada':
   currentSourceRow.it === '소계' && currentSourceRow.apparel_group != '시즌의류' ? '#ccebc5': 
  '#ff9e93'}}"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="week_sale_qty"
        label="금주 판매수량"
        placeholder="Enter value"
        position="center"
        size={74.265625}
        summaryAggregationMode="none"
      />
      <Column
        id="7a3e0"
        alignment="right"
        backgroundColor="{{ currentSourceRow.it === '총계' ? '#bebada':
   currentSourceRow.it === '소계' && currentSourceRow.apparel_group != '시즌의류' ? '#ccebc5': 
  '#ff9e93'}}"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        key="week_sale_tag"
        label="금주 판매금액(TAG)"
        placeholder="Enter value"
        position="center"
        size={92.46875}
        summaryAggregationMode="none"
        valueOverride="{{ item/1000000 }}"
      />
      <Column
        id="5c707"
        alignment="right"
        backgroundColor="{{ currentSourceRow.it === '총계' ? '#FFED6F':
   currentSourceRow.it === '소계' && currentSourceRow.apparel_group != '시즌의류' ? '#ccebc5': 
  '#ff9e93'}}"
        caption="{{ (compare_yoy.value[i].week_sale_amt * 100).toFixed(1)+'%'}}"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        key="week_sale_amt"
        label="금주 실판매금액"
        placeholder="Enter value"
        position="center"
        size={86.46875}
        summaryAggregationMode="none"
        valueOverride="{{ item/1000000 }}"
      />
      <Column
        id="79091"
        alignment="right"
        backgroundColor="{{ currentSourceRow.it === '총계' ? '#bebada':
   currentSourceRow.it === '소계' && currentSourceRow.apparel_group != '시즌의류' ? '#ccebc5': 
  '#ff9e93'}}"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "1",
          padDecimal: false,
        }}
        groupAggregationMode="average"
        key="week_sale_rate"
        label="금주 판매 진도율"
        placeholder="Enter value"
        position="center"
        referenceId="week_sale_rate"
        size={84}
        summaryAggregationMode="none"
      />
      <Column
        id="9a2a7"
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
        key="diff_sale_rate"
        label="진도율 차"
        placeholder="Enter value"
        position="center"
        referenceId="diff_sale_rate"
        size={65}
        summaryAggregationMode="none"
      />
      <Event
        event="changeSort"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="salesByColor"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </Table>
    <Table
      id="comparison_middle_cat_download"
      autoColumnWidth={true}
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ compareByMiddleCat.value }} "
      defaultSelectedRow={{ mode: "none", indexType: "display", index: 0 }}
      emptyMessage="No rows found"
      enableSaveActions={true}
      margin="8px 6px 3px 6px"
      rowHeight="xsmall"
      showBorder={true}
      showHeader={true}
      style={{
        headerFontSize: "10px",
        headerFontWeight: "600",
        headerFontFamily: "pretendard variable",
      }}
      toolbarPosition="bottom"
    >
      <Column
        id="a1f07"
        alignment="left"
        format="string"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="large_cat"
        label="대분류"
        placeholder="Enter value"
        position="center"
        size={60.734375}
        sortMode="disabled"
        summaryAggregationMode="none"
      />
      <Column
        id="c2158"
        alignment="left"
        editable="false"
        format="string"
        groupAggregationMode="none"
        key="middle_cat"
        label="중분류"
        placeholder="Enter value"
        position="center"
        size={47.109375}
        sortMode="disabled"
        summaryAggregationMode="none"
      />
      <Column
        id="b4336"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="st_count"
        label="총 컬러수"
        placeholder="Enter value"
        position="center"
        size={60.5}
        summaryAggregationMode="none"
      />
      <Column
        id="13440"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="tot_in_qty"
        label="총입고수량"
        placeholder="Enter value"
        position="center"
        size={67.859375}
        summaryAggregationMode="none"
      />
      <Column
        id="446de"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="tot_sale_qty"
        label="총판매수량"
        placeholder="Enter value"
        position="center"
        size={67.859375}
        summaryAggregationMode="none"
      />
      <Column
        id="d5c70"
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
        label="판매율(수량)"
        placeholder="Enter value"
        position="center"
        referenceId="tot_sale_rate_qty"
        size={76.03125}
        summaryAggregationMode="none"
        valueOverride="{{ currentSourceRow.tot_sale_qty/currentSourceRow.tot_in_qty }}"
      />
      <Column
        id="5dee7"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="inven_qty"
        label="재고수량"
        placeholder="Enter value"
        position="center"
        referenceId="inven_qty"
        size={57.484375}
        summaryAggregationMode="none"
      />
      <Column
        id="08662"
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
        label="재고금액(TAG)"
        placeholder="Enter value"
        position="center"
        referenceId="inven_tag"
        size={87.859375}
        summaryAggregationMode="none"
        valueOverride="{{ item/1000000 }}"
      />
      <Column
        id="74c26"
        alignment="right"
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
        size={108.59375}
        summaryAggregationMode="none"
        valueOverride="{{ item/1000000 }}"
      />
      <Column
        id="a8a81"
        alignment="right"
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
        size={108.59375}
        summaryAggregationMode="none"
        valueOverride="{{ item/1000000 }}"
      />
      <Column
        id="b1fdd"
        alignment="right"
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
        size={88.59375}
        summaryAggregationMode="none"
        valueOverride="{{ item/1000000 }}"
      />
      <Column
        id="aff56"
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
        key="tot_sale_rate_tag"
        label="누적판매율(TAG)"
        placeholder="Enter value"
        position="center"
        referenceId="tot_sale_rate_tag"
        size={98.234375}
        summaryAggregationMode="none"
        textColor="{{ currentRow.tot_sale_rate_tag >= item ? '#fc5b5b' : '#000000' }}"
      />
      <Column
        id="751b4"
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
        key="tot_sale_rate_amt"
        label="누적실판매율"
        placeholder="Enter value"
        position="center"
        referenceId="tot_sale_rate_amt"
        size={78.21875}
        summaryAggregationMode="none"
        textColor="{{ currentRow.tot_sale_rate_amt >= item ? '#fc5b5b' : '#000000' }}"
      />
      <Column
        id="e1c95"
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
        key="discount_rate"
        label="할인율"
        placeholder="Enter value"
        position="center"
        referenceId="discount_rate"
        size={49}
        summaryAggregationMode="none"
      />
      <Column
        id="1b2e4"
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
        key="p_week_sale_rate"
        label="전주 판매 진도율"
        placeholder="Enter value"
        position="center"
        referenceId="p_week_sale_rate"
        size={94.625}
        summaryAggregationMode="none"
      />
      <Column
        id="a4c54"
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
        key="week_sale_rate"
        label="금주 판매 진도율"
        placeholder="Enter value"
        position="center"
        referenceId="week_sale_rate"
        size={94.625}
        summaryAggregationMode="none"
      />
      <Column
        id="cfef9"
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
        key="diff_sale_rate"
        label="진도율차"
        placeholder="Enter value"
        position="center"
        referenceId="diff_sale_rate"
        size={57.484375}
        summaryAggregationMode="none"
      />
    </Table>
  </Frame>
</App>
