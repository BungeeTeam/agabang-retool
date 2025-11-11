<ExpandedRow id="table_reorder_targets2ExpandedRow">
  <Table
    id="table12"
    cellSelection="none"
    clearChangesetOnSave={true}
    data="{{ get_item_list.data.filter(item => 
   item.sty_cd === currentSourceRow.sty_cd && 
   item.col_cd === currentSourceRow.col_cd) }}"
    defaultSelectedRow={{ mode: "none", indexType: "display", index: 0 }}
    defaultSort={[{ object: { columnId: "79927", direction: "asc" } }]}
    emptyMessage="No rows found"
    groupedColumnConfig={{ expandByDefault: false, size: 200 }}
    heightType="auto"
    margin="0"
    rowBackgroundColor=""
    rowHeight="small"
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
      size={163.515625}
      summaryAggregationMode="none"
    />
    <Column
      id="e1ad5"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="true"
      key="tag_price"
      label="Tag가"
      placeholder="Enter value"
      position="center"
      size={76.171875}
      summaryAggregationMode="none"
    />
    <Column
      id="2f06b"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="true"
      key="cost_price"
      label="원가"
      placeholder="Enter value"
      position="center"
      size={64.390625}
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
      size={103.21875}
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
      size={98.21875}
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
      size={103.21875}
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
      size={102.21875}
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
      size={77.484375}
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
      size={76.484375}
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
      size={74.484375}
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
      size={69.125}
    />
    <Column
      id="76904"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{
        showSeparators: true,
        notation: "standard",
        decimalPlaces: "1",
      }}
      groupAggregationMode="sum"
      key="avg_daily_sales_d30"
      label="일판량(D30)"
      placeholder="Enter value"
      position="center"
      size={100}
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
      size={106.609375}
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
      size={111.40625}
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
      size={114.234375}
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
      id="9ee95"
      alignment="right"
      backgroundColor={
        '{{currentSourceRow.days_until_out_of_stock_d30 < 90 ? "#FF6B6B" :  // 연한 빨강색 (긴급: 90일 미만)\ncurrentSourceRow.days_until_out_of_stock_d30 < 180 ? "#FFB347" : // 주황색 (주의: 90일 이상 180일 미만)\n"" // 연한 초록색 (양호: 180일 이상)\n}}'
      }
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{
        showSeparators: true,
        notation: "standard",
        decimalPlaces: "0",
      }}
      groupAggregationMode="sum"
      key="days_until_out_of_stock_d30"
      label="소진예상일수(D30)"
      placeholder="Enter value"
      position="center"
      size={140}
      summaryAggregationMode="none"
    />
    <Column
      id="5a4bf"
      alignment="right"
      backgroundColor={
        '{{currentSourceRow.days_until_out_of_stock_d180 < 180 ? "#FF6B6B" :  // 연한 빨강색 (긴급: 90일 미만)\ncurrentSourceRow.days_until_out_of_stock_d180 < 180 ? "#FFB347" : // 주황색 (주의: 90일 이상 180일 미만)\n"" // 연한 초록색 (양호: 180일 이상)\n}}'
      }
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
      size={143.953125}
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
      size={143.546875}
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
      size={150.28125}
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
      id="7aac5"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="true"
      key="cust_cd"
      label="Cust cd"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="064bc"
      alignment="left"
      format="string"
      groupAggregationMode="none"
      hidden="true"
      key="cust_nm"
      label="Cust nm"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="19e48"
      alignment="left"
      format="string"
      groupAggregationMode="none"
      hidden="true"
      key="br_nm"
      label="Br nm"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="4d132"
      alignment="left"
      format="string"
      groupAggregationMode="none"
      hidden="true"
      key="fabric"
      label="Fabric"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="fd3b4"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="true"
      key="color_wh_stck_qty"
      label="Color wh stck qty"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="1b9bd"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="true"
      key="color_sh_stck_qty"
      label="Color sh stck qty"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="68afd"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="true"
      key="avg_monthly_sales"
      label="Avg monthly sales"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="86a23"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="true"
      key="total_sales_months"
      label="Total sales months"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="55f3e"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="true"
      key="sales_qty_30d"
      label="Sales qty 30 d"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="2fb9d"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="true"
      key="avg_monthly_sales_d30"
      label="Avg monthly sales d 30"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="c8e5b"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="true"
      key="sales_days_count_30d"
      label="Sales days count 30 d"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="6bd8c"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="true"
      key="sales_months_count_30d"
      label="Sales months count 30 d"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="b5c7d"
      alignment="left"
      format="date"
      groupAggregationMode="none"
      hidden="true"
      key="first_sale_date_30d"
      label="First sale date 30 d"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="76420"
      alignment="left"
      format="date"
      groupAggregationMode="none"
      hidden="true"
      key="last_sale_date_30d"
      label="Last sale date 30 d"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="9abbe"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="true"
      key="avg_monthly_sales_d180"
      label="Avg monthly sales d 180"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="2bc64"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="true"
      key="sales_months_count_180d"
      label="Sales months count 180 d"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="5b2a7"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="true"
      key="avg_monthly_sales_d365"
      label="Avg monthly sales d 365"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="7f6f7"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="true"
      key="sales_months_count_365d"
      label="Sales months count 365 d"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="57625"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="true"
      key="months_until_out_of_stock"
      label="Months until out of stock"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="89ceb"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="true"
      key="months_until_out_of_stock_d30"
      label="Months until out of stock d 30"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="b67bb"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="true"
      key="months_until_out_of_stock_d180"
      label="Months until out of stock d 180"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="430b3"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="true"
      key="months_until_out_of_stock_d365"
      label="Months until out of stock d 365"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="69a3e"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="true"
      key="active_shop_count"
      label="Active shop count"
      placeholder="Enter value"
      position="center"
      size={100}
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
  </Table>
</ExpandedRow>
