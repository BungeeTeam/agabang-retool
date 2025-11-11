<ExpandedRow id="table_main_listExpandedRow">
  <Table
    id="table8"
    cellSelection="none"
    clearChangesetOnSave={true}
    data="{{ getColorList.data.filter(item => 
   item._type === 'size' &&
   item.sty_cd === currentSourceRow.sty_cd && 
   item.col_cd === currentSourceRow.col_cd) }}"
    defaultSelectedRow={{ mode: "none", indexType: "display", index: 0 }}
    defaultSort={[{ object: { columnId: "79927", direction: "asc" } }]}
    emptyMessage="No rows found"
    groupedColumnConfig={{ expandByDefault: false, size: 200 }}
    heightType="auto"
    margin="0"
    rowBackgroundColor=""
    rowHeight="xsmall"
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
      alignment="center"
      editableOptions={{ showStepper: true }}
      format="string"
      formatOptions={{ automaticColors: true }}
      groupAggregationMode="sum"
      key="size_nm"
      label="사이즈명"
      placeholder="Enter value"
      position="left"
      size={73.515625}
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
      hidden="true"
      key="cost_price"
      label="원가"
      placeholder="Enter value"
      position="center"
      size={59.390625}
      summaryAggregationMode="none"
    />
    <Column
      id="4a86b"
      alignment="center"
      format="date"
      formatOptions={{ dateFormat: "yyyy-MM-dd" }}
      groupAggregationMode="none"
      hidden="false"
      key="first_outbound_date"
      label="첫 출고일"
      placeholder="Enter value"
      position="center"
      size={124}
      summaryAggregationMode="none"
    />
    <Column
      id="86fcb"
      alignment="left"
      format="date"
      formatOptions={{ dateFormat: "yyyy-MM-dd" }}
      groupAggregationMode="none"
      hidden="true"
      key="first_sales_dt"
      label="첫 판매일"
      placeholder="Enter value"
      position="center"
      size={91.21875}
      summaryAggregationMode="none"
    />
    <Column
      id="c433d"
      alignment="left"
      format="date"
      formatOptions={{ dateFormat: "yyyy-MM-dd" }}
      groupAggregationMode="none"
      hidden="true"
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
      hidden="true"
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
      size={82.484375}
    />
    <Column
      id="3141c"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      key="tot_out_qty"
      label="총 출고량"
      placeholder="Enter value"
      position="center"
      size={84}
      summaryAggregationMode="none"
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
      size={83.484375}
    />
    <Column
      id="0b389"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      key="current_stock_qty"
      label="총재고"
      placeholder="Enter value"
      position="center"
      size={78.484375}
      summaryAggregationMode="none"
    />
    <Column
      id="79927"
      alignment="right"
      editable={false}
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
      hidden="true"
      key="days_until_out_of_stock_d365"
      label="소진예상일수(D365)"
      placeholder="Enter value"
      position="center"
      size={128.546875}
      summaryAggregationMode="none"
    />
    <Column
      id="8ae9f"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="false"
      key="sh_stck_qty"
      label="매장재고"
      placeholder="Enter value"
      position="center"
      size={86}
      summaryAggregationMode="none"
    />
    <Column
      id="0114c"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="false"
      key="wh_stck_qty"
      label="창고재고"
      placeholder="Enter value"
      position="center"
      size={78}
      summaryAggregationMode="none"
    />
    <Column
      id="96b7d"
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
      id="a4b1f"
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
      id="bfba7"
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
      id="9bb4e"
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
      id="c3059"
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
      id="f52e6"
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
      id="996b6"
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
      id="7d05c"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="true"
      key="days_until_out_of_stock_d30"
      label="Days until out of stock d 30"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="cdaa9"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{
        showSeparators: true,
        notation: "standard",
        decimalPlaces: "0",
      }}
      groupAggregationMode="sum"
      key="estimated_stock"
      label="예상 재고"
      placeholder="Enter value"
      position="center"
      size={78}
      summaryAggregationMode="none"
    />
    <Column
      id="a1ddb"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{
        showSeparators: true,
        notation: "standard",
        decimalPlaces: "0",
      }}
      groupAggregationMode="sum"
      hidden="true"
      key="recommended_reorder_qty"
      label="필요 수량"
      placeholder="Enter value"
      position="center"
      size={85}
      summaryAggregationMode="none"
    />
    <Column
      id="00169"
      alignment="right"
      cellTooltip="참고:
- 최근 7일: {{ (currentSourceRow.avg_daily_sales_d7).toFixed(1) }}
- 최근 30일: {{ (currentSourceRow.avg_daily_sales_d30).toFixed(1) }}
- 최근 180일: {{ (currentSourceRow.avg_daily_sales_d180).toFixed(1) }}
- 최근 365일: {{ (currentSourceRow.avg_daily_sales_d365).toFixed(1) }}"
      cellTooltipMode="custom"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      key="avg_daily_sales"
      label="일판매량"
      placeholder="Enter value"
      position="left"
      size={70}
      summaryAggregationMode="none"
      tooltip="전체 판매기간 기준 일 평균 판매량"
      valueOverride="{{ item.toFixed(1) }}"
    />
    <Column
      id="d29e8"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{
        showSeparators: true,
        notation: "standard",
        decimalPlaces: "0",
      }}
      groupAggregationMode="sum"
      key="shortage_qty"
      label="부족 수량"
      placeholder="Enter value"
      position="center"
      size={76}
      summaryAggregationMode="none"
      tooltip="비상재고량(매장DP용)을 고려하지 않은 부족 수량:

