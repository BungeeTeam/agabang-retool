<DrawerFrame
  id="drawerFrame_item_detail"
  footerPadding="8px 12px"
  headerPadding="8px 12px"
  hidden={true}
  hideOnEscape={true}
  isHiddenOnMobile={true}
  overlayInteraction={true}
  padding="8px 12px"
  showHeader={true}
  showHeaderBorder={false}
  showOverlay={true}
  width="large"
>
  <Header>
    <Text
      id="text3"
      value="#### {{var_sel_sty_info.value.sty_nm}} {{var_sel_sty_info.value.col_nm}} ( {{var_sel_sty_info.value.sty_cd}}{{var_sel_sty_info.value.col_cd}} )"
      verticalAlign="center"
    />
    <Button
      id="button1"
      disabled="{{download_images_zip.isFetching}}"
      loading="{{download_images_zip.isFetching}}"
      text="이미지 전체 다운로드"
    >
      <Event
        event="click"
        method="trigger"
        params={{
          ordered: [
            {
              options: {
                object: {
                  onSuccess: null,
                  onFailure: null,
                  additionalScope: null,
                },
              },
            },
          ],
        }}
        pluginId="download_images_zip"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </Button>
  </Header>
  <Body>
    <Image
      id="image1"
      horizontalAlign="center"
      retoolFileObject=""
      src="https://agabang-image.s3.ap-northeast-2.amazonaws.com/item_final/{{var_sel_sty_info.value.sty_cd}}{{var_sel_sty_info.value.col_cd}}.jpg"
      style={{ ordered: [{ borderColor: "rgba(217, 221, 225, 1)" }] }}
    >
      <Event
        event="click"
        method="openUrl"
        params={{
          ordered: [{ url: "{{table_item_list.selectedRow.item_image}}" }],
        }}
        pluginId=""
        type="util"
        waitMs="0"
        waitType="debounce"
      />
    </Image>
    <Container
      id="container2"
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      heightType="fixed"
      padding="12px"
      showBody={true}
      showBorder={false}
    >
      <Header>
        <Text
          id="containerTitle4"
          value="#### Container title"
          verticalAlign="center"
        />
      </Header>
      <View id="bf65f" viewKey="View 1">
        <ImageGrid
          id="imageGrid1"
          aspectRatio={1}
          columnCount="3"
          columnMinWidth={100}
          data="{{get_image_list.data}}"
          srcByIndex="{{item.url}}"
          style={{ ordered: [{ borderColor: "rgb(217, 221, 225)" }] }}
        >
          <Event
            enabled=""
            event="click"
            method="openUrl"
            params={{ ordered: [{ url: "{{item.url}}" }] }}
            pluginId=""
            type="util"
            waitMs="0"
            waitType="debounce"
          />
        </ImageGrid>
      </View>
    </Container>
    <Spacer id="spacer3" />
    <Divider
      id="divider4"
      horizontalAlign="left"
      style={{
        ordered: [
          { fontSize: "h6Font" },
          { fontWeight: "700" },
          { lineHeight: "1.14em" },
          { fontFamily: "Pretendard Variable" },
        ],
      }}
      text="📝 재고/ 판매정보"
      textSize="h6"
    />
    <Spacer id="spacer2" />
    <KeyValue
      id="keyValue_item_inventory"
      data=""
      enableSaveActions={true}
      groupLayout="singleColumn"
      labelWrap={true}
    >
      <Property
        id="qty_order"
        editable="false"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        hidden="false"
        label="주문량"
        valueOverride="{{ get_item_detail.data.plan_qty }}"
      >
        <Event
          event="clickValue"
          method="trigger"
          params={{ ordered: [] }}
          pluginId="get_category_list_new"
          type="datasource"
          waitMs="0"
          waitType="debounce"
        />
      </Property>
      <Property
        id="qty_receive"
        editable="false"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        hidden="false"
        label="입고량"
        valueOverride="{{ get_item_detail.data.tot_in_qty }}"
      />
      <Property
        id="qty_sold"
        editable="false"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        hidden="false"
        label="판매량"
        valueOverride="{{ get_item_detail.data.tot_sale_qty }}"
      />
      <Property
        id="ratio_sold"
        editable="false"
        editableOptions={{}}
        format="percent"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        hidden="false"
        label="판매율"
        valueOverride="{{ get_item_detail.data.sale_per }}"
      />
      <Property
        id="qty_sold_last_week"
        editable="false"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        hidden="false"
        label="주간판매량"
        valueOverride="{{ get_item_detail.data.int_sale_qty }}"
      />
    </KeyValue>
    <Container
      id="container1"
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      padding="0"
      showBody={true}
    >
      <Header>
        <Text
          id="containerTitle3"
          value="#### Container title"
          verticalAlign="center"
        />
      </Header>
      <View id="18f70" viewKey="View 1">
        <PlotlyChart
          id="chart1"
          chartType="line"
          data={include("../lib/chart1.data.json", "string")}
          datasourceDataType="object"
          datasourceInputMode="javascript"
          datasourceJS="{{season_item_list.data}}"
          isDataTemplateDirty={true}
          isJsonTemplateDirty={true}
          isLayoutJsonDirty={true}
          layout={include("../lib/chart1.layout.json", "string")}
          margin="4px 8px"
          skipDatasourceUpdate={true}
          xAxis="{{season_item_list.data.style_no}}"
          xAxisDropdown="style_no"
        />
      </View>
    </Container>
    <Spacer id="spacer7" />
    <Text id="text2" value="**사이즈별 입고/판매량**" verticalAlign="center" />
    <Spacer id="spacer10" />
    <Table
      id="table1"
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ get_item_size_detail.data }}"
      defaultSelectedRow={{ mode: "none", indexType: "display", index: 0 }}
      emptyMessage="No rows found"
      enableSaveActions={true}
      heightType="auto"
      rowHeight="xsmall"
      showBorder={true}
      showHeader={true}
      toolbarPosition="bottom"
    >
      <Column
        id="23ce9"
        alignment="center"
        format="string"
        groupAggregationMode="none"
        key="size_nm"
        label="사이즈"
        placeholder="Enter value"
        position="center"
        size={77}
      />
      <Column
        id="8770d"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="tot_in_qty"
        label="입고수량"
        placeholder="Enter value"
        position="center"
        size={117}
      />
      <Column
        id="ac026"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="tot_sale_qty"
        label="판매수량"
        placeholder="Enter value"
        position="center"
        size={129}
      />
      <Column
        id="7e695"
        alignment="center"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="average"
        key="sale_per"
        label="판매율"
        placeholder="Enter value"
        position="center"
        size={100}
        textColor="{{ color_grad(item)}}"
      />
    </Table>
    <Spacer id="spacer9" />
    <Container
      id="container3"
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
      <View id="bf65f" viewKey="View 1">
        <Text
          id="text4"
          horizontalAlign="center"
          value="**입고비중**"
          verticalAlign="center"
        />
        <PlotlyChart
          id="chart2"
          chartType="pie"
          dataseries={{
            ordered: [
              {
                0: {
                  ordered: [
                    { label: "tot_in_qty" },
                    {
                      datasource: "{{get_item_size_detail.data['tot_in_qty']}}",
                    },
                    { chartType: "pie" },
                    { aggregationType: "sum" },
                    { color: null },
                    { colors: { ordered: [{ 0: "#1E3A8A" }] } },
                    { visible: true },
                    {
                      hovertemplate:
                        "<b>%{x}</b><br>%{fullData.name}: %{y}<extra></extra>",
                    },
                  ],
                },
              },
              {
                1: {
                  ordered: [
                    { label: "tot_sale_qty" },
                    {
                      datasource:
                        "{{get_item_size_detail.data['tot_sale_qty']}}",
                    },
                    { chartType: "pie" },
                    { aggregationType: "sum" },
                    { color: null },
                    { colors: { ordered: [{ 0: "#1E3A8A" }] } },
                    { visible: false },
                    {
                      hovertemplate:
                        "<b>%{x}</b><br>%{fullData.name}: %{y}<extra></extra>",
                    },
                  ],
                },
              },
              {
                2: {
                  ordered: [
                    { label: "sale_per" },
                    { datasource: "{{get_item_size_detail.data['sale_per']}}" },
                    { chartType: "pie" },
                    { aggregationType: "sum" },
                    { color: null },
                    { colors: { ordered: [{ 0: "#1E3A8A" }] } },
                    { visible: false },
                    {
                      hovertemplate:
                        "<b>%{x}</b><br>%{fullData.name}: %{y}<extra></extra>",
                    },
                  ],
                },
              },
            ],
          }}
          datasourceDataType="object"
          datasourceInputMode="javascript"
          datasourceJS="{{get_item_size_detail.data}}"
          isDataTemplateDirty={true}
          isLayoutJsonDirty={true}
          layout={include("../lib/chart2.layout.json", "string")}
          legendAlignment="left"
          margin="0"
          skipDatasourceUpdate={true}
          xAxis="{{get_item_size_detail.data['size_nm']}}"
          xAxisDropdown="size_nm"
        />
      </View>
    </Container>
    <Container
      id="container4"
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      padding="12px"
      showBody={true}
    >
      <Header>
        <Text
          id="containerTitle6"
          value="#### Container title"
          verticalAlign="center"
        />
      </Header>
      <View id="bf65f" viewKey="View 1">
        <Text
          id="text5"
          horizontalAlign="center"
          value="**판매비중**"
          verticalAlign="center"
        />
        <PlotlyChart
          id="chart3"
          chartType="pie"
          dataseries={{
            ordered: [
              {
                0: {
                  ordered: [
                    { label: "tot_in_qty" },
                    {
                      datasource: "{{get_item_size_detail.data['tot_in_qty']}}",
                    },
                    { chartType: "pie" },
                    { aggregationType: "sum" },
                    { color: null },
                    { colors: { ordered: [{ 0: "#1E3A8A" }] } },
                    { visible: false },
                    {
                      hovertemplate:
                        "<b>%{x}</b><br>%{fullData.name}: %{y}<extra></extra>",
                    },
                  ],
                },
              },
              {
                1: {
                  ordered: [
                    { label: "tot_sale_qty" },
                    {
                      datasource:
                        "{{get_item_size_detail.data['tot_sale_qty']}}",
                    },
                    { chartType: "pie" },
                    { aggregationType: "sum" },
                    { color: null },
                    { colors: { ordered: [{ 0: "#1E3A8A" }] } },
                    { visible: true },
                    {
                      hovertemplate:
                        "<b>%{x}</b><br>%{fullData.name}: %{y}<extra></extra>",
                    },
                  ],
                },
              },
              {
                2: {
                  ordered: [
                    { label: "sale_per" },
                    { datasource: "{{get_item_size_detail.data['sale_per']}}" },
                    { chartType: "pie" },
                    { aggregationType: "sum" },
                    { color: null },
                    { colors: { ordered: [{ 0: "#1E3A8A" }] } },
                    { visible: false },
                    {
                      hovertemplate:
                        "<b>%{x}</b><br>%{fullData.name}: %{y}<extra></extra>",
                    },
                  ],
                },
              },
            ],
          }}
          datasourceDataType="object"
          datasourceInputMode="javascript"
          datasourceJS="{{get_item_size_detail.data}}"
          isDataTemplateDirty={true}
          isLayoutJsonDirty={true}
          layout={include("../lib/chart3.layout.json", "string")}
          legendAlignment="left"
          margin="0"
          skipDatasourceUpdate={true}
          xAxis="{{get_item_size_detail.data['size_nm']}}"
          xAxisDropdown="size_nm"
        />
      </View>
    </Container>
    <Spacer id="spacer6" />
    <Divider
      id="divider2"
      horizontalAlign="left"
      style={{
        ordered: [
          { fontSize: "h6Font" },
          { fontWeight: "700" },
          { lineHeight: "1.14em" },
        ],
      }}
      text="📝 세부정보"
      textSize="h6"
    />
    <Spacer id="spacer1" />
    <KeyValue
      id="keyValue_item_info"
      data={
        "{\n  material: \"-\",\n  color: '-',\n  designer: '-',\n  manufacturer: '-',\n  manufacturer_location: '-'\n}"
      }
      editIcon="bold/interface-edit-pencil"
      enableSaveActions={true}
      groupLayout="singleColumn"
      labelWrap={true}
    >
      <Property
        id="material"
        editable="false"
        editableOptions={{}}
        format="string"
        formatOptions={{}}
        hidden="false"
        label="소재"
        valueOverride="{{ get_item_detail.data.fabric[0] }}"
      />
      <Property
        id="color"
        editable="false"
        editableOptions={{}}
        format="string"
        formatOptions={{}}
        hidden="false"
        label="컬러"
        valueOverride="{{ get_item_detail.data.col_nm[0] }}"
      />
      <Property
        id="designer"
        editable="false"
        editableOptions={{}}
        format="string"
        formatOptions={{}}
        hidden="false"
        label="디자이너"
        valueOverride="{{ get_item_detail.data.designer_nm[0] }}"
      />
      <Property
        id="manufacturer"
        editable="false"
        editableOptions={{}}
        format="string"
        formatOptions={{}}
        hidden="false"
        label="생산처"
        valueOverride="{{ get_item_detail.data.prod_comp[0] }}"
      />
      <Property
        id="manufacturer_location"
        editable="false"
        editableOptions={{}}
        format="string"
        formatOptions={{}}
        hidden="false"
        label="생산국가"
        valueOverride="{{ get_item_detail.data.prod_country[0] }}"
      />
    </KeyValue>
    <KeyValue
      id="keyValue_item_date_logistics"
      data={
        '{\n  date_first_release: "",\n  date_first_receive: "",\n  date_order_placed: ""\n}'
      }
      editIcon="bold/interface-edit-pencil"
      enableSaveActions={true}
      groupLayout="singleColumn"
      labelWrap={true}
    >
      <Property
        id="date_first_release"
        editable="false"
        editableOptions={{}}
        format="date"
        formatOptions={{ dateFormat: "yyyy/MM/dd" }}
        hidden="false"
        label="최초 출고"
        valueOverride="{{ get_item_detail.data.fout_date[0] }}"
      />
      <Property
        id="date_first_receive"
        editable="false"
        editableOptions={{}}
        format="date"
        formatOptions={{ dateFormat: "yyyy/MM/dd" }}
        hidden="false"
        label="최초 입고"
        valueOverride="{{ get_item_detail.data.fin_date[0] }}"
      />
      <Property
        id="date_order_placed"
        editable="false"
        editableOptions={{}}
        format="date"
        formatOptions={{ dateFormat: "yyyy/MM/dd" }}
        hidden="false"
        label="발주일"
        valueOverride="{{ get_item_detail.data.plan_date[0] }}"
      />
    </KeyValue>
    <Spacer id="spacer4" />
    <Divider
      id="divider3"
      horizontalAlign="left"
      style={{
        ordered: [
          { fontSize: "h6Font" },
          { fontWeight: "700" },
          { lineHeight: "1.14em" },
        ],
      }}
      text="💰가격정보 / 판매금액"
      textSize="h6"
    />
    <Spacer id="spacer5" />
    <KeyValue
      id="keyValue_item_price"
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
          currency: "krw",
          currencySign: "standard",
          notation: "standard",
          showSeparators: true,
          currencyDisplay: "symbol",
        }}
        hidden="false"
        label="TAG가"
        valueOverride="{{ get_item_detail.data.tag_prce[0] }}"
      />
      <Property
        id="price_retail_current"
        editable="false"
        editableOptions={{ showStepper: true }}
        format="currency"
        formatOptions={{
          currency: "krw",
          currencySign: "standard",
          notation: "standard",
          showSeparators: true,
          currencyDisplay: "symbol",
        }}
        hidden="false"
        label="현판가"
        valueOverride="{{ get_item_detail.data.real_prce[0] }}"
      />
      <Property
        id="price_purchase"
        editable="false"
        editableOptions={{ showStepper: true }}
        format="currency"
        formatOptions={{
          currency: "krw",
          currencySign: "standard",
          notation: "standard",
          showSeparators: true,
          currencyDisplay: "symbol",
        }}
        hidden="false"
        label="구입가(-)"
        valueOverride="{{ get_item_detail.data.cost_prce[0] }}"
      />
      <Property
        id="markup"
        editable="false"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "2",
          padDecimal: true,
        }}
        hidden="false"
        label="Markup"
        valueOverride="{{ get_item_detail.data.markup[0] }}"
      />
    </KeyValue>
    <KeyValue
      id="keyValue_item_cost"
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
          currency: "krw",
          currencySign: "standard",
          notation: "standard",
          showSeparators: true,
          currencyDisplay: "symbol",
        }}
        hidden="false"
        label="입고금액(TAG)"
        valueOverride="{{ get_item_detail.data.tot_in_tag_amt[0] }}"
      />
      <Property
        id="amount_sales"
        editable="false"
        editableOptions={{ showStepper: true }}
        format="currency"
        formatOptions={{
          currency: "krw",
          currencySign: "standard",
          notation: "standard",
          showSeparators: true,
          currencyDisplay: "symbol",
        }}
        hidden="false"
        label="실판매금액"
        valueOverride="{{ get_item_detail.data.tot_sale_amt[0] }}"
      />
      <Property
        id="ratio_amount_sales"
        editable="false"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        hidden="false"
        label="실판매율(금액)"
        valueOverride="{{ get_item_detail.data.sale_amt_per[0] }}"
      />
      <Property
        id="ratio_return_on_funds"
        editable="false"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        hidden="false"
        label="회수율"
        valueOverride="{{ get_item_detail.data.sale_return_per[0] }}"
      />
    </KeyValue>
    <Spacer id="spacer11" />
  </Body>
  <Event
    event="hide"
    method="clearSelection"
    params={{ ordered: [] }}
    pluginId="table_item_list"
    type="widget"
    waitMs="0"
    waitType="debounce"
  />
</DrawerFrame>
