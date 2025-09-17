<Container
  id="container4"
  footerPadding="4px 12px"
  headerPadding="4px 12px"
  margin="0"
  padding="12px"
  showBody={true}
  showBorder={false}
>
  <View id="846fc" viewKey="View 1">
    <Text
      id="containerTitle4"
      value="##### {{sel_sty.value.sty_nm}} {{sel_sty.value.col_nm}} ({{sel_sty.value.sty_cd}}{{sel_sty.value.col_cd}})"
      verticalAlign="center"
    />
    <Button id="button1" disabled="" text="사진 업데이트">
      <Event
        event="click"
        method="show"
        params={{ ordered: [] }}
        pluginId="modalFrame1"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        event="click"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="get_brand_and_season"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </Button>
    <Text
      id="containerTitle8"
      value={
        '- MD 엑셀 분류: {{get_item_detail.data.large_cat[0] || "(미입력)"}} > {{get_item_detail.data.middle_cat[0] || "(미입력)"}} > {{get_item_detail.data.small_cat[0] || "(미입력)"}} \n- ERP 분류: {{get_item_detail.data.it_nm[0] || "(미입력)"}} > {{get_item_detail.data.it_gb_nm[0] || "(미입력)"}} > {{get_item_detail.data.item_nm[0] || "(미입력)"}} {{ get_item_detail.data.item[0] ? ` (복종코드: ${get_item_detail.data.item[0]})` : \'\' }}'
      }
      verticalAlign="center"
    />
    <Divider id="divider5" />
    <Image
      id="image1"
      heightType="fixed"
      horizontalAlign="center"
      src="{{ sel_sty.value && sel_sty.value.col_cd ? 
      `https://agabang-image.s3.ap-northeast-2.amazonaws.com/item_final/${sel_sty.value.sty_cd}${sel_sty.value.col_cd}.jpg` : 
      `https://agabang-image.s3.ap-northeast-2.amazonaws.com/item_final/${sel_sty.value.sty_cd}.jpg`
}}"
    >
      <Event
        event="click"
        method="openUrl"
        params={{
          ordered: [
            {
              url: "{{ sel_sty.value && sel_sty.value.col_cd ? \n      `https://agabang-image.s3.ap-northeast-2.amazonaws.com/item_final/${sel_sty.value.sty_cd}${sel_sty.value.col_cd}.jpg` : \n      `https://agabang-image.s3.ap-northeast-2.amazonaws.com/item_final/${sel_sty.value.sty_cd}.jpg`\n}}",
            },
          ],
        }}
        pluginId=""
        type="util"
        waitMs="0"
        waitType="debounce"
      />
    </Image>
    <Container
      id="container1"
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      heightType="fixed"
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
      <View id="cdf66" viewKey="View 1">
        <ImageGrid
          id="imageGrid1"
          aspectRatio={1}
          columnCount={3}
          columnMinWidth={100}
          data="{{ get_image_list.data }}"
          srcByIndex="{{ item.url }}"
        />
      </View>
    </Container>
    <Spacer id="spacer1" />
    <Divider
      id="divider1"
      horizontalAlign="left"
      style={{
        ordered: [
          { fontSize: "h6Font" },
          { fontWeight: "700" },
          { fontFamily: "Pretendard Variable" },
        ],
      }}
      text="📝 재고/판매정보"
    />
    <Spacer id="spacer2" />
    <Chart
      id="plotlyJsonChart1"
      chartType="plotlyJson"
      plotlyDataJson={
        '[\n  {\n    "name": "평균 판매량",\n    "x": {{get_daily_sales_by_style.data.sale_dt.map(item => moment(item).format())}},\n    "y": {{get_daily_sales_by_style.data[\'avg_sale_qty\']}},\n    "type": "line",\n    "type": "line",\n    "transforms": [\n      {\n        "type": "sort",\n        "target": {{get_daily_sales_by_style.data.sale_dt.map(item => moment(item).format())}},\n        "order": "ascending"\n      }\n    ],\n    "marker": {\n      "color": "#B4B4B4"\n    },\n    "line": {\n      "dash": "dot",\n    },\n    "mode": "lines"\n  },\n  {\n    "name": "누적 판매량",\n    "x": {{(get_daily_sales_by_style.data).sale_dt.map(item => moment(item).format())}},\n    "y": {{(get_daily_sales_by_style.data)[\'sale_cumsum\']}},\n    "type": "line",\n    "hovertemplate": {{(get_daily_sales_by_style.data)[\'sale_cumsum\']}},\n    "transforms": [\n      {\n        "type": "sort",\n        "target": {{(get_daily_sales_by_style.data).sale_dt.map(item => moment(item).format())}},\n        "order": "ascending"\n      },\n      {\n        "type": "aggregate",\n        "groups": {{(get_daily_sales_by_style.data).sale_dt.map(item => moment(item).format())}},\n        "aggregations": [\n          {\n            "target": "y",\n            "func": "sum",\n            "enabled": true\n          }\n        ]\n      }\n    ],\n    "marker": {\n      "color": "#1E3A8A"\n    },\n    "mode": "lines"\n  },\n  {\n    "name": "누적 입고량",\n    "x": {{(get_daily_sales_by_style.data).sale_dt.map(item => moment(item).format())}},\n    "y": {{(get_daily_sales_by_style.data)[\'in_cumsum\']}},\n    "type": "line",\n    "line": {\n      "shape": \'vh\',\n    },\n    "transforms": [\n      {\n        "type": "sort",\n        "target": {{(get_daily_sales_by_style.data).sale_dt.map(item => moment(item).format())}},\n        "order": "ascending"\n      }\n    ],\n    "marker": {\n      "color": "#60A5FA"\n    },\n    "mode": "lines"\n  }\n]'
      }
      plotlyLayoutJson={
        '{\n  "title": {\n    "text": "",\n    "font": {\n      "color": "#3D3D3D",\n      "size": 16\n    }\n  },\n  "font": {\n    "family": "var(--default-font, var(--sans-serif))",\n    "color": "#979797"\n  },\n  "showlegend": true,\n  "legend": {\n    "xanchor": "center",\n    "x": 0.45,\n    "y": -0.2,\n    "orientation": "h"\n  },\n  "margin": {\n    "l": 10,\n    "r": 20,\n    "t": 15,\n    "b": 0,\n    "pad": 0\n  },\n  "hovermode": "closest",\n  "hoverlabel": {\n    "bgcolor": "#000",\n    "bordercolor": "#000",\n    "font": {\n      "color": "#fff",\n      "family": "var(--default-font, var(--sans-serif))",\n      "size": 12\n    }\n  },\n  "clickmode": "select+event",\n  "dragmode": "select",\n  "xaxis": {\n    "title": {\n      "text": "",\n      "standoff": 6,\n      "font": {\n        "size": 12\n      }\n    },\n    "type": "-",\n    "tickformat": "",\n    "automargin": true,\n    "fixedrange": true,\n    "gridcolor": "#fff",\n    "zerolinecolor": "#fff"\n  },\n  "yaxis": {\n    "title": {\n      "text": "",\n      "standoff": 6,\n      "font": {\n        "size": 12\n      }\n    },\n    "type": "linear",\n    "tickformat": "",\n    "automargin": true,\n    "fixedrange": true,\n    "zerolinecolor": "#DEDEDE"\n  }\n}'
      }
      selectedPoints="[]"
    />
    <KeyValue
      id="keyValue1"
      data="{
  발주량: {{get_item_detail.data.plan_qty}} ,
  입고량: {{get_item_detail.data.tot_in_qty}} ,
  판매량: {{get_item_detail.data.tot_sale_qty}} ,
  판매율: {{get_item_detail.data.sale_per}} ,
  주간판매량: {{get_item_detail.data.int_sale_qty}} ,
}"
      editIcon="bold/interface-edit-pencil"
      enableSaveActions={true}
      groupLayout="singleColumn"
      labelWrap={true}
    >
      <Property
        id="발주량"
        editable="false"
        editableOptions={{}}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        hidden="false"
        label="발주량"
      />
      <Property
        id="입고량"
        editable="false"
        editableOptions={{}}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        hidden="false"
        label="입고량"
      />
      <Property
        id="판매량"
        editable="false"
        editableOptions={{}}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        hidden="false"
        label="판매량"
      />
      <Property
        id="판매율"
        editable="false"
        editableOptions={{}}
        format="percent"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        hidden="false"
        label="판매율"
      />
      <Property
        id="주간판매량"
        editable="false"
        editableOptions={{}}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        hidden="false"
        label="주간판매량"
      />
    </KeyValue>
    <Button
      id="button6"
      iconBefore="bold/nature-ecology-barn"
      text="매장 판매 보기"
    >
      <Event
        event="click"
        method="show"
        params={{ ordered: [] }}
        pluginId="shop_sales"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        event="click"
        method="setCurrentView"
        params={{ ordered: [{ viewKey: "sales" }] }}
        pluginId="tabbedContainer1"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        event="click"
        method="clearSelection"
        params={{ ordered: [] }}
        pluginId="shop_sales_table"
        type="widget"
        waitMs="10"
        waitType="debounce"
      />
      <Event
        event="click"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="get_shop_sales"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </Button>
    <Spacer id="spacer3" />
    <Text id="text1" value="**사이즈별 입고/판매량**" verticalAlign="center" />
    <Spacer id="spacer4" />
    <Table
      id="table1"
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ get_item_size_detail.data }}"
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      defaultSort={[{ object: { columnId: "649ff", direction: "asc" } }]}
      emptyMessage="No rows found"
      enableSaveActions={true}
      heightType="auto"
      rowHeight="xsmall"
      showBorder={true}
      showHeader={true}
      toolbarPosition="bottom"
    >
      <Column
        id="649ff"
        alignment="center"
        editableOptions={{ showStepper: true }}
        format="string"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="size_nm"
        label="사이즈"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="21a4f"
        alignment="center"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="tot_in_qty"
        label="입고수량"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="a9a81"
        alignment="center"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="tot_sale_qty"
        label="판매수량"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="4da3c"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="average"
        key="sale_per"
        label="판매율"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
    </Table>
    <Spacer id="spacer5" />
    <Container
      id="container2"
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      padding="12px"
      showBody={true}
    >
      <Header>
        <Text
          id="containerTitle2"
          value="#### Container title"
          verticalAlign="center"
        />
      </Header>
      <View id="cdf66" viewKey="View 1">
        <Text
          id="text2"
          horizontalAlign="center"
          value="**입고비중**"
          verticalAlign="center"
        />
        <Chart
          id="pieChart1"
          chartType="pie"
          colorArray={[
            "#11B5AE",
            "#4046CA",
            "#F68512",
            "#DE3C82",
            "#7E84FA",
            "#72E06A",
          ]}
          colorArrayDropDown={[
            "#11B5AE",
            "#4046CA",
            "#F68512",
            "#DE3C82",
            "#7E84FA",
            "#72E06A",
          ]}
          colorInputMode="colorArrayDropDown"
          datasource="{{ get_item_size_detail.data }}"
          datasourceMode="source"
          gradientColorArray={[
            ["0.0", "{{ theme.canvas }}"],
            ["1.0", "{{ theme.primary }}"],
          ]}
          hoverTemplate={null}
          hoverTemplateMode="source"
          labelData="{{ get_item_size_detail.data.size_nm }}"
          labelDataMode="source"
          legendPosition="left"
          lineColor="{{ theme.surfacePrimary }}"
          lineWidth={2}
          pieDataHole="0"
          selectedPoints="[]"
          textTemplate="%{percent}"
          textTemplateMode="source"
          textTemplatePosition="auto"
          title={null}
          valueData="{{ get_item_size_detail.data.tot_in_qty }}"
          valueDataMode="source"
        />
      </View>
    </Container>
    <Container
      id="container5"
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
      <View id="cdf66" viewKey="View 1">
        <Text
          id="text3"
          horizontalAlign="center"
          value="**판매비중**"
          verticalAlign="center"
        />
        <Chart
          id="pieChart2"
          chartType="pie"
          colorArray={[
            "#11B5AE",
            "#4046CA",
            "#F68512",
            "#DE3C82",
            "#7E84FA",
            "#72E06A",
          ]}
          colorArrayDropDown={[
            "#11B5AE",
            "#4046CA",
            "#F68512",
            "#DE3C82",
            "#7E84FA",
            "#72E06A",
          ]}
          colorInputMode="colorArrayDropDown"
          datasource="{{ get_item_size_detail.data }}"
          datasourceMode="source"
          gradientColorArray={[
            ["0.0", "{{ theme.canvas }}"],
            ["1.0", "{{ theme.primary }}"],
          ]}
          hoverTemplate={null}
          hoverTemplateMode="source"
          labelData="{{ get_item_size_detail.data.size_nm }}"
          labelDataMode="source"
          legendPosition="left"
          lineColor="{{ theme.surfacePrimary }}"
          lineWidth={2}
          pieDataHole="0"
          selectedPoints="[]"
          textTemplate="%{percent}"
          textTemplateMode="source"
          textTemplatePosition="auto"
          title={null}
          valueData="{{ get_item_size_detail.data.tot_sale_qty }}"
          valueDataMode="source"
        />
      </View>
    </Container>
    <Spacer id="spacer6" />
    <Divider
      id="divider3"
      horizontalAlign="left"
      style={{
        ordered: [
          { fontSize: "h6Font" },
          { fontWeight: "700" },
          { fontFamily: "Pretendard Variable" },
        ],
      }}
      text="📝 세부정보"
    />
    <Spacer id="spacer7" />
    <KeyValue
      id="keyValue2"
      data={
        '{\n  소재: "-",\n  컬러: "-",\n  디자이너: "-",\n  생산처: "-",\n  생산국가: "-",\n}'
      }
      editIcon="bold/interface-edit-pencil"
      enableSaveActions={true}
      groupLayout="singleColumn"
      labelWrap={true}
    >
      <Property
        id="소재"
        editable="false"
        editableOptions={{}}
        format="string"
        formatOptions={{}}
        hidden="false"
        label="소재"
        valueOverride="{{ get_item_detail.data.fabric[0]}}"
      />
      <Property
        id="컬러"
        editable="false"
        editableOptions={{}}
        format="string"
        formatOptions={{}}
        hidden="false"
        label="컬러"
        valueOverride="{{ get_item_detail.data.col_nm[0]}}"
      />
      <Property
        id="디자이너"
        editable="false"
        editableOptions={{}}
        format="string"
        formatOptions={{}}
        hidden="false"
        label="디자이너"
        valueOverride="{{ get_item_detail.data.designer_nm[0]}}"
      />
      <Property
        id="생산국가"
        editable="false"
        editableOptions={{}}
        format="string"
        formatOptions={{}}
        hidden="false"
        label="생산국가"
        valueOverride="{{ get_item_detail.data.prod_comp[0] }}"
      />
      <Property
        id="생산처"
        editable="false"
        editableOptions={{}}
        format="string"
        formatOptions={{}}
        hidden="false"
        label="생산처"
        placeholder="-"
        valueOverride="{{ get_item_detail.data.prod_country[0] }}"
      />
    </KeyValue>
    <KeyValue
      id="keyValue3"
      data={'{\n  최초출고: "",\n  최초입고: "",\n  발주일: ""\n}'}
      editIcon="bold/interface-edit-pencil"
      enableSaveActions={true}
      groupLayout="singleColumn"
      heightType="fixed"
      labelWrap={true}
    >
      <Property
        id="최초출고"
        editable="false"
        editableOptions={{}}
        format="date"
        formatOptions={{ dateFormat: "yyyy/MM/dd" }}
        hidden="false"
        label="최초 출고"
        valueOverride="{{ get_item_detail.data.fout_date[0]}}"
      />
      <Property
        id="최초입고"
        editable="false"
        editableOptions={{}}
        format="date"
        formatOptions={{ dateFormat: "yyyy/MM/dd" }}
        hidden="false"
        label="최초 입고"
        valueOverride="{{ get_item_detail.data.fin_date[0] }}"
      />
      <Property
        id="발주일"
        editable="false"
        editableOptions={{}}
        format="date"
        formatOptions={{ dateFormat: "yyyy/MM/dd" }}
        hidden="false"
        label="발주일"
        valueOverride="{{ get_item_detail.data.plan_date[0] }}"
      />
    </KeyValue>
    <Spacer id="spacer8" />
    <Divider
      id="divider4"
      horizontalAlign="left"
      style={{
        ordered: [
          { fontSize: "14px" },
          { fontWeight: "700" },
          { fontFamily: "Inter" },
        ],
      }}
      text="💰가격정보 / 판매금액"
    />
    <Spacer id="spacer9" />
    <KeyValue
      id="keyValue4"
      data="{
  price_retail: 0,
  price_retail_current: 0,
  price_purchase: 0,
  markup: 0.0
}"
      editIcon="bold/interface-edit-pencil"
      enableSaveActions={true}
      groupLayout="singleColumn"
      labelWrap={true}
    >
      <Property
        id="price_retail"
        editable="false"
        editableOptions={{ showStepper: true }}
        format="currency"
        formatOptions={{
          currency: "KRW",
          currencySign: "standard",
          notation: "standard",
          showSeparators: true,
          currencyDisplay: "symbol",
        }}
        hidden="false"
        label="TAG가"
        valueOverride="{{ get_item_detail.data.tag_prce }}"
      />
      <Property
        id="price_retail_current"
        editable="false"
        editableOptions={{ showStepper: true }}
        format="currency"
        formatOptions={{
          currency: "KRW",
          currencySign: "standard",
          notation: "standard",
          showSeparators: true,
          currencyDisplay: "symbol",
        }}
        hidden="false"
        label="현판가"
        valueOverride="{{ get_item_detail.data.real_prce }}"
      />
      <Property
        id="price_purchase"
        editable="false"
        editableOptions={{ showStepper: true }}
        format="currency"
        formatOptions={{
          currency: "KRW",
          currencySign: "standard",
          notation: "standard",
          showSeparators: true,
          currencyDisplay: "symbol",
        }}
        hidden="false"
        label="구입가(-)"
        valueOverride="{{ get_item_detail.data.cost_prce }}"
      />
      <Property
        id="markup"
        editable="false"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        hidden="false"
        label="배수"
        valueOverride="{{ get_item_detail.data.markup }}"
      />
    </KeyValue>
    <KeyValue
      id="keyValue5"
      data="{
  stock_value_received: 0,
  amount_sales: 0,
  ratio_amount_sales: 0.0,
  ratio_return_on_funds: 0.0
}"
      editIcon="bold/interface-edit-pencil"
      enableSaveActions={true}
      groupLayout="singleColumn"
      labelWrap={true}
    >
      <Property
        id="stock_value_received"
        editable="false"
        editableOptions={{ showStepper: true }}
        format="currency"
        formatOptions={{
          currency: "KRW",
          currencySign: "standard",
          notation: "standard",
          showSeparators: true,
          currencyDisplay: "symbol",
        }}
        hidden="false"
        label="입고금액(TAG)"
        valueOverride="{{ get_item_detail.data.tot_in_tag_amt }}"
      >
        <Event
          event="clickValue"
          method="trigger"
          params={{ ordered: [] }}
          pluginId="get_item_detail"
          type="datasource"
          waitMs="0"
          waitType="debounce"
        />
      </Property>
      <Property
        id="amount_sales"
        editable="false"
        editableOptions={{ showStepper: true }}
        format="currency"
        formatOptions={{
          currency: "KRW",
          currencySign: "standard",
          notation: "standard",
          showSeparators: true,
          currencyDisplay: "symbol",
        }}
        hidden="false"
        label="실판매금액"
        valueOverride="{{ get_item_detail.data.tot_sale_amt }}"
      />
      <Property
        id="ratio_amount_sales"
        editable="false"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        hidden="false"
        label="실판매율(금액)"
        valueOverride="{{ get_item_detail.data.sale_amt_per}}"
      />
      <Property
        id="ratio_return_on_funds"
        editable="false"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        hidden="false"
        label="회수율"
        valueOverride="{{ get_item_detail.data.sale_return_per }}"
      />
    </KeyValue>
    <Spacer id="spacer10" />
  </View>
</Container>