(예상판매량 - 현재고) / 목표 판매율"
    />
    <Column
      id="c1f60"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{
        showSeparators: true,
        notation: "standard",
        decimalPlaces: "0",
      }}
      groupAggregationMode="sum"
      key="wh_days_until_out_of_stock_d180"
      label="창고재고 예상 소진일수 (최근 180일 기준)"
      placeholder="Enter value"
      position="center"
      size={95}
      summaryAggregationMode="none"
      textColor={
        "{{ \n  item < currentSourceRow.lead_time_days ? '#FF0000' : \"\" \n}}"
      }
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
      hidden="false"
      key="days_until_out_of_stock_d180"
      label="총재고 예상 소진일수 (최근 180일 기준)"
      placeholder="Enter value"
      position="center"
      size={88.953125}
      summaryAggregationMode="none"
      textColor={
        "{{ \n  item < currentSourceRow.lead_time_days ? '#FF0000' : \"\" \n}}"
      }
    />
    <Column
      id="0268b"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{
        showSeparators: true,
        notation: "standard",
        decimalPlaces: "0",
      }}
      groupAggregationMode="sum"
      hidden="true"
      key="wh_days_until_out_of_stock_d30"
      label="Wh days until out of stock d 30"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="8d1b6"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="true"
      key="wh_days_until_out_of_stock_d365"
      label="Wh days until out of stock d 365"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="8feb3"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="true"
      key="expected_sales_during_lead_time"
      label="Expected sales during lead time"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="f94a5"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="true"
      key="expected_sales_full_period"
      label="Expected sales full period"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="7ad40"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="true"
      key="final_reorder_qty"
      label="Final reorder qty"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="e81c2"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="true"
      key="buffer_days_d30"
      label="Buffer days d 30"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="e6355"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="true"
      key="buffer_days_d180"
      label="Buffer days d 180"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="e6102"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="true"
      key="buffer_days_d365"
      label="Buffer days d 365"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="b9a8e"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="true"
      key="wh_buffer_days_d30"
      label="Wh buffer days d 30"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="3f308"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="true"
      key="wh_buffer_days_d180"
      label="Wh buffer days d 180"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="b585d"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="true"
      key="wh_buffer_days_d365"
      label="Wh buffer days d 365"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="902b6"
      alignment="left"
      format="string"
      groupAggregationMode="none"
      hidden="true"
      key="status_d30_size"
      label="Status d 30 size"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="b92c0"
      alignment="left"
      format="string"
      groupAggregationMode="none"
      hidden="true"
      key="status_d180_size"
      label="Status d 180 size"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="df1a1"
      alignment="left"
      format="string"
      groupAggregationMode="none"
      hidden="true"
      key="status_d365_size"
      label="Status d 365 size"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="dfb0e"
      alignment="left"
      format="string"
      groupAggregationMode="none"
      hidden="true"
      key="wh_status_d30_size"
      label="Wh status d 30 size"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="f96ae"
      alignment="left"
      format="string"
      groupAggregationMode="none"
      hidden="true"
      key="wh_status_d180_size"
      label="Wh status d 180 size"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="36df5"
      alignment="left"
      format="string"
      groupAggregationMode="none"
      hidden="true"
      key="wh_status_d365_size"
      label="Wh status d 365 size"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="cf7cd"
      alignment="left"
      format="date"
      groupAggregationMode="none"
      hidden="true"
      key="last_sales_dt"
      label="Last sales dt"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="1c726"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="percent"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="average"
      hidden="true"
      key="weekly_7d_sale_qty"
      label="Weekly 7 d sale qty"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="9e44a"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="true"
      key="sales_period_until_reference_date"
      label="Sales period until reference date"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="12605"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="true"
      key="expected_sales_period"
      label="Expected sales period"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="cf233"
      alignment="left"
      format="boolean"
      groupAggregationMode="none"
      hidden="true"
      key="is_discontinued"
      label="Is discontinued"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="2495f"
      alignment="left"
      format="string"
      groupAggregationMode="none"
      hidden="true"
      key="colorKey"
      label="Color key"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="cac71"
      alignment="left"
      format="link"
      formatOptions={{ showUnderline: "hover" }}
      groupAggregationMode="none"
      hidden="true"
      key="item_image"
      label="Item image"
      position="center"
      size={100}
      summaryAggregationMode="none"
    >
      <Event
        event="clickCell"
        method="openUrl"
        params={{ ordered: [{ url: "{{ item }}" }] }}
        pluginId=""
        type="util"
        waitMs="0"
        waitType="debounce"
      />
    </Column>
    <Column
      id="b45ce"
      alignment="left"
      format="tag"
      formatOptions={{ automaticColors: true }}
      groupAggregationMode="none"
      hidden="true"
      key="reorder_recommending_status_size"
      label="Reorder recommending status size"
      placeholder="Select option"
      position="center"
      size={100}
      summaryAggregationMode="none"
      valueOverride="{{ _.startCase(item) }}"
    />
    <Column
      id="2c21a"
      alignment="left"
      format="tag"
      formatOptions={{ automaticColors: true }}
      groupAggregationMode="none"
      hidden="true"
      key="wh_reorder_recommending_status_size"
      label="Wh reorder recommending status size"
      placeholder="Select option"
      position="center"
      size={100}
      summaryAggregationMode="none"
      valueOverride="{{ _.startCase(item) }}"
    />
    <Column
      id="7c5af"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="true"
      key="lead_time_days"
      label="Lead time days"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="bacad"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="true"
      key="target_sale_rate"
      label="Target sale rate"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="8af74"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="true"
      key="effective_monthly_sales"
      label="Effective monthly sales"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="39495"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="true"
      key="lead_time_shortage_qty"
      label="Lead time shortage qty"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="8f410"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="true"
      key="lead_time_recommended_reorder_qty"
      label="Lead time recommended reorder qty"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="6d507"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="true"
      key="lead_time_final_reorder_qty"
      label="Lead time final reorder qty"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="4a520"
      alignment="left"
      format="tag"
      formatOptions={{ automaticColors: true }}
      groupAggregationMode="none"
      hidden="true"
      key="_type"
      label="Type"
      placeholder="Select option"
      position="center"
      size={100}
      summaryAggregationMode="none"
      valueOverride="{{ _.startCase(item) }}"
    />
    <Column
      id="a1436"
      alignment="left"
      format="string"
      groupAggregationMode="none"
      hidden="true"
      key="groupId"
      label="Group ID"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="84b77"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="true"
      key="avg_monthly_sales"
      label="월 판매량"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="d0571"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="true"
      key="avg_daily_sales_d7"
      label="Avg daily sales d 7"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="618d8"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="true"
      key="avg_daily_sales_d30"
      label="Avg daily sales d 30"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="7ef6e"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="true"
      key="avg_daily_sales_d180"
      label="Avg daily sales d 180"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="56a28"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="true"
      key="avg_daily_sales_d365"
      label="Avg daily sales d 365"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="136de"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="{{ var_brand_code.value == '01' }}"
      key="week_1_sale_qty"
      label="{{ (() => {
  const now = new Date(); // KST 기준 현재 시간 (실제로는 new Date())
  
  const currentDay = now.getDay();
  const daysToMonday = currentDay === 0 ? -6 : 1 - currentDay;
  const thisMonday = new Date(now.getTime() + daysToMonday * 24 * 60 * 60 * 1000);
  
  const week1Start = new Date(
    currentDay === 1 
      ? thisMonday.getTime() - 7 * 24 * 60 * 60 * 1000 // 월요일: 지난 주 월요일
      : thisMonday.getTime() // 그 외: 이번 주 월요일
  );
  
  const week1End = new Date(week1Start.getTime() + 6 * 24 * 60 * 60 * 1000); // 시작일 + 6일
  
  const formatDate = (date) => {
    const month = date.getMonth() + 1;
    const day = date.getDate();
    return `${month}/${day}`;
  };
  
  const getMonthAndWeek = (date) => {
    const month = date.getMonth() + 1;
    const year = date.getFullYear();
    const firstDayOfMonth = new Date(year, date.getMonth(), 1);
    const firstMonday = new Date(firstDayOfMonth);
    while (firstMonday.getDay() !== 1) {
      firstMonday.setDate(firstMonday.getDate() + 1);
    }
    const daysSinceFirstMonday = Math.floor((date.getTime() - firstMonday.getTime()) / (24 * 60 * 60 * 1000));
    const weekNumber = Math.floor(daysSinceFirstMonday / 7) + 1;
    return { month, weekNumber };
  };
  
  const { month, weekNumber } = getMonthAndWeek(week1Start);
  
  return `${month}월 ${weekNumber}주차 (${formatDate(week1Start)}~${formatDate(week1End)})`;
})() }}"
      placeholder="Enter value"
      position="center"
      size={114}
      statusIndicatorOptions={{
        manualData: [
          {
            ordered: [
              { showWhen: "{{ item >= currentSourceRow.week_2_sale_qty }}" },
              {
                label:
                  "{{\n  (() => {\n    const currentWeek = Number(currentSourceRow.week_1_sale_qty) || 0;\n    const lastWeek = Number(currentSourceRow.week_2_sale_qty) || 0;\n    \n    // 전월 판매량이 0인 경우 처리\n    if (lastWeek === 0) {\n      if (currentWeek === 0) {\n        return '-';  // 둘 다 0이면 \"-\" 표시\n      } else {\n        return \"NEW\";  // 전주가 0일 때는 이번 주 판매량 그대로 표시\n      }\n    }\n    \n    // 증감률 계산 후 절대값 적용\n    const changeRate = Math.abs(((currentWeek - lastWeek) / lastWeek) * 100);\n    \n    // 정상적인 경우\n    return changeRate.toFixed(0) + '%';\n  })()\n}}",
              },
              { color: "#D7EAE0" },
              { icon: "bold/interface-arrows-up" },
            ],
          },
          {
            ordered: [
              { showWhen: "{{ item < currentRow.week_2_sale_qty }}" },
              {
                label:
                  "{{\n  (() => {\n    const currentWeek = Number(currentSourceRow.week_1_sale_qty) || 0;\n    const lastWeek = Number(currentSourceRow.week_2_sale_qty) || 0;\n    \n    // 전월 판매량이 0인 경우 처리\n    if (lastWeek === 0) {\n      if (currentWeek === 0) {\n        return '-';  // 둘 다 0이면 \"-\" 표시\n      } else {\n        return \"NEW\";  // 전주가 0일 때는 이번 주 판매량 그대로 표시\n      }\n    }\n    \n    // 증감률 계산 후 절대값 적용\n    const changeRate = Math.abs(((currentWeek - lastWeek) / lastWeek) * 100);\n    \n    // 정상적인 경우\n    return changeRate.toFixed(0) + '%';\n  })()\n}}",
              },
              { color: "#F8DBD8" },
              { icon: "bold/interface-arrows-down" },
            ],
          },
        ],
      }}
      summaryAggregationMode="none"
      tooltip="이번 주 판매량입니다.
