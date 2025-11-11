<Container
  id="container_item"
  footerPadding="4px 12px"
  headerPadding="4px 12px"
  margin="0"
  padding="12px"
  showBody={true}
  style={{ ordered: [{ borderRadius: "0px" }] }}
>
  <View id="f2762" viewKey="View 1">
    <Text
      id="containerTitle17"
      heightType="fixed"
      margin="0"
      value="###### {{ item.sty_nm}} ( {{ item.sty_cd }} )"
      verticalAlign="center"
    />
    <Text
      id="text22"
      heightType="fixed"
      hidden={'{{item.sty_cd == ""}}'}
      horizontalAlign="right"
      value="{{item.year_sesn_nm_kor}} / {{item.cat_nm}} / {{item.item_nm}}"
      verticalAlign="center"
    />
    <Text
      id="text13"
      horizontalAlign="center"
      style={{
        ordered: [
          { color: "info" },
          {
            background:
              "{{ [JSON.parse(retoolContext.configVars.var_color_dict)[item.col_nm]] }}",
          },
        ],
      }}
      value="{{ item.col_nm }}"
      verticalAlign="center"
    />
    <TagsWidget2
      id="tags3"
      allowWrap={true}
      colorByIndex={'{{ item > 60 ? "orange": "#eeeeee" }}'}
      data="[{{ Math.round(((item.gini - 0.3) / (0.7 - 0.3))*100) }}]"
      style={{ ordered: [] }}
      tooltipByIndex="일부 매장 편중 점수
