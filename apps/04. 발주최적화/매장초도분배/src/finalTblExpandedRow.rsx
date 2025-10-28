<ExpandedRow id="finalTblExpandedRow">
  <Table
    id="table8"
    cellSelection="none"
    clearChangesetOnSave={true}
    data={
      '{{ (() => {\n  const selectedData = shopPlan.value\n  .filter(obj => obj.shop_cd === selectedShop.value.shop_cd)\n  .filter(obj => obj.large_cat === selectedShop.value.large_cat)\n  .filter(obj => obj.middle_cat === selectedShop.value.middle_cat)\n  .filter(obj => obj.small_cat === selectedShop.value.small_cat)\n  const groupKeys = ["shop_cd", "shop_nm", "sty_cd", "col_cd", "related_info"]\n  const pivottedData = pivotData(selectedData, groupKeys, "size_cd", ["plan_qty"])\n  return pivottedData\n})()\n}}'
    }
    defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
    dynamicColumnFormatOptions={{ decimal: { ordered: [] } }}
    dynamicColumnProperties={{
      formatByIndex: "decimal",
      labelByIndex: "{{ item }}",
    }}
    dynamicColumnsEnabled={true}
    emptyMessage="No rows found"
    groupByColumns={{}}
    heightType="auto"
    margin="0"
    rowHeight="xsmall"
    rowSelection="none"
    showBorder={true}
    showHeader={true}
  >
    <Column
      id="a4c94"
      alignment="left"
      editableOptions={{ showStepper: true }}
      format="string"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      key="shop_cd"
      label="매장코드"
      placeholder="Enter value"
      position="center"
      size={100}
    />
    <Column
      id="151a3"
      alignment="left"
      format="string"
      formatOptions={{ automaticColors: true }}
      groupAggregationMode="none"
      key="shop_nm"
      label="매장명"
      placeholder="Enter value"
      position="center"
      size={145}
      valueOverride="{{ _.startCase(item) }}"
    />
    <Column
      id="84686"
      alignment="left"
      format="string"
      groupAggregationMode="none"
      key="sty_cd"
      label="스타일코드"
      placeholder="Enter value"
      position="center"
      size={100}
    />
    <Column
      id="f4e56"
      alignment="left"
      editableOptions={{ showStepper: true }}
      format="string"
      formatOptions={{ showSeparators: true, notation: "standard" }}
      groupAggregationMode="sum"
      key="col_cd"
      label="색상코드"
      placeholder="Enter value"
      position="center"
      size={100}
    />
    <Column
      id="182aa"
      alignment="left"
      format="json"
      groupAggregationMode="none"
      key="related_info"
      label="참고정보"
      placeholder="Enter value"
      position="center"
      size={247}
    />
  </Table>
</ExpandedRow>
