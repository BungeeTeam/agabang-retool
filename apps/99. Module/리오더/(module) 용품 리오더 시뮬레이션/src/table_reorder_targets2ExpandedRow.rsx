<ExpandedRow id="table_reorder_targets2ExpandedRow">
  <Table
    id="table13"
    cellSelection="none"
    clearChangesetOnSave={true}
    data="{{ get_item_list.data.filter(item => 
   item.sty_cd === currentSourceRow.sty_cd && 
   item.col_cd === currentSourceRow.col_cd) }}"
    defaultSelectedRow={{ mode: "none", indexType: "display", index: 0 }}
    defaultSort={[]}
    emptyMessage="No rows found"
    groupedColumnConfig={{ expandByDefault: false, size: 200 }}
    heightType="auto"
    margin="0"
    rowBackgroundColor=""
    rowHeight="large"
    showBorder={true}
    showColumnBorders={true}
    showHeader={true}
    style={{}}
    toolbarPosition="bottom"
  >
    <Column
      id="5d4e6"
      alignment="left"
      format="image"
      formatOptions={{ widthType: "fit" }}
      groupAggregationMode="none"
      hidden="true"
      label="아이템 사진"
      placeholder="Enter value"
      position="left"
      referenceId="아이템사진"
      size={97.984375}
      summaryAggregationMode="none"
      valueOverride="https://agabang-image.s3.ap-northeast-2.amazonaws.com/item_final/{{currentSourceRow.sty_cd}}{{currentSourceRow.col_cd}}.jpg"
    />
    <Column
      id="de8ce"
      alignment="left"
      format="string"
      groupAggregationMode="none"
      hidden="true"
      key="sty_cd"
      label="Sty cd"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="fd58d"
      alignment="left"
      format="string"
      formatOptions={{ automaticColors: true }}
      groupAggregationMode="none"
      hidden="true"
      key="sty_nm"
      label="Sty nm"
      placeholder="Enter value"
      position="left"
      size={102}
      summaryAggregationMode="none"
      valueOverride="{{ _.startCase(item) }}"
    />
    <Column
      id="fa030"
      alignment="left"
      format="tag"
      formatOptions={{ automaticColors: true }}
      groupAggregationMode="none"
      hidden="true"
      key="col_cd"
      label="Col cd"
      placeholder="Select option"
      position="center"
      size={100}
      summaryAggregationMode="none"
      valueOverride="{{ _.startCase(item) }}"
    />
    <Column
      id="037d3"
      alignment="left"
      format="tag"
      formatOptions={{ automaticColors: true }}
      groupAggregationMode="none"
      hidden="true"
      key="col_nm"
      label="Col nm"
      placeholder="Select option"
      position="left"
      size={101}
      summaryAggregationMode="none"
      valueOverride="{{ _.startCase(item) }}"
    />
    <Column
      id="7347f"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="string"
      formatOptions={{ automaticColors: true }}
      groupAggregationMode="sum"
      key="size_nm"
      label="사이즈명"
      placeholder="Enter value"
      position="left"
      size={282.515625}
      summaryAggregationMode="none"
    />
    <Column
      id="e1ad5"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      key="tag_price"
      label="Tag가"
      placeholder="Enter value"
      position="center"
      size={65.171875}
      summaryAggregationMode="none"
    />
    <Column
      id="2f06b"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      key="cost_price"
      label="원가"
      placeholder="Enter value"
      position="center"
      size={59.390625}
      summaryAggregationMode="none"
    />
    <Column
      id="86fcb"
      alignment="left"
      format="date"
      formatOptions={{ dateFormat: "yyyy-MM-dd" }}
      groupAggregationMode="none"
      key="first_sales_dt"
      label="첫 판매일"
      placeholder="Enter value"
      position="center"
      size={91.21875}
      summaryAggregationMode="none"
    />
    <Column
      id="db621"
      alignment="left"
      format="date"
      formatOptions={{ dateFormat: "yyyy-MM-dd" }}
      groupAggregationMode="none"
      key="last_sale_date_all"
      label="마지막 판매일"
      placeholder="Enter value"
      position="center"
      size={95.21875}
      summaryAggregationMode="none"
    />
    <Column
      id="c433d"
      alignment="left"
      format="date"
      formatOptions={{ dateFormat: "yyyy-MM-dd" }}
      groupAggregationMode="none"
      key="first_inventory_date"
      label="첫 입고일"
      placeholder="Enter value"
      position="center"
      size={93.21875}
      summaryAggregationMode="none"
    />
    <Column
      id="eaefc"
      alignment="left"
      format="date"
      formatOptions={{ dateFormat: "yyyy-MM-dd" }}
      groupAggregationMode="none"
      key="last_inventory_date"
      label="마지막 입고일"
      placeholder="Enter value"
      position="center"
      size={91.21875}
      summaryAggregationMode="none"
    />
    <Column
      id="76458"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      key="tot_in_qty"
      label="총 입고량"
      placeholder="Enter value"
      position="center"
      size={70.484375}
    />
    <Column
      id="63459"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      key="tot_sale_qty"
      label="총 판매량"
      placeholder="Enter value"
      position="center"
      size={67.484375}
    />
    <Column
      id="0b389"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      key="current_stock_qty"
      label="총 재고량"
      placeholder="Enter value"
      position="center"
      size={64.484375}
      summaryAggregationMode="none"
    />
    <Column
      id="cb2f0"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="percent"
      formatOptions={{
        showSeparators: true,
        notation: "standard",
        decimalPlaces: "0",
      }}
      groupAggregationMode="average"
      key="sale_rate"
      label="판매율"
      placeholder="Enter value"
      position="center"
      size={49.125}
    />
    <Column
      id="86fb4"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{
        showSeparators: true,
        notation: "standard",
        decimalPlaces: "1",
      }}
      groupAggregationMode="sum"
      key="avg_daily_sales_d14"
      label="일판량(D14)"
      placeholder="Enter value"
      position="center"
      size={83.546875}
      summaryAggregationMode="none"
    />
    <Column
      id="199c2"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{
        showSeparators: true,
        notation: "standard",
        decimalPlaces: "1",
      }}
      groupAggregationMode="sum"
      hidden="false"
      key="avg_daily_sales_d180"
      label="일판량(D180)"
      placeholder="Enter value"
      position="center"
      size={92.609375}
      summaryAggregationMode="none"
    />
    <Column
      id="65fe0"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{
        showSeparators: true,
        notation: "standard",
        decimalPlaces: "1",
      }}
      groupAggregationMode="sum"
      key="avg_daily_sales_d365"
      label="일판량(D365)"
      placeholder="Enter value"
      position="center"
      size={91.40625}
      summaryAggregationMode="none"
    />
    <Column
      id="30840"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{
        showSeparators: true,
        notation: "standard",
        decimalPlaces: "1",
      }}
      groupAggregationMode="sum"
      hidden="false"
      key="avg_daily_sales"
      label="일판량(전체기간)"
      placeholder="Enter value"
      position="center"
      size={100.234375}
      summaryAggregationMode="none"
    />
    <Column
      id="79927"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="true"
      key="size_cd"
      label="Size cd"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="a755f"
      alignment="left"
      format="string"
      groupAggregationMode="none"
      hidden="true"
      key="large_cat"
      label="Large cat"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="0988c"
      alignment="left"
      format="string"
      groupAggregationMode="none"
      hidden="true"
      key="middle_cat"
      label="Middle cat"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="401e3"
      alignment="left"
      format="string"
      groupAggregationMode="none"
      hidden="true"
      key="small_cat"
      label="Small cat"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="b7c75"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="true"
      key="it"
      label="It"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="749a3"
      alignment="left"
      format="string"
      groupAggregationMode="none"
      hidden="true"
      key="it_nm"
      label="It nm"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="b9a97"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="true"
      key="it_gb"
      label="It gb"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="3d4af"
      alignment="left"
      format="string"
      groupAggregationMode="none"
      hidden="true"
      key="it_gb_nm"
      label="It gb nm"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="1f395"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="true"
      key="item"
      label="Item"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="02191"
      alignment="left"
      format="string"
      groupAggregationMode="none"
      hidden="true"
      key="item_nm"
      label="Item nm"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="6b0d2"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="true"
      key="total_all_time_sale_qty"
      label="Total all time sale qty"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="cde01"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="true"
      key="total_sales_days"
      label="Total sales days"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="f453c"
      alignment="left"
      format="date"
      groupAggregationMode="none"
      hidden="true"
      key="first_sale_date_all"
      label="First sale date all"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="4d4eb"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="true"
      key="sales_qty_365d"
      label="Sales qty 365 d"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="1864e"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="true"
      key="sales_days_count_365d"
      label="Sales days count 365 d"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="68da7"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{
        showSeparators: true,
        notation: "standard",
        decimalPlaces: "1",
      }}
      groupAggregationMode="sum"
      hidden="true"
      key="sales_qty_14d"
      label="sales qty 14d"
      placeholder="Enter value"
      position="center"
      size={90.0625}
      summaryAggregationMode="none"
    />
    <Column
      id="83471"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{
        showSeparators: true,
        notation: "standard",
        decimalPlaces: "1",
      }}
      groupAggregationMode="sum"
      hidden="true"
      key="sales_qty_180d"
      label="sales qty 180d"
      placeholder="Enter value"
      position="center"
      size={94.109375}
      summaryAggregationMode="none"
    />
    <Column
      id="54985"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{
        showSeparators: true,
        notation: "standard",
        decimalPlaces: "0",
      }}
      groupAggregationMode="sum"
      key="days_until_out_of_stock_d14"
      label="소진예상일수(D14)"
      placeholder="Enter value"
      position="center"
      size={117.890625}
      summaryAggregationMode="none"
    />
    <Column
      id="5a4bf"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{
        showSeparators: true,
        notation: "standard",
        decimalPlaces: "0",
      }}
      groupAggregationMode="sum"
      key="days_until_out_of_stock_d180"
      label="소진예상일수(D180)"
      placeholder="Enter value"
      position="center"
      size={124.953125}
      summaryAggregationMode="none"
    />
    <Column
      id="9ee52"
      alignment="right"
      backgroundColor={
        '{{currentSourceRow.days_until_out_of_stock_d365 < 90 ? "#FF6B6B" :  // 연한 빨강색 (긴급: 90일 미만)\ncurrentSourceRow.days_until_out_of_stock_d365 < 180 ? "#FFB347" : // 주황색 (주의: 90일 이상 180일 미만)\n"" // 연한 초록색 (양호: 180일 이상)\n}}'
      }
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{
        showSeparators: true,
        notation: "standard",
        decimalPlaces: "0",
      }}
      groupAggregationMode="sum"
      key="days_until_out_of_stock_d365"
      label="소진예상일수(D365)"
      placeholder="Enter value"
      position="center"
      size={128.546875}
      summaryAggregationMode="none"
    />
    <Column
      id="b6971"
      alignment="right"
      backgroundColor={
        '{{\n  currentSourceRow.days_until_out_of_stock < 90 ? "#FF6B6B" :  // 연한 빨강색 (긴급: 90일 미만)\n  currentSourceRow.days_until_out_of_stock < 180 ? "#FFB347" : // 주황색 (주의: 90일 이상 180일 미만)\n  ""                                                   // 연한 초록색 (양호: 180일 이상)\n}}'
      }
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{
        showSeparators: true,
        notation: "standard",
        decimalPlaces: "0",
      }}
      groupAggregationMode="sum"
      key="days_until_out_of_stock"
      label="소진예상일수(전체기간)"
      placeholder="Enter value"
      position="center"
      size={130.28125}
      summaryAggregationMode="none"
    />
    <Column
      id="0114c"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="true"
      key="wh_stck_qty"
      label="Wh stck qty"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="8ae9f"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="true"
      key="sh_stck_qty"
      label="Sh stck qty"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="dbd2e"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="true"
      key="color_tot_in_qty"
      label="Color tot in qty"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="8e29d"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="true"
      key="color_tot_sale_qty"
      label="Color tot sale qty"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="fbd60"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="true"
      key="total_reorder_count"
      label="리오더 횟수"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="f82f9"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="true"
      key="color_current_stock"
      label="Color current stock"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="26dea"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="true"
      key="sales_days_count_14d"
      label="Sales days count 14 d"
      placeholder="Enter value"
      position="center"
      size={144.1875}
      summaryAggregationMode="none"
    />
    <Column
      id="fc494"
      alignment="left"
      format="date"
      groupAggregationMode="none"
      hidden="true"
      key="first_sale_date_14d"
      label="First sale date 14 d"
      placeholder="Enter value"
      position="center"
      size={127.390625}
      summaryAggregationMode="none"
    />
    <Column
      id="89c3f"
      alignment="left"
      format="date"
      groupAggregationMode="none"
      hidden="true"
      key="last_sale_date_14d"
      label="Last sale date 14 d"
      placeholder="Enter value"
      position="center"
      size={126.171875}
      summaryAggregationMode="none"
    />
    <Column
      id="269f6"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="true"
      key="sales_days_count_180d"
      label="Sales days count 180 d"
      placeholder="Enter value"
      position="center"
      size={152.234375}
      summaryAggregationMode="none"
    />
    <Column
      id="bed86"
      alignment="left"
      format="date"
      groupAggregationMode="none"
      hidden="true"
      key="first_sale_date_180d"
      label="First sale date 180 d"
      placeholder="Enter value"
      position="center"
      size={135.46875}
      summaryAggregationMode="none"
    />
    <Column
      id="437d1"
      alignment="left"
      format="date"
      groupAggregationMode="none"
      hidden="true"
      key="last_sale_date_180d"
      label="Last sale date 180 d"
      placeholder="Enter value"
      position="center"
      size={134.234375}
      summaryAggregationMode="none"
    />
    <Column
      id="f56da"
      alignment="left"
      format="date"
      groupAggregationMode="none"
      hidden="true"
      key="first_sale_date_365d"
      label="First sale date 365 d"
      placeholder="Enter value"
      position="center"
      size={135.46875}
      summaryAggregationMode="none"
    />
    <Column
      id="31359"
      alignment="left"
      format="date"
      groupAggregationMode="none"
      hidden="true"
      key="last_sale_date_365d"
      label="Last sale date 365 d"
      placeholder="Enter value"
      position="center"
      size={134.234375}
      summaryAggregationMode="none"
    />
    <Column
      id="cf118"
      alignment="left"
      format="string"
      groupAggregationMode="none"
      placeholder="Enter value"
      position="right"
      referenceId="empty_placeholder"
      size={464.984375}
      summaryAggregationMode="none"
    />
    <Event
      event="save"
      method="trigger"
      params={{ ordered: [] }}
      pluginId="discontinuedProductsQuery"
      type="datasource"
      waitMs="0"
      waitType="debounce"
    />
    <Event
      event="selectRow"
      method="show"
      params={{ ordered: [] }}
      pluginId="drawerFrame1"
      type="widget"
      waitMs="0"
      waitType="debounce"
    />
    <Event
      event="selectRow"
      method="setValue"
      params={{ ordered: [{ value: "{{ currentSourceRow.sty_cd}}" }] }}
      pluginId="clicked_item_sty_cd"
      type="state"
      waitMs="0"
      waitType="debounce"
    />
  </Table>
</ExpandedRow>