높을수록 매장 편중 높음"
      values="편중 {{ item }}"
    >
      <Event
        event="click"
        method="setValue"
        params={{ ordered: [{ value: "{{ gridView_items.data[i] }}" }] }}
        pluginId="var_item_info"
        type="state"
        waitMs="0"
        waitType="debounce"
      />
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
        method="setValue"
        params={{ ordered: [{ value: "sales" }] }}
        pluginId="shop_modal_tab"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </TagsWidget2>
    <Button
      id="button5"
      iconBefore="bold/interface-delete-bin-2"
      style={{ ordered: [{ background: "canvas" }] }}
      text="제외"
    >
      <Event
        event="click"
        method="setValue"
        params={{ ordered: [{ value: "{{ item.sty_cd }}{{ item.col_cd }}" }] }}
        pluginId="var_delete_item"
        type="state"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        event="click"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="delete_item"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </Button>
    <TagsWidget2
      id="tags2"
      allowWrap={true}
      colorByIndex={'{{ item > 70 ? "orange": "#eeeeee" }}'}
      data="[{{ (item.online_sale_per*100).toFixed(0) }}]"
      tooltipByIndex="온라인 판매비율"
      values="온 {{ item }}%"
    >
      <Event
        event="click"
        method="setValue"
        params={{ ordered: [{ value: "{{ gridView_items.data[i] }}" }] }}
        pluginId="var_item_info"
        type="state"
        waitMs="0"
        waitType="debounce"
      />
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
        method="setValue"
        params={{ ordered: [{ value: "online" }] }}
        pluginId="shop_modal_tab"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </TagsWidget2>
    <Text
      id="text20"
      hidden={'{{item.sty_cd == ""}}'}
      horizontalAlign="right"
      value={'{{ moment(item.deli_dt).format("M/D")}}'}
      verticalAlign="center"
    />
    <Text
      id="text21"
      heightType="fixed"
      hidden={'{{item.sty_cd == ""}}'}
      horizontalAlign="right"
      style={{ ordered: [{ color: "primary" }] }}
      value={'**{{ moment(item.fin_date).format("M/D")}}**'}
      verticalAlign="center"
    />
    <Text
      id="text17"
      heightType="fixed"
      hidden={'{{item.sty_cd == ""}}'}
      margin="0"
      style={{ ordered: [{ color: "rgba(13, 13, 13, 0.7)" }] }}
      value="회수율 : {{ Math.round((item.tot_sale_amt/(item.tot_in_qty*item.cost_prce)*100),0)}}%"
      verticalAlign="center"
    />
    <Text
      id="text8"
      style={{ ordered: [{ color: "info" }] }}
      value="{{ item.preview_score.toFixed(2) }}"
      verticalAlign="center"
    />
    <Divider id="divider5" margin="0" textSize="default" />
    <KeyValue
      id="keyValue_item_detail_info"
      data="{
  'TAG가': {{item.tag_prce}},
  '현판가': {{item.f_sale_prce}},
  '구입가': {{item.cost_prce}},
  'M/UP': {{item.mark_up}},
  '최초출고': {{item.fout_date}},
  '발주량': {{item.plan_qty}},
  '입고량': {{item.tot_in_qty}},
  '판매량': {{item.tot_sale_qty}},
  '주간판매수량': {{ item.week_sale_qty }},
  '판매율(수량)': {{item.tot_sale_qty_per}},
  '입고금액(TAG)': {{item.tot_in_tag_amt}},
  '실판매금액': {{item.tot_sale_amt}},
  '실판매율(금액)': {{item.tot_sale_amt_per}},
  '디자이너': {{item.designer_nm}},
  '소재': {{item.fabric}}
}"
      editIcon="bold/interface-edit-pencil"
      enableSaveActions={true}
      groupLayout="wrap"
      heightType="fixed"
      hidden={'{{item.sty_cd == ""}}'}
      itemLabelPosition="top"
      labelWrap={true}
    >
      <Property
        id="TAG가"
        editable="false"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        hidden="false"
        label="Tag가"
      />
      <Property
        id="현판가"
        editable="false"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        hidden="false"
        label="현판가"
      />
      <Property
        id="구입가"
        editable="false"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        hidden="false"
        label="구입가(-)"
      />
      <Property
        id="M/UP"
        editable="false"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        hidden="false"
        label="M/UP"
        valueOverride="{{ item.toFixed(1) }}"
      />
      <Property
        id="최초출고"
        editable="false"
        editableOptions={{}}
        format="string"
        formatOptions={{}}
        hidden="false"
        label="최초출고"
        valueOverride="{{ moment(item).format('MM/DD') }}"
      />
      <Property
        id="발주량"
        editable="false"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        hidden="false"
        label="발주량"
      />
      <Property
        id="입고량"
        editable="false"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        hidden="false"
        label="입고량"
      />
      <Property
        id="판매량"
        editable="false"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        hidden="false"
        label="판매량"
      />
      <Property
        id="주간판매수량"
        editable="false"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        hidden="false"
        label="판매량(주간)"
      />
      <Property
        id="판매율(수량)"
        editable="false"
        editableOptions={{ showStepper: true }}
        format="string"
        formatOptions={{}}
        hidden="false"
        label="판매율(수량)"
        valueOverride="{{item.toFixed(1)}}%"
      />
      <Property
        id="입고금액(TAG)"
        editable="false"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        hidden="false"
        label="입고금액(TAG)"
      />
      <Property
        id="실판매금액"
        editable="false"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        hidden="false"
        label="실판매금액"
      />
      <Property
        id="실판매율(금액)"
        editable="false"
        editableOptions={{ showStepper: true }}
        format="string"
        formatOptions={{}}
        hidden="false"
        label="실판매율(금액)"
        valueOverride="{{item.toFixed(1)}}%"
      />
      <Property
        id="디자이너"
        editable="false"
        editableOptions={{}}
        format="string"
        formatOptions={{}}
        hidden="false"
        label="디자이너"
      />
      <Property
        id="소재"
        editable="false"
        editableOptions={{}}
        format="string"
        formatOptions={{}}
        hidden="false"
        label="소재"
      />
    </KeyValue>
    <Image
      id="image3"
      fit="contain"
      heightType="fixed"
      horizontalAlign="center"
      margin="0"
      src="https://agabang-image.s3.ap-northeast-2.amazonaws.com/item_final/{{ item.sty_cd }}{{ item.col_cd }}.jpg"
    />
    <KeyValue
      id="keyValue2"
      data={
        '{\n  "판매율": "{{ item.tot_sale_qty_per }}%" ,\n  "최초출고": "{{ moment(item.fin_date).format("M/D") }}",\n  "날짜": "{{ moment(item.over_first_dt).format("M/D") }}",\n  "경과일": "{{ Math.ceil(Math.abs(new Date(item.over_first_dt) - new Date(item.fin_date)) / (1000 * 60 * 60 * 24)) }}일"\n}'
      }
      editIcon="bold/interface-edit-pencil"
      enableSaveActions={true}
      groupLayout="wrap"
      heightType="fixed"
      itemLabelPosition="top"
      labelWrap={true}
    >
      <Property
        id="판매율"
        editable="false"
        editableOptions={{}}
        format="string"
        formatOptions={{}}
        hidden="false"
        label="판매율"
      />
      <Property
        id="최초출고"
        editable="false"
        editableOptions={{}}
        format="string"
        formatOptions={{}}
        hidden="false"
        label="최초출고"
      />
      <Property
        id="날짜"
        editable="false"
        editableOptions={{}}
        format="string"
        formatOptions={{}}
        hidden="false"
        label="{{ sale_per.value*100 }}%날짜"
      />
    </KeyValue>
    <Table
      id="table_stock_by_assort2"
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ item.table_data }}"
      defaultSelectedRow={{ mode: "index", indexType: "display", index: "4" }}
      dynamicColumnProperties={{
        formatByIndex: "string",
        labelByIndex: "{{item}}",
      }}
      emptyMessage="No rows found"
      hidden={'{{item.sty_cd == ""}}'}
      margin="0"
      rowHeight="xsmall"
      style={{}}
      toolbarPosition="bottom"
    >
      <Column
        id="8851d"
        alignment="left"
        editable={false}
        format="string"
        groupAggregationMode="none"
        key="SIZE"
        label="Size"
        placeholder="Enter value"
        position="center"
        size={84.015625}
        summaryAggregationMode="none"
      />
      <Column
        id="80fa5"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="string"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="average"
        key="col_1"
        label="Col 1"
        placeholder="Enter value"
        position="center"
        size={60}
        summaryAggregationMode="none"
      />
      <Column
        id="734d8"
        alignment="right"
        format="string"
        groupAggregationMode="none"
        key="col_2"
        label="Col 2"
        placeholder="Enter value"
        position="center"
        size={56}
        summaryAggregationMode="none"
      />
      <Column
        id="f3434"
        alignment="right"
        format="string"
        groupAggregationMode="none"
        key="col_3"
        label="Col 3"
        placeholder="Enter value"
        position="center"
        size={53}
        summaryAggregationMode="none"
      />
      <Column
        id="fc3f5"
        alignment="right"
        format="string"
        groupAggregationMode="none"
        key="col_4"
        label="Col 4"
        placeholder="Enter value"
        position="center"
        size={53}
        summaryAggregationMode="none"
      />
      <Column
        id="9ec94"
        alignment="right"
        format="string"
        groupAggregationMode="none"
        key="col_5"
        label="Col 5"
        placeholder="Enter value"
        position="center"
        size={51}
        summaryAggregationMode="none"
      />
      <Column
        id="c935f"
        alignment="center"
        format="string"
        groupAggregationMode="none"
        key="col_6"
        label="Col 6"
        placeholder="Enter value"
        position="center"
        size={41}
        summaryAggregationMode="none"
      />
    </Table>
  </View>
  <Event
    event="click"
    method="setValue"
    params={{ ordered: [{ value: "{{item}}" }] }}
    pluginId="var_sel_sty_info"
    type="state"
    waitMs="0"
    waitType="debounce"
  />
  <Event
    event="click"
    method="trigger"
    params={{
      ordered: [
        {
          options: {
            object: { onSuccess: null, onFailure: null, additionalScope: null },
          },
        },
      ],
    }}
    pluginId="get_item_detail"
    type="datasource"
    waitMs="0"
    waitType="debounce"
  />
  <Event
    event="click"
    method="show"
    params={{ ordered: [] }}
    pluginId="drawerFrame_item_detail"
    type="widget"
    waitMs="0"
    waitType="debounce"
  />
  <Event
    event="click"
    method="trigger"
    params={{ ordered: [] }}
    pluginId="get_image_list"
    type="datasource"
    waitMs="0"
    waitType="debounce"
  />
</Container>
