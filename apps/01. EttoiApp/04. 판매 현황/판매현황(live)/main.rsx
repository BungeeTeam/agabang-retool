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
    secondary=""
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
  <AppStyles id="$appStyles" css="" />
  <DocumentTitle id="$customDocumentTitle" value="판매현황 | ET" />
  <Include src="./header.rsx" />
  <Include src="./src/drawerFrame_item_detail_new.rsx" />
  <Include src="./src/shop_sales.rsx" />
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
    <SegmentedControl
      id="sel_category"
      data="{{ var_category_list.value[['season_less'].includes(select_item_type.value) ? 'season_less' : 
  ['yongpum'].includes(select_item_type.value) ? 'yongpum' : 'season']}}"
      label=""
      labelPosition="top"
      labels="{{ item.cat_nm }}"
      paddingType="spacious"
      style={{
        ordered: [
          { indicatorBackground: "primary" },
          { background: "rgb(255, 255, 255)" },
          { border: "canvas" },
        ],
      }}
      value="{{ self.values[0] }}"
      values="{{ item.id }}"
    />
    <Include src="./src/collapsibleContainer1.rsx" />
    <ListViewBeta
      id="listView_main"
      data="{{ merged_category_list.value[sel_category.value] }}"
      enableInstanceValues={true}
      itemWidth="200px"
      margin="0"
      numColumns={3}
      padding="0"
    >
      <Container
        id="container7"
        footerPadding="4px 12px"
        headerPadding="4px 12px"
        padding="0"
        showBody={true}
        showBorder={false}
        showHeader={true}
        showHeaderBorder={false}
        style={{
          ordered: [
            { headerBackground: "canvas" },
            { background: "rgba(255, 255, 255, 0)" },
          ],
        }}
      >
        <Header>
          <Text
            id="containerTitle9"
            hidden="{{  }}"
            margin="0"
            value="###### {{ item }} |  {{get_item_list_new.data[item] == null ? 0 : get_item_list_new.data[item].length}} SKU"
            verticalAlign="center"
          />
        </Header>
        <View id="a7c37" viewKey="View 1">
          <Table
            id="table_item_list"
            cellSelection="none"
            clearChangesetOnSave={true}
            data="{{ var_item_list.value[listView_main.item] }}"
            defaultSelectedRow={{
              mode: "index",
              indexType: "display",
              index: "",
            }}
            emptyMessage="상품이 없습니다"
            enableSaveActions={true}
            heightType="auto"
            margin="0"
            rowBackgroundColor="{{ currentSourceRow.bg_color ?? 'white'  }}"
            rowHeight="large"
            searchTerm="{{search_text.value}}"
            showBorder={true}
            showHeader={true}
            style={{}}
          >
            <Column
              id="17ab6"
              alignment="center"
              backgroundColor="{{ currentSourceRow.bg_color ?? 'FFFFFF' }}"
              cellTooltip="{{ item }}"
              editable="false"
              format="image"
              formatOptions={{ widthType: "fit" }}
              groupAggregationMode="none"
              label="제품사진"
              placeholder="Enter value"
              position="left"
              referenceId="item_image"
              size={89.984375}
              sortMode="disabled"
              summaryAggregationMode="none"
              valueOverride="{{ currentSourceRow.sty_cd?.length>0 ? `https://agabang-image.s3.ap-northeast-2.amazonaws.com/item_final/${currentSourceRow.sty_cd}${currentSourceRow.col_cd}.jpg` : null }}"
            />
            <Column
              id="7ddf8"
              alignment="center"
              caption="{{currentSourceRow.sty_cd}}"
              format="string"
              groupAggregationMode="none"
              key="sty_nm"
              label="품명"
              placeholder="Enter value"
              position="left"
              size={164.34375}
            />
            <Column
              id="eba34"
              alignment="center"
              format="tag"
              formatOptions={{
                automaticColors: false,
                color:
                  "{{ JSON.parse(retoolContext.configVars.var_color_dict)[item] }}",
              }}
              groupAggregationMode="none"
              key="col_nm"
              label="컬러"
              placeholder="Select option"
              position="left"
              size={100}
            />
            <Column
              id="9cd90"
              alignment="left"
              format="string"
              groupAggregationMode="none"
              hidden="true"
              key="sty_cd"
              label="Sty cd"
              placeholder="Enter value"
              position="center"
              size={82.21875}
            />
            <Column
              id="d4648"
              alignment="center"
              format="tag"
              formatOptions={{ automaticColors: true }}
              groupAggregationMode="none"
              hidden="true"
              key="year_season"
              label="시즌"
              placeholder="Select option"
              position="center"
              size={82.71875}
            />
            <Column
              id="a8a24"
              alignment="center"
              format="tag"
              formatOptions={{ automaticColors: true }}
              groupAggregationMode="none"
              hidden="true"
              key="cat_nm"
              label="복종"
              placeholder="Select option"
              position="center"
              size={63.078125}
              valueOverride="{{ _.startCase(item) }}"
            />
            <Column
              id="0bfe5"
              alignment="center"
              format="tag"
              formatOptions={{ automaticColors: true }}
              groupAggregationMode="none"
              hidden="true"
              key="item_nm"
              label="아이템"
              placeholder="Select option"
              position="center"
              size={105.171875}
              valueOverride="{{ _.startCase(item) }}"
            />
            <Column
              id="93cf9"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="sum"
              key="tot_in_qty"
              label="입고량"
              placeholder="Enter value"
              position="center"
              referenceId="qty_received"
              size={66.078125}
            />
            <Column
              id="8ad70"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="sum"
              label="재고량"
              placeholder="Enter value"
              position="center"
              referenceId="qty_in_stock"
              size={68.078125}
              valueOverride="{{currentSourceRow.tot_in_qty -currentSourceRow.tot_sale_qty}}"
            />
            <Column
              id="f9a26"
              alignment="right"
              backgroundColor="{{ theme.canvas }}"
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="sum"
              key="tot_sale_qty"
              label="판매량"
              placeholder="Enter value"
              position="center"
              referenceId="qty_sold"
              size={80.078125}
            />
            <Column
              id="e27d1"
              alignment="center"
              backgroundColor="{{ theme.canvas }}"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="average"
              key="sale_per_tot"
              label="판매율(%)"
              placeholder="Enter value"
              position="center"
              size={110}
              textColor="{{color_grad(item)}}"
            />
            <Column
              id="23f5a"
              alignment="left"
              editableOptions={{ showStepper: true }}
              format="html"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="average"
              key="sale_per_tot"
              placeholder="Enter value"
              position="center"
              referenceId="sale_per_tot_bar"
              size={92.984375}
              valueOverride={
                '<div style="width: 60px; height: 10px; background-color: #e6e6e6; border-radius:10px; margin: none; padding: none;">\n  <div style="width: {{Math.max(10, item * 60)}}px; height: 10px; background-color: {{item >= 0.8 ? "#CC3333" : "#888"}}; border-radius: 10px;"></div>\n</div>'
              }
            />
            <Column
              id="0da7a"
              alignment="center"
              editableOptions={{ showStepper: true }}
              format="tag"
              formatOptions={{
                automaticColors: false,
                color: '{{ item > 60 ? "orange": "" }}',
              }}
              groupAggregationMode="sum"
              key="shop_gini"
              label="매장편중"
              placeholder="Select option"
              position="center"
              size={100}
              valueOverride="{{ (currentSourceRow.shop_gini === null) ? null : Math.max(0, Math.round(((item - 0.3) / (0.7 - 0.3))*100)) }}"
            >
              <Event
                event="clickCell"
                method="show"
                params={{ ordered: [] }}
                pluginId="shop_sales"
                type="widget"
                waitMs="0"
                waitType="debounce"
              />
              <Event
                event="clickCell"
                method="hide"
                params={{ ordered: [] }}
                pluginId="drawerFrame_item_detail"
                type="widget"
                waitMs="0"
                waitType="debounce"
              />
              <Event
                event="clickCell"
                method="setValue"
                params={{ ordered: [{ value: "sales" }] }}
                pluginId="shop_modal_tab"
                type="widget"
                waitMs="0"
                waitType="debounce"
              />
            </Column>
            <Column
              id="d97ad"
              alignment="center"
              editableOptions={{ showStepper: true }}
              format="tag"
              formatOptions={{
                automaticColors: false,
                color:
                  '{{ Number(item.replace("%",\'\')) > 30 ? "orange": "" }}',
              }}
              groupAggregationMode="average"
              key="online_sale_per"
              label="온라인비율(%)"
              placeholder="Select option"
              position="center"
              size={104}
              valueOverride="{{ item ? `${(item*100).toFixed(0)}%` : null }}"
            >
              <Event
                event="clickCell"
                method="show"
                params={{ ordered: [] }}
                pluginId="shop_sales"
                type="widget"
                waitMs="0"
                waitType="debounce"
              />
              <Event
                event="clickCell"
                method="setValue"
                params={{ ordered: [{ value: "online" }] }}
                pluginId="shop_modal_tab"
                type="widget"
                waitMs="0"
                waitType="debounce"
              />
              <Event
                event="clickCell"
                method="hide"
                params={{ ordered: [] }}
                pluginId="drawerFrame_item_detail"
                type="widget"
                waitMs="0"
                waitType="debounce"
              />
            </Column>
            <Column
              id="89d5a"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="sum"
              hidden="true"
              key="shop_entropy"
              label="공평판매"
              placeholder="Enter value"
              position="center"
              size={61}
            />
            <Column
              id="ab04f"
              alignment="center"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="average"
              hidden="{{ !var_item_list.value[listView_main.item][0].sale_per_3m }}"
              key="sale_per_3m"
              label="3M"
              placeholder="Enter value"
              position="center"
              size={48}
              summaryAggregationMode="none"
              textColor="{{color_grad(item)}}"
              valueOverride="{{ currentSourceRow.sty_nm !== '소계' ? item : null }}"
            />
            <Column
              id="23a50"
              alignment="center"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="average"
              hidden="{{ !var_item_list.value[listView_main.item][0].sale_per_6m }}"
              key="sale_per_6m"
              label="6M"
              placeholder="Enter value"
              position="center"
              size={54}
              summaryAggregationMode="none"
              textColor="{{color_grad(item)}}"
              valueOverride="{{ currentSourceRow.sty_nm !== '소계' ? item : null }}"
            />
            <Column
              id="25597"
              alignment="center"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="average"
              hidden="{{ !var_item_list.value[listView_main.item][0].sale_per_12m }}"
              key="sale_per_12m"
              label="12M"
              placeholder="Enter value"
              position="center"
              size={48}
              summaryAggregationMode="none"
              textColor="{{color_grad(item)}}"
              valueOverride="{{ currentSourceRow.sty_nm !== '소계' ? item : null }}"
            />
            <Column
              id="f2b32"
              alignment="center"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="average"
              hidden="{{ !var_item_list.value[listView_main.item][0].sale_per_18m }}"
              key="sale_per_18m"
              label="18M"
              placeholder="Enter value"
              position="center"
              size={48}
              summaryAggregationMode="none"
              textColor="{{color_grad(item)}}"
              valueOverride="{{ currentSourceRow.sty_nm !== '소계' ? item : null }}"
            />
            <Column
              id="6a98e"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="average"
              hidden="{{ !var_item_list.value[listView_main.item][0].sale_per_24M }}"
              key="sale_per_24M"
              label="24M"
              placeholder="Enter value"
              position="center"
              size={100}
              summaryAggregationMode="none"
              textColor="{{color_grad(item)}}"
              valueOverride="{{ currentSourceRow.sty_nm !== '소계' ? item : null }}"
            />
            <Column
              id="91638"
              alignment="center"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="average"
              hidden="{{ !var_item_list.value[listView_main.item][0].sale_per_2y }}"
              key="sale_per_2y"
              label="2Y"
              placeholder="Enter value"
              position="center"
              size={51}
              summaryAggregationMode="none"
              textColor="{{color_grad(item)}}"
              valueOverride="{{ currentSourceRow.sty_nm !== '소계' ? item : null }}"
            />
            <Column
              id="7b740"
              alignment="center"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="average"
              hidden="{{ !var_item_list.value[listView_main.item][0].sale_per_3y }}"
              key="sale_per_3y"
              label="3Y"
              placeholder="Enter value"
              position="center"
              size={53}
              summaryAggregationMode="none"
              textColor="{{color_grad(item)}}"
              valueOverride="{{ currentSourceRow.sty_nm !== '소계' ? item : null }}"
            />
            <Column
              id="a6f95"
              alignment="center"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="average"
              hidden="{{ !var_item_list.value[listView_main.item][0].sale_per_4y }}"
              key="sale_per_4y"
              label="4Y"
              placeholder="Enter value"
              position="center"
              size={53}
              summaryAggregationMode="none"
              textColor="{{color_grad(item)}}"
              valueOverride="{{ currentSourceRow.sty_nm !== '소계' ? item : null }}"
            />
            <Column
              id="aa4c7"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="average"
              hidden="{{ !var_item_list.value[listView_main.item][0].sale_per_01 }}"
              key="sale_per_01"
              label="01"
              placeholder="Enter value"
              position="center"
              size={100}
              summaryAggregationMode="none"
              textColor="{{color_grad(item)}}"
              valueOverride="{{ currentSourceRow.sty_nm !== '소계' ? item : null }}"
            />
            <Column
              id="af184"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="average"
              hidden="{{ !var_item_list.value[listView_main.item][0].sale_per_60 }}"
              key="sale_per_03"
              label="03"
              placeholder="Enter value"
              position="center"
              size={100}
              summaryAggregationMode="none"
              textColor="{{color_grad(item)}}"
              valueOverride="{{ currentSourceRow.sty_nm !== '소계' ? item : null }}"
            />
            <Column
              id="1c3c8"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="average"
              hidden="{{ !var_item_list.value[listView_main.item][0].sale_per_newborn }}"
              key="sale_per_newborn"
              label="신생아"
              placeholder="Enter value"
              position="center"
              size={100}
              summaryAggregationMode="none"
              textColor="{{color_grad(item)}}"
              valueOverride="{{ currentSourceRow.sty_nm !== '소계' ? item : null }}"
            />
            <Column
              id="77106"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="average"
              hidden="{{ !var_item_list.value[listView_main.item][0].sale_per_free }}"
              key="sale_per_free"
              label="free"
              placeholder="Enter value"
              position="center"
              size={100}
              summaryAggregationMode="none"
              textColor="{{color_grad(item)}}"
              valueOverride="{{ currentSourceRow.sty_nm !== '소계' ? item : null }}"
            />
            <Column
              id="8661e"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="average"
              hidden="{{ !var_item_list.value[listView_main.item][0].sale_per_mini }}"
              key="sale_per_mini"
              label="미니처네"
              placeholder="Enter value"
              position="center"
              size={100}
              summaryAggregationMode="none"
              textColor="{{color_grad(item)}}"
              valueOverride="{{ currentSourceRow.sty_nm !== '소계' ? item : null }}"
            />
            <Column
              id="13fa7"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="average"
              hidden="{{ !var_item_list.value[listView_main.item][0].sale_per_general }}"
              key="sale_per_general"
              label="일반"
              placeholder="Enter value"
              position="center"
              size={100}
              summaryAggregationMode="none"
              textColor="{{color_grad(item)}}"
              valueOverride="{{ currentSourceRow.sty_nm !== '소계' ? item : null }}"
            />
            <Column
              id="5ae2b"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="average"
              hidden="{{ !var_item_list.value[listView_main.item][0].sale_per_seven }}"
              key="sale_per_seven"
              label="7부처네"
              placeholder="Enter value"
              position="center"
              size={100}
              summaryAggregationMode="none"
              textColor="{{color_grad(item)}}"
              valueOverride="{{ currentSourceRow.sty_nm !== '소계' ? item : null }}"
            />
            <Column
              id="40f19"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="average"
              hidden="{{ !var_item_list.value[listView_main.item][var_item_list.value[listView_main.item]?.length-1].sale_per_60 }}"
              key="sale_per_60"
              label="60"
              placeholder="Enter value"
              position="center"
              referenceId="60"
              size={100}
              summaryAggregationMode="none"
              textColor="{{color_grad(item)}}"
              valueOverride="{{ currentSourceRow.sty_nm !== '소계' ? item : null }}"
            />
            <Column
              id="c7c30"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="average"
              hidden="{{ !var_item_list.value[listView_main.item][0].sale_per_65 }}"
              key="sale_per_65"
              label="65"
              placeholder="Enter value"
              position="center"
              size={100}
              summaryAggregationMode="none"
              textColor="{{color_grad(item)}}"
              valueOverride="{{ currentSourceRow.sty_nm !== '소계' ? item : null }}"
            />
            <Column
              id="d8563"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="average"
              hidden="{{ !var_item_list.value[listView_main.item][0].sale_per_70 }}"
              key="sale_per_70"
              label="70"
              placeholder="Enter value"
              position="center"
              size={100}
              summaryAggregationMode="none"
              textColor="{{color_grad(item)}}"
              valueOverride="{{ currentSourceRow.sty_nm !== '소계' ? item : null }}"
            />
            <Column
              id="5ca3d"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="average"
              hidden="{{ !var_item_list.value[listView_main.item][0].sale_per_75 }}"
              key="sale_per_75"
              label="75"
              placeholder="Enter value"
              position="center"
              size={100}
              summaryAggregationMode="none"
              textColor="{{color_grad(item)}}"
              valueOverride="{{ currentSourceRow.sty_nm !== '소계' ? item : null }}"
            />
            <Column
              id="0618c"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="average"
              hidden="{{ !var_item_list.value[listView_main.item][0].sale_per_80 }}"
              key="sale_per_80"
              label="80"
              placeholder="Enter value"
              position="center"
              size={100}
              summaryAggregationMode="none"
              textColor="{{color_grad(item)}}"
              valueOverride="{{ currentSourceRow.sty_nm !== '소계' ? item : null }}"
            />
            <Column
              id="c9c34"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="average"
              hidden="{{ !var_item_list.value[listView_main.item][0].sale_per_85 }}"
              key="sale_per_85"
              label="85"
              placeholder="Enter value"
              position="center"
              size={100}
              summaryAggregationMode="none"
              textColor="{{color_grad(item)}}"
              valueOverride="{{ currentSourceRow.sty_nm !== '소계' ? item : null }}"
            />
            <Column
              id="0ba92"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="average"
              hidden="{{ !var_item_list.value[listView_main.item][0].sale_per_90 }}"
              key="sale_per_90"
              label="90"
              placeholder="Enter value"
              position="center"
              size={100}
              summaryAggregationMode="none"
              textColor="{{color_grad(item)}}"
              valueOverride="{{ currentSourceRow.sty_nm !== '소계' ? item : null }}"
            />
            <Column
              id="bd0bc"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="average"
              hidden="{{ !var_item_list.value[listView_main.item][0].sale_per_95 }}"
              key="sale_per_95"
              label="95"
              placeholder="Enter value"
              position="center"
              size={100}
              summaryAggregationMode="none"
              textColor="{{color_grad(item)}}"
              valueOverride="{{ currentSourceRow.sty_nm !== '소계' ? item : null }}"
            />
            <Column
              id="b04c0"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="average"
              hidden="{{ !var_item_list.value[listView_main.item][0].sale_per_100 }}"
              key="sale_per_100"
              label="100"
              placeholder="Enter value"
              position="center"
              size={100}
              summaryAggregationMode="none"
              textColor="{{color_grad(item)}}"
              valueOverride="{{ currentSourceRow.sty_nm !== '소계' ? item : null }}"
            />
            <Column
              id="7e4fa"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="average"
              hidden="{{ !var_item_list.value[listView_main.item][0].sale_per_110 }}"
              key="sale_per_110"
              label="110"
              placeholder="Enter value"
              position="center"
              size={100}
              summaryAggregationMode="none"
              textColor="{{color_grad(item)}}"
              valueOverride="{{ currentSourceRow.sty_nm !== '소계' ? item : null }}"
            />
            <Column
              id="ea6d9"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="average"
              hidden="{{ !var_item_list.value[listView_main.item][0].sale_per_115 }}"
              key="sale_per_115"
              label="115"
              placeholder="Enter value"
              position="center"
              size={100}
              summaryAggregationMode="none"
              textColor="{{color_grad(item)}}"
              valueOverride="{{ currentSourceRow.sty_nm !== '소계' ? item : null }}"
            />
            <Column
              id="9511f"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="average"
              hidden="{{ !var_item_list.value[listView_main.item][0].sale_per_120 }}"
              key="sale_per_120"
              label="120"
              placeholder="Enter value"
              position="center"
              size={100}
              summaryAggregationMode="none"
              textColor="{{color_grad(item)}}"
              valueOverride="{{ currentSourceRow.sty_nm !== '소계' ? item : null }}"
            />
            <Column
              id="6a554"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="average"
              hidden="{{ !var_item_list.value[listView_main.item][0].sale_per_125 }}"
              key="sale_per_125"
              label="125"
              placeholder="Enter value"
              position="center"
              size={100}
              summaryAggregationMode="none"
              textColor="{{color_grad(item)}}"
              valueOverride="{{ currentSourceRow.sty_nm !== '소계' ? item : null }}"
            />
            <Column
              id="4a4a5"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="average"
              hidden="{{ !var_item_list.value[listView_main.item][0].sale_per_130 }}"
              key="sale_per_130"
              label="130"
              placeholder="Enter value"
              position="center"
              size={100}
              summaryAggregationMode="none"
              textColor="{{color_grad(item)}}"
              valueOverride="{{ currentSourceRow.sty_nm !== '소계' ? item : null }}"
            />
            <Column
              id="b5eea"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="average"
              hidden="{{ !var_item_list.value[listView_main.item][0].sale_per_135 }}"
              key="sale_per_135"
              label="135"
              placeholder="Enter value"
              position="center"
              size={100}
              summaryAggregationMode="none"
              textColor="{{color_grad(item)}}"
              valueOverride="{{ currentSourceRow.sty_nm !== '소계' ? item : null }}"
            />
            <Column
              id="4100f"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="average"
              hidden="{{ !var_item_list.value[listView_main.item][0].sale_per_140 }}"
              key="sale_per_140"
              label="140"
              placeholder="Enter value"
              position="center"
              size={100}
              summaryAggregationMode="none"
              textColor="{{color_grad(item)}}"
              valueOverride="{{ currentSourceRow.sty_nm !== '소계' ? item : null }}"
            />
            <Column
              id="13288"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="average"
              hidden="{{ !var_item_list.value[listView_main.item][0].sale_per_145 }}"
              key="sale_per_145"
              label="145"
              placeholder="Enter value"
              position="center"
              size={100}
              summaryAggregationMode="none"
              textColor="{{color_grad(item)}}"
              valueOverride="{{ currentSourceRow.sty_nm !== '소계' ? item : null }}"
            />
            <Column
              id="8e1bd"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="average"
              hidden="{{ !var_item_list.value[listView_main.item][0].sale_per_150 }}"
              key="sale_per_150"
              label="150"
              placeholder="Enter value"
              position="center"
              size={100}
              summaryAggregationMode="none"
              textColor="{{color_grad(item)}}"
              valueOverride="{{ currentSourceRow.sty_nm !== '소계' ? item : null }}"
            />
            <Column
              id="59d9d"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="average"
              hidden="{{ !var_item_list.value[listView_main.item][0].sale_per_155 }}"
              key="sale_per_155"
              label="155"
              placeholder="Enter value"
              position="center"
              size={100}
              summaryAggregationMode="none"
              textColor="{{color_grad(item)}}"
              valueOverride="{{ currentSourceRow.sty_nm !== '소계' ? item : null }}"
            />
            <Column
              id="c0814"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="average"
              hidden="{{ !var_item_list.value[listView_main.item][0].sale_per_160 }}"
              key="sale_per_160"
              label="160"
              placeholder="Enter value"
              position="center"
              size={100}
              summaryAggregationMode="none"
              textColor="{{color_grad(item)}}"
              valueOverride="{{ currentSourceRow.sty_nm !== '소계' ? item : null }}"
            />
            <Column
              id="079b6"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="average"
              hidden="{{ !var_item_list.value[listView_main.item][0].sale_per_170 }}"
              key="sale_per_170"
              label="170"
              placeholder="Enter value"
              position="center"
              size={100}
              summaryAggregationMode="none"
              textColor="{{color_grad(item)}}"
              valueOverride="{{ currentSourceRow.sty_nm !== '소계' ? item : null }}"
            />
            <Column
              id="3ac66"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="average"
              hidden="{{ !var_item_list.value[listView_main.item][0].sale_per_7_8 }}"
              key="sale_per_7_8"
              label="7-8"
              placeholder="Enter value"
              position="center"
              size={100}
              summaryAggregationMode="none"
              textColor="{{color_grad(item)}}"
              valueOverride="{{ currentSourceRow.sty_nm !== '소계' ? item : null }}"
            />
            <Column
              id="2ef2a"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="average"
              hidden="{{ !var_item_list.value[listView_main.item][0].sale_per_9_10 }}"
              key="sale_per_9_10"
              label="9-10"
              placeholder="Enter value"
              position="center"
              size={100}
              summaryAggregationMode="none"
              textColor="{{color_grad(item)}}"
              valueOverride="{{ currentSourceRow.sty_nm !== '소계' ? item : null }}"
            />
            <Column
              id="bf86f"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="average"
              hidden="{{ !var_item_list.value[listView_main.item][0].sale_per_11_12 }}"
              key="sale_per_11_12"
              label="11-12"
              placeholder="Enter value"
              position="center"
              size={100}
              summaryAggregationMode="none"
              textColor="{{color_grad(item)}}"
              valueOverride="{{ currentSourceRow.sty_nm !== '소계' ? item : null }}"
            />
            <Column
              id="5d272"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="average"
              hidden="{{ !var_item_list.value[listView_main.item][0].sale_per_13_14 }}"
              key="sale_per_13_14"
              label="13-14"
              placeholder="Enter value"
              position="center"
              size={100}
              summaryAggregationMode="none"
              textColor="{{color_grad(item)}}"
              valueOverride="{{ currentSourceRow.sty_nm !== '소계' ? item : null }}"
            />
            <Column
              id="2bb18"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="average"
              hidden="{{ !var_item_list.value[listView_main.item][0].sale_per_15_16 }}"
              key="sale_per_15_16"
              label="15-16"
              placeholder="Enter value"
              position="center"
              size={100}
              summaryAggregationMode="none"
              textColor="{{color_grad(item)}}"
              valueOverride="{{ currentSourceRow.sty_nm !== '소계' ? item : null }}"
            />
            <Column
              id="a3c80"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="average"
              hidden="{{ !var_item_list.value[listView_main.item][0].sale_per_17_18 }}"
              key="sale_per_17_18"
              label="17-18"
              placeholder="Enter value"
              position="center"
              size={100}
              summaryAggregationMode="none"
              textColor="{{color_grad(item)}}"
              valueOverride="{{ currentSourceRow.sty_nm !== '소계' ? item : null }}"
            />
            <Column
              id="ef272"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="average"
              hidden="{{ !var_item_list.value[listView_main.item][0].sale_per_83X83 }}"
              key="sale_per_83X83"
              label="83X83"
              placeholder="Enter value"
              position="center"
              size={100}
              summaryAggregationMode="none"
              textColor="{{color_grad(item)}}"
              valueOverride="{{ currentSourceRow.sty_nm !== '소계' ? item : null }}"
            />
            <Column
              id="b3b1f"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="average"
              hidden="{{ !var_item_list.value[listView_main.item][0].sale_per_85X85 }}"
              key="sale_per_85X85"
              label="85X85"
              placeholder="Enter value"
              position="center"
              size={100}
              summaryAggregationMode="none"
              textColor="{{color_grad(item)}}"
              valueOverride="{{ currentSourceRow.sty_nm !== '소계' ? item : null }}"
            />
            <Column
              id="8cc2f"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{ showSeparators: false, notation: "standard" }}
              groupAggregationMode="average"
              hidden="{{ !var_item_list.value[listView_main.item][0].sale_per_95X95 }}"
              key="sale_per_95X95"
              label="95X95"
              placeholder="Enter value"
              position="center"
              size={100}
              summaryAggregationMode="none"
              textColor="{{color_grad(item)}}"
              valueOverride="{{ currentSourceRow.sty_nm !== '소계' ? item : null }}"
            />
            <Column
              id="83220"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="average"
              hidden="{{ !var_item_list.value[listView_main.item][0].sale_per_100X120 }}"
              key="sale_per_100X120"
              label="100X120"
              placeholder="Enter value"
              position="center"
              size={100}
              summaryAggregationMode="none"
              textColor="{{color_grad(item)}}"
              valueOverride="{{ currentSourceRow.sty_nm !== '소계' ? item : null }}"
            />
            <Column
              id="74673"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="average"
              hidden="{{ !var_item_list.value[listView_main.item][0].sale_per_100X130 }}"
              key="sale_per_100X130"
              label="100X130"
              placeholder="Enter value"
              position="center"
              size={100}
              summaryAggregationMode="none"
              textColor="{{color_grad(item)}}"
              valueOverride="{{ currentSourceRow.sty_nm !== '소계' ? item : null }}"
            />
            <Column
              id="5f3c3"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="average"
              hidden="{{ !var_item_list.value[listView_main.item][0].sale_per_105X135 }}"
              key="sale_per_105X135"
              label="105X135"
              placeholder="Enter value"
              position="center"
              size={100}
              summaryAggregationMode="none"
              textColor="{{color_grad(item)}}"
              valueOverride="{{ currentSourceRow.sty_nm !== '소계' ? item : null }}"
            />
            <Column
              id="ebf17"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="average"
              hidden="{{ !var_item_list.value[listView_main.item][0].sale_per_115X145 }}"
              key="sale_per_115X145"
              label="115X145"
              placeholder="Enter value"
              position="center"
              size={100}
              summaryAggregationMode="none"
              textColor="{{color_grad(item)}}"
              valueOverride="{{ currentSourceRow.sty_nm !== '소계' ? item : null }}"
            />
            <Column
              id="2e7fd"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="average"
              hidden="{{ !var_item_list.value[listView_main.item][0].sale_per_40 }}"
              key="sale_per_40"
              label="40"
              placeholder="Enter value"
              position="center"
              size={100}
              summaryAggregationMode="none"
              textColor="{{color_grad(item)}}"
              valueOverride="{{ currentSourceRow.sty_nm !== '소계' ? item : null }}"
            />
            <Column
              id="8c5a1"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="average"
              hidden="{{ !var_item_list.value[listView_main.item][0].sale_per_42 }}"
              key="sale_per_42"
              label="42"
              placeholder="Enter value"
              position="center"
              size={50}
              summaryAggregationMode="none"
              textColor="{{color_grad(item)}}"
              valueOverride="{{ currentSourceRow.sty_nm !== '소계' ? item : null }}"
            />
            <Column
              id="7fdea"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="average"
              hidden="{{ !var_item_list.value[listView_main.item][var_item_list.value[listView_main.item]?.length-1].sale_per_44 }}"
              key="sale_per_44"
              label="44"
              placeholder="Enter value"
              position="center"
              size={100}
              summaryAggregationMode="none"
              textColor="{{color_grad(item)}}"
              valueOverride="{{ currentSourceRow.sty_nm !== '소계' ? item : null }}"
            />
            <Column
              id="6ec73"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="average"
              hidden="{{ !var_item_list.value[listView_main.item][0].sale_per_46 }}"
              key="sale_per_46"
              label="46"
              placeholder="Enter value"
              position="center"
              size={100}
              summaryAggregationMode="none"
              textColor="{{color_grad(item)}}"
              valueOverride="{{ currentSourceRow.sty_nm !== '소계' ? item : null }}"
            />
            <Column
              id="943b4"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="average"
              hidden="{{ !var_item_list.value[listView_main.item][0].sale_per_48 }}"
              key="sale_per_48"
              label="48"
              placeholder="Enter value"
              position="center"
              size={100}
              summaryAggregationMode="none"
              textColor="{{color_grad(item)}}"
              valueOverride="{{ currentSourceRow.sty_nm !== '소계' ? item : null }}"
            />
            <Column
              id="dbf3a"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="average"
              hidden="{{ !var_item_list.value[listView_main.item][0].sale_per_50 }}"
              key="sale_per_50"
              label="50"
              placeholder="Enter value"
              position="center"
              size={100}
              summaryAggregationMode="none"
              textColor="{{color_grad(item)}}"
              valueOverride="{{ currentSourceRow.sty_nm !== '소계' ? item : null }}"
            />
            <Column
              id="14364"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="average"
              hidden="{{ !var_item_list.value[listView_main.item][0].sale_per_52 }}"
              key="sale_per_52"
              label="52"
              placeholder="Enter value"
              position="center"
              size={100}
              summaryAggregationMode="none"
              textColor="{{color_grad(item)}}"
              valueOverride="{{ currentSourceRow.sty_nm !== '소계' ? item : null }}"
            />
            <Column
              id="0ab84"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="average"
              hidden="{{ !var_item_list.value[listView_main.item][0].sale_per_54 }}"
              key="sale_per_54"
              label="54"
              placeholder="Enter value"
              position="center"
              size={100}
              summaryAggregationMode="none"
              textColor="{{color_grad(item)}}"
              valueOverride="{{ currentSourceRow.sty_nm !== '소계' ? item : null }}"
            />
            <Column
              id="766b9"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="average"
              hidden="{{ !var_item_list.value[listView_main.item][0].sale_per_S }}"
              key="sale_per_S"
              label="S"
              placeholder="Enter value"
              position="center"
              size={100}
              summaryAggregationMode="none"
              textColor="{{color_grad(item)}}"
              valueOverride="{{ currentSourceRow.sty_nm !== '소계' ? item : null }}"
            />
            <Column
              id="850fd"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="average"
              hidden="{{ !var_item_list.value[listView_main.item][0].sale_per_M }}"
              key="sale_per_M"
              label="M"
              placeholder="Enter value"
              position="center"
              size={100}
              summaryAggregationMode="none"
              textColor="{{color_grad(item)}}"
              valueOverride="{{ currentSourceRow.sty_nm !== '소계' ? item : null }}"
            />
            <Column
              id="1ce3c"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="average"
              hidden="{{ !var_item_list.value[listView_main.item][0].sale_per_L }}"
              key="sale_per_L"
              label="L"
              placeholder="Enter value"
              position="center"
              size={100}
              summaryAggregationMode="none"
              textColor="{{color_grad(item)}}"
              valueOverride="{{ currentSourceRow.sty_nm !== '소계' ? item : null }}"
            />
            <Column
              id="de533"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="average"
              hidden="{{ !var_item_list.value[listView_main.item][0].sale_per_XL }}"
              key="sale_per_XL"
              label="XL"
              placeholder="Enter value"
              position="center"
              size={100}
              summaryAggregationMode="none"
              textColor="{{color_grad(item)}}"
              valueOverride="{{ currentSourceRow.sty_nm !== '소계' ? item : null }}"
            />
            <Column
              id="03dab"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="currency"
              formatOptions={{
                currency: "krw",
                currencySign: "standard",
                notation: "standard",
                showSeparators: true,
                currencyDisplay: "symbol",
              }}
              groupAggregationMode="sum"
              key="tag_prce"
              label="TAG가"
              placeholder="Enter value"
              position="center"
              referenceId="price_retail"
              size={76.796875}
            />
            <Column
              id="e2efd"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="sum"
              key="tot_in_tag_amt"
              label="입고금액(천원)"
              placeholder="Enter value"
              position="center"
              referenceId="amount_received"
              size={105.140625}
              valueOverride="{{item/1000}}"
            />
            <Column
              id="493c8"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="sum"
              key="tot_sale_tag"
              label="판매금액(천원)"
              placeholder="Enter value"
              position="center"
              referenceId="amount_sold"
              size={107.140625}
              valueOverride="{{item/1000}}"
            />
            <Column
              id="68f0b"
              alignment="center"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="average"
              key="sale_tag_per"
              label="판매율 (금액)"
              placeholder="Enter value"
              position="center"
              referenceId="ratio_sold_by_amount"
              size={102.625}
            />
            <Column
              id="a02ff"
              alignment="center"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="average"
              key="sale_return_per"
              label="회수율"
              placeholder="Enter value"
              position="center"
              referenceId="ratio_return_on_funds"
              size={73.4375}
            />
            <Column
              id="2880e"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="sum"
              hidden="true"
              key="tot_in_cost_amt"
              label="Tot in cost amt"
              placeholder="Enter value"
              position="center"
              size={97.953125}
            />
            <Column
              id="c5e12"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="sum"
              hidden="true"
              key="tot_sale_amt"
              label="Tot sale amt"
              placeholder="Enter value"
              position="center"
              size={83.5625}
            />
            <Column
              id="7b332"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="sum"
              hidden="true"
              key="col_cd"
              label="Col cd"
              placeholder="Enter value"
              position="center"
              size={100}
            />
            <Column
              id="53af8"
              alignment="right"
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              groupAggregationMode="sum"
              hidden="true"
              key="tot_inventory_qty"
              label="Tot inventory qty"
              placeholder="Enter value"
              position="center"
              size={100}
              summaryAggregationMode="none"
            />
            <Column
              id="372e3"
              alignment="left"
              format="string"
              groupAggregationMode="none"
              hidden="true"
              key="bg_color"
              label="Bg color"
              placeholder="Enter value"
              position="center"
              size={100}
              summaryAggregationMode="none"
            />
            <ToolbarButton
              id="da74c"
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
                              "{{ select_season.selectedLabel }} 판매현황 ",
                          },
                          { includeHiddenColumns: false },
                        ],
                      },
                    },
                  ],
                }}
                pluginId="table_item_list"
                type="widget"
                waitMs="0"
                waitType="debounce"
              />
            </ToolbarButton>
            <Event
              event="selectRow"
              method="show"
              params={{ ordered: [] }}
              pluginId="drawerFrame_item_detail_new"
              type="widget"
              waitMs="0"
              waitType="debounce"
            />
            <Event
              event="clickRow"
              method="setValue"
              params={{
                ordered: [{ value: "{{ table_item_list.selectedSourceRow }}" }],
              }}
              pluginId="var_item_info"
              type="state"
              waitMs="0"
              waitType="debounce"
            />
          </Table>
        </View>
      </Container>
    </ListViewBeta>
  </Frame>
</App>