전주 대비 증감도 함께 보여드려요.

전주 대비 증감율 = ((이번 주 판매량 - 전주 판매량) / 전주 판매량) * 100"
    />
    <Column
      id="50ba6"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="{{ var_brand_code.value == '01' }}"
      key="week_2_sale_qty"
      label="{{ (() => {
  const now = new Date(); // KST 기준 현재 시간 (고정된 날짜로 테스트, 실제로는 new Date() 사용)
  
  // 현재 날짜의 요일 구하기 (0: 일요일, 1: 월요일, ...)
  const currentDay = now.getDay();
  
  // 이번 주 월요일 구하기
  const daysToMonday = currentDay === 0 ? -6 : 1 - currentDay;
  const thisMonday = new Date(now.getTime() + daysToMonday * 24 * 60 * 60 * 1000);
  
  // week_1_sale_qty의 시작일 (SQL 쿼리와 동일)
  const week1Start = new Date(
    currentDay === 1 
      ? thisMonday.getTime() - 7 * 24 * 60 * 60 * 1000 // 월요일: 지난 주 월요일
      : thisMonday.getTime() // 그 외: 이번 주 월요일
  );
  
  // week_2_sale_qty의 시작일 (week_1_sale_qty에서 1주 전)
  const week2Start = new Date(week1Start.getTime() - 7 * 24 * 60 * 60 * 1000);
  
  // week_2_sale_qty의 종료일 (시작일 + 6일)
  const week2End = new Date(week2Start.getTime() + 6 * 24 * 60 * 60 * 1000);
  
  // M/d 형식으로 포맷팅
  const formatDate = (date) => {
    const month = date.getMonth() + 1;
    const day = date.getDate();
    return `${month}/${day}`;
  };
  
  // 월과 주차 계산
  const getMonthAndWeek = (date) => {
    const month = date.getMonth() + 1; // 월 (1~12)
    const year = date.getFullYear();
    
    // 해당 월의 첫 날
    const firstDayOfMonth = new Date(year, date.getMonth(), 1);
    
    // 첫 번째 월요일 찾기
    const firstMonday = new Date(firstDayOfMonth);
    while (firstMonday.getDay() !== 1) {
      firstMonday.setDate(firstMonday.getDate() + 1);
    }
    
    // 주차 계산: date가 속한 주가 월의 몇 번째 주인지
    const daysSinceFirstMonday = Math.floor((date.getTime() - firstMonday.getTime()) / (24 * 60 * 60 * 1000));
    const weekNumber = Math.floor(daysSinceFirstMonday / 7) + 1;
    
    return { month, weekNumber };
  };
  
  const { month, weekNumber } = getMonthAndWeek(week2Start);
  
  return `${month}월 ${weekNumber}주차 (${formatDate(week2Start)}~${formatDate(week2End)})`;
})() }}"
      placeholder="Enter value"
      position="center"
      size={109}
      statusIndicatorOptions={{
        manualData: [
          {
            ordered: [
              { showWhen: "{{ item >= currentSourceRow.week_3_sale_qty }}" },
              {
                label:
                  "{{\n  (() => {\n    const currentWeek = Number(currentSourceRow.week_2_sale_qty) || 0;\n    const lastWeek = Number(currentSourceRow.week_3_sale_qty) || 0;\n    \n    // 전월 판매량이 0인 경우 처리\n    if (lastWeek === 0) {\n      if (currentWeek === 0) {\n        return '-';  // 둘 다 0이면 \"-\" 표시\n      } else {\n        return \"NEW\";  // 전주가 0일 때는 이번 주 판매량 그대로 표시\n      }\n    }\n    \n    // 증감률 계산 후 절대값 적용\n    const changeRate = Math.abs(((currentWeek - lastWeek) / lastWeek) * 100);\n    \n    // 정상적인 경우\n    return changeRate.toFixed(0) + '%';\n  })()\n}}",
              },
              { color: "#D7EAE0" },
              { icon: "bold/interface-arrows-up" },
            ],
          },
          {
            ordered: [
              { showWhen: "{{ item < currentSourceRow.week_3_sale_qty }}" },
              {
                label:
                  "{{\n  (() => {\n    const currentWeek = Number(currentSourceRow.week_2_sale_qty) || 0;\n    const lastWeek = Number(currentSourceRow.week_3_sale_qty) || 0;\n    \n    // 전월 판매량이 0인 경우 처리\n    if (lastWeek === 0) {\n      if (currentWeek === 0) {\n        return '-';  // 둘 다 0이면 \"-\" 표시\n      } else {\n        return \"NEW\";  // 전주가 0일 때는 이번 주 판매량 그대로 표시\n      }\n    }\n    \n    // 증감률 계산 후 절대값 적용\n    const changeRate = Math.abs(((currentWeek - lastWeek) / lastWeek) * 100);\n    \n    // 정상적인 경우\n    return changeRate.toFixed(0) + '%';\n  })()\n}}",
              },
              { color: "#F8DBD8" },
              { icon: "bold/interface-arrows-down" },
            ],
          },
        ],
      }}
      summaryAggregationMode="none"
    />
    <Column
      id="529bd"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="{{ var_brand_code.value == '01' }}"
      key="week_3_sale_qty"
      label="{{ (() => {
  const now = new Date(); // KST 기준 현재 시간 (실제로는 new Date())
  
  const currentDay = now.getDay();
  const daysToMonday = currentDay === 0 ? -6 : 1 - currentDay;
  const thisMonday = new Date(now.getTime() + daysToMonday * 24 * 60 * 60 * 1000);
  
  const week1Start = new Date(
    currentDay === 1 
      ? thisMonday.getTime() - 7 * 24 * 60 * 60 * 1000 
      : thisMonday.getTime()
  );
  
  const week3Start = new Date(week1Start.getTime() - 2 * 7 * 24 * 60 * 60 * 1000); // week_1에서 2주 전
  const week3End = new Date(week3Start.getTime() + 6 * 24 * 60 * 60 * 1000);
  
  const formatDate = (date) => {
    const month = date.getMonth() + 1;
    const day = date.getDate();
    return `${month}/${day}`;
  };
  
  const getMonthAndWeek = (date) => {
    const month = date.getMonth() + 1;
    const year = date.getFullYear();
    const firstDayOfMonth = new Date(year, date.getMonth(), 1);
    const firstMonday = new Date(firstDayOfMonth);
    while (firstMonday.getDay() !== 1) {
      firstMonday.setDate(firstMonday.getDate() + 1);
    }
    const daysSinceFirstMonday = Math.floor((date.getTime() - firstMonday.getTime()) / (24 * 60 * 60 * 1000));
    const weekNumber = Math.floor(daysSinceFirstMonday / 7) + 1;
    return { month, weekNumber };
  };
  
  const { month, weekNumber } = getMonthAndWeek(week3Start);
  
  return `${month}월 ${weekNumber}주차 (${formatDate(week3Start)}~${formatDate(week3End)})`;
})() }}"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="0daef"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="{{ var_brand_code.value == '01' }}"
      key="week_4_sale_qty"
      label="{{ (() => {
  const now = new Date();
  
  const currentDay = now.getDay();
  const daysToMonday = currentDay === 0 ? -6 : 1 - currentDay;
  const thisMonday = new Date(now.getTime() + daysToMonday * 24 * 60 * 60 * 1000);
  
  const week1Start = new Date(
    currentDay === 1 
      ? thisMonday.getTime() - 7 * 24 * 60 * 60 * 1000 
      : thisMonday.getTime()
  );
  
  const week4Start = new Date(week1Start.getTime() - 3 * 7 * 24 * 60 * 60 * 1000); // week_1에서 3주 전
  const week4End = new Date(week4Start.getTime() + 6 * 24 * 60 * 60 * 1000);
  
  const formatDate = (date) => {
    const month = date.getMonth() + 1;
    const day = date.getDate();
    return `${month}/${day}`;
  };
  
  const getMonthAndWeek = (date) => {
    const month = date.getMonth() + 1;
    const year = date.getFullYear();
    const firstDayOfMonth = new Date(year, date.getMonth(), 1);
    const firstMonday = new Date(firstDayOfMonth);
    while (firstMonday.getDay() !== 1) {
      firstMonday.setDate(firstMonday.getDate() + 1);
    }
    const daysSinceFirstMonday = Math.floor((date.getTime() - firstMonday.getTime()) / (24 * 60 * 60 * 1000));
    const weekNumber = Math.floor(daysSinceFirstMonday / 7) + 1;
    return { month, weekNumber };
  };
  
  const { month, weekNumber } = getMonthAndWeek(week4Start);
  
  return `${month}월 ${weekNumber}주차 (${formatDate(week4Start)}~${formatDate(week4End)})`;
})() }}"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="304d3"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="{{ var_brand_code.value == '01' }}"
      key="week_5_sale_qty"
      label="{{ (() => {
  const now = new Date();
  
  const currentDay = now.getDay();
  const daysToMonday = currentDay === 0 ? -6 : 1 - currentDay;
  const thisMonday = new Date(now.getTime() + daysToMonday * 24 * 60 * 60 * 1000);
  
  const week1Start = new Date(
    currentDay === 1 
      ? thisMonday.getTime() - 7 * 24 * 60 * 60 * 1000 
      : thisMonday.getTime()
  );
  
  const week5Start = new Date(week1Start.getTime() - 4 * 7 * 24 * 60 * 60 * 1000); // week_1에서 4주 전
  const week5End = new Date(week5Start.getTime() + 6 * 24 * 60 * 60 * 1000);
  
  const formatDate = (date) => {
    const month = date.getMonth() + 1;
    const day = date.getDate();
    return `${month}/${day}`;
  };
  
  const getMonthAndWeek = (date) => {
    const month = date.getMonth() + 1;
    const year = date.getFullYear();
    const firstDayOfMonth = new Date(year, date.getMonth(), 1);
    const firstMonday = new Date(firstDayOfMonth);
    while (firstMonday.getDay() !== 1) {
      firstMonday.setDate(firstMonday.getDate() + 1);
    }
    const daysSinceFirstMonday = Math.floor((date.getTime() - firstMonday.getTime()) / (24 * 60 * 60 * 1000));
    const weekNumber = Math.floor(daysSinceFirstMonday / 7) + 1;
    return { month, weekNumber };
  };
  
  const { month, weekNumber } = getMonthAndWeek(week5Start);
  
  return `${month}월 ${weekNumber}주차 (${formatDate(week5Start)}~${formatDate(week5End)})`;
})() }}"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="3a7f7"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="{{ var_brand_code.value == '01' }}"
      key="week_6_sale_qty"
      label="{{ (() => {
  const now = new Date();
  
  const currentDay = now.getDay();
  const daysToMonday = currentDay === 0 ? -6 : 1 - currentDay;
  const thisMonday = new Date(now.getTime() + daysToMonday * 24 * 60 * 60 * 1000);
  
  const week1Start = new Date(
    currentDay === 1 
      ? thisMonday.getTime() - 7 * 24 * 60 * 60 * 1000 
      : thisMonday.getTime()
  );
  
  const week6Start = new Date(week1Start.getTime() - 5 * 7 * 24 * 60 * 60 * 1000); // week_1에서 5주 전
  const week6End = new Date(week6Start.getTime() + 6 * 24 * 60 * 60 * 1000);
  
  const formatDate = (date) => {
    const month = date.getMonth() + 1;
    const day = date.getDate();
    return `${month}/${day}`;
  };
  
  const getMonthAndWeek = (date) => {
    const month = date.getMonth() + 1;
    const year = date.getFullYear();
    const firstDayOfMonth = new Date(year, date.getMonth(), 1);
    const firstMonday = new Date(firstDayOfMonth);
    while (firstMonday.getDay() !== 1) {
      firstMonday.setDate(firstMonday.getDate() + 1);
    }
    const daysSinceFirstMonday = Math.floor((date.getTime() - firstMonday.getTime()) / (24 * 60 * 60 * 1000));
    const weekNumber = Math.floor(daysSinceFirstMonday / 7) + 1;
    return { month, weekNumber };
  };
  
  const { month, weekNumber } = getMonthAndWeek(week6Start);
  
  return `${month}월 ${weekNumber}주차 (${formatDate(week6Start)}~${formatDate(week6End)})`;
})() }}"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="844f1"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="{{ var_brand_code.value == '01' }}"
      key="week_7_sale_qty"
      label="{{ (() => {
  const now = new Date();
  
  const currentDay = now.getDay();
  const daysToMonday = currentDay === 0 ? -6 : 1 - currentDay;
  const thisMonday = new Date(now.getTime() + daysToMonday * 24 * 60 * 60 * 1000);
  
  const week1Start = new Date(
    currentDay === 1 
      ? thisMonday.getTime() - 7 * 24 * 60 * 60 * 1000 
      : thisMonday.getTime()
  );
  
  const week7Start = new Date(week1Start.getTime() - 6 * 7 * 24 * 60 * 60 * 1000); // week_1에서 6주 전
  const week7End = new Date(week7Start.getTime() + 6 * 24 * 60 * 60 * 1000);
  
  const formatDate = (date) => {
    const month = date.getMonth() + 1;
    const day = date.getDate();
    return `${month}/${day}`;
  };
  
  const getMonthAndWeek = (date) => {
    const month = date.getMonth() + 1;
    const year = date.getFullYear();
    const firstDayOfMonth = new Date(year, date.getMonth(), 1);
    const firstMonday = new Date(firstDayOfMonth);
    while (firstMonday.getDay() !== 1) {
      firstMonday.setDate(firstMonday.getDate() + 1);
    }
    const daysSinceFirstMonday = Math.floor((date.getTime() - firstMonday.getTime()) / (24 * 60 * 60 * 1000));
    const weekNumber = Math.floor(daysSinceFirstMonday / 7) + 1;
    return { month, weekNumber };
  };
  
  const { month, weekNumber } = getMonthAndWeek(week7Start);
  
  return `${month}월 ${weekNumber}주차 (${formatDate(week7Start)}~${formatDate(week7End)})`;
})() }}"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="11494"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="{{ var_brand_code.value == '01' }}"
      key="week_8_sale_qty"
      label="{{ (() => {
  const now = new Date();
  
  const currentDay = now.getDay();
  const daysToMonday = currentDay === 0 ? -6 : 1 - currentDay;
  const thisMonday = new Date(now.getTime() + daysToMonday * 24 * 60 * 60 * 1000);
  
  const week1Start = new Date(
    currentDay === 1 
      ? thisMonday.getTime() - 7 * 24 * 60 * 60 * 1000 
      : thisMonday.getTime()
  );
  
  const week8Start = new Date(week1Start.getTime() - 7 * 7 * 24 * 60 * 60 * 1000); // week_1에서 7주 전
  const week8End = new Date(week8Start.getTime() + 6 * 24 * 60 * 60 * 1000);
  
  const formatDate = (date) => {
    const month = date.getMonth() + 1;
    const day = date.getDate();
    return `${month}/${day}`;
  };
  
  const getMonthAndWeek = (date) => {
    const month = date.getMonth() + 1;
    const year = date.getFullYear();
    const firstDayOfMonth = new Date(year, date.getMonth(), 1);
    const firstMonday = new Date(firstDayOfMonth);
    while (firstMonday.getDay() !== 1) {
      firstMonday.setDate(firstMonday.getDate() + 1);
    }
    const daysSinceFirstMonday = Math.floor((date.getTime() - firstMonday.getTime()) / (24 * 60 * 60 * 1000));
    const weekNumber = Math.floor(daysSinceFirstMonday / 7) + 1;
    return { month, weekNumber };
  };
  
  const { month, weekNumber } = getMonthAndWeek(week8Start);
  
  return `${month}월 ${weekNumber}주차 (${formatDate(week8Start)}~${formatDate(week8End)})`;
})() }}"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="d3ff9"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="{{ var_brand_code.value == '01' }}"
      key="week_9_sale_qty"
      label="{{ (() => {
  const now = new Date();
  
  const currentDay = now.getDay();
  const daysToMonday = currentDay === 0 ? -6 : 1 - currentDay;
  const thisMonday = new Date(now.getTime() + daysToMonday * 24 * 60 * 60 * 1000);
  
  const week1Start = new Date(
    currentDay === 1 
      ? thisMonday.getTime() - 7 * 24 * 60 * 60 * 1000 
      : thisMonday.getTime()
  );
  
  const week9Start = new Date(week1Start.getTime() - 8 * 7 * 24 * 60 * 60 * 1000); // week_1에서 8주 전
  const week9End = new Date(week9Start.getTime() + 6 * 24 * 60 * 60 * 1000);
  
  const formatDate = (date) => {
    const month = date.getMonth() + 1;
    const day = date.getDate();
    return `${month}/${day}`;
  };
  
  const getMonthAndWeek = (date) => {
    const month = date.getMonth() + 1;
    const year = date.getFullYear();
    const firstDayOfMonth = new Date(year, date.getMonth(), 1);
    const firstMonday = new Date(firstDayOfMonth);
    while (firstMonday.getDay() !== 1) {
      firstMonday.setDate(firstMonday.getDate() + 1);
    }
    const daysSinceFirstMonday = Math.floor((date.getTime() - firstMonday.getTime()) / (24 * 60 * 60 * 1000));
    const weekNumber = Math.floor(daysSinceFirstMonday / 7) + 1;
    return { month, weekNumber };
  };
  
  const { month, weekNumber } = getMonthAndWeek(week9Start);
  
  return `${month}월 ${weekNumber}주차 (${formatDate(week9Start)}~${formatDate(week9End)})`;
})() }}"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="2321c"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="{{ var_brand_code.value == '01' }}"
      key="week_10_sale_qty"
      label="{{ (() => {
  const now = new Date();
  
  const currentDay = now.getDay();
  const daysToMonday = currentDay === 0 ? -6 : 1 - currentDay;
  const thisMonday = new Date(now.getTime() + daysToMonday * 24 * 60 * 60 * 1000);
  
  const week1Start = new Date(
    currentDay === 1 
      ? thisMonday.getTime() - 7 * 24 * 60 * 60 * 1000 
      : thisMonday.getTime()
  );
  
  const week10Start = new Date(week1Start.getTime() - 9 * 7 * 24 * 60 * 60 * 1000); // week_1에서 9주 전
  const week10End = new Date(week10Start.getTime() + 6 * 24 * 60 * 60 * 1000);
  
  const formatDate = (date) => {
    const month = date.getMonth() + 1;
    const day = date.getDate();
    return `${month}/${day}`;
  };
  
  const getMonthAndWeek = (date) => {
    const month = date.getMonth() + 1;
    const year = date.getFullYear();
    const firstDayOfMonth = new Date(year, date.getMonth(), 1);
    const firstMonday = new Date(firstDayOfMonth);
    while (firstMonday.getDay() !== 1) {
      firstMonday.setDate(firstMonday.getDate() + 1);
    }
    const daysSinceFirstMonday = Math.floor((date.getTime() - firstMonday.getTime()) / (24 * 60 * 60 * 1000));
    const weekNumber = Math.floor(daysSinceFirstMonday / 7) + 1;
    return { month, weekNumber };
  };
  
  const { month, weekNumber } = getMonthAndWeek(week10Start);
  
  return `${month}월 ${weekNumber}주차 (${formatDate(week10Start)}~${formatDate(week10End)})`;
})() }}"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="ce0a7"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="{{ var_brand_code.value == '01' }}"
      key="week_11_sale_qty"
      label="{{ (() => {
  const now = new Date();
  
  const currentDay = now.getDay();
  const daysToMonday = currentDay === 0 ? -6 : 1 - currentDay;
  const thisMonday = new Date(now.getTime() + daysToMonday * 24 * 60 * 60 * 1000);
  
  const week1Start = new Date(
    currentDay === 1 
      ? thisMonday.getTime() - 7 * 24 * 60 * 60 * 1000 
      : thisMonday.getTime()
  );
  
  const week11Start = new Date(week1Start.getTime() - 10 * 7 * 24 * 60 * 60 * 1000); // week_1에서 10주 전
  const week11End = new Date(week11Start.getTime() + 6 * 24 * 60 * 60 * 1000);
  
  const formatDate = (date) => {
    const month = date.getMonth() + 1;
    const day = date.getDate();
    return `${month}/${day}`;
  };
  
  const getMonthAndWeek = (date) => {
    const month = date.getMonth() + 1;
    const year = date.getFullYear();
    const firstDayOfMonth = new Date(year, date.getMonth(), 1);
    const firstMonday = new Date(firstDayOfMonth);
    while (firstMonday.getDay() !== 1) {
      firstMonday.setDate(firstMonday.getDate() + 1);
    }
    const daysSinceFirstMonday = Math.floor((date.getTime() - firstMonday.getTime()) / (24 * 60 * 60 * 1000));
    const weekNumber = Math.floor(daysSinceFirstMonday / 7) + 1;
    return { month, weekNumber };
  };
  
  const { month, weekNumber } = getMonthAndWeek(week11Start);
  
  return `${month}월 ${weekNumber}주차 (${formatDate(week11Start)}~${formatDate(week11End)})`;
})() }}"
      placeholder="Enter value"
      position="center"
      size={100}
      summaryAggregationMode="none"
    />
    <Column
      id="ee4f4"
      alignment="right"
      editableOptions={{ showStepper: true }}
      format="decimal"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      hidden="{{ var_brand_code.value == '01' }}"
      key="week_12_sale_qty"
      label="{{ (() => {
  const now = new Date();
  
  const currentDay = now.getDay();
  const daysToMonday = currentDay === 0 ? -6 : 1 - currentDay;
  const thisMonday = new Date(now.getTime() + daysToMonday * 24 * 60 * 60 * 1000);
  
  const week1Start = new Date(
    currentDay === 1 
      ? thisMonday.getTime() - 7 * 24 * 60 * 60 * 1000 
      : thisMonday.getTime()
  );
  
  const week12Start = new Date(week1Start.getTime() - 11 * 7 * 24 * 60 * 60 * 1000); // week_1에서 11주 전
  const week12End = new Date(week12Start.getTime() + 6 * 24 * 60 * 60 * 1000);
  
  const formatDate = (date) => {
    const month = date.getMonth() + 1;
    const day = date.getDate();
    return `${month}/${day}`;
  };
  
  const getMonthAndWeek = (date) => {
    const month = date.getMonth() + 1;
    const year = date.getFullYear();
    const firstDayOfMonth = new Date(year, date.getMonth(), 1);
    const firstMonday = new Date(firstDayOfMonth);
    while (firstMonday.getDay() !== 1) {
      firstMonday.setDate(firstMonday.getDate() + 1);
    }
    const daysSinceFirstMonday = Math.floor((date.getTime() - firstMonday.getTime()) / (24 * 60 * 60 * 1000));
    const weekNumber = Math.floor(daysSinceFirstMonday / 7) + 1;
    return { month, weekNumber };
  };
  
  const { month, weekNumber } = getMonthAndWeek(week12Start);
  
  return `${month}월 ${weekNumber}주차 (${formatDate(week12Start)}~${formatDate(week12End)})`;
})() }}"
      placeholder="Enter value"
      position="center"
      size={100}
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
        pluginId="table8"
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
        pluginId="table8"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </ToolbarButton>
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
