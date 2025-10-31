<ModalFrame
  id="tpModalFrame"
  footerPadding="8px 12px"
  headerPadding="8px 12px"
  hidden={true}
  hideOnEscape={true}
  isHiddenOnMobile={true}
  overlayInteraction={true}
  padding="8px 12px"
  showHeader={true}
  showOverlay={true}
  size="fullScreen"
>
  <Header>
    <Text
      id="revDetailByShopModal"
      value={
        '### {{ selectedRow.value?.tp_group_nm || selectedRow.value?.team_nm || (selectedRow.value?.user_nm + "님") || ""}} 매출 상세'
      }
      verticalAlign="center"
    />
    <Button
      id="modalCloseButton2"
      ariaLabel="Close"
      horizontalAlign="right"
      iconBefore="bold/interface-delete-1"
      style={{ ordered: [{ border: "transparent" }] }}
      styleVariant="outline"
    >
      <Event
        event="click"
        method="setHidden"
        params={{ ordered: [{ hidden: true }] }}
        pluginId="tpModalFrame"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        event="click"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="shopInfoQuery"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </Button>
    <Text
      id="text65"
      value={
        '{{ selectedRow.value?.tp_cd || selectedRow.value?.team_cd || selectedRow.value?.user_cd || ""}}'
      }
      verticalAlign="center"
    />
  </Header>
  <Body>
    <Text
      id="modalTitle4"
      value="#### 매장별 매출 현황({{ salesByShop.value.length }})"
      verticalAlign="center"
    />
    <Text
      id="text44"
      horizontalAlign="right"
      margin="4px 12px"
      value="단위: 백만원"
      verticalAlign="center"
    />
    <Table
      id="salesByShopTbl"
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ salesByShop.value }}"
      defaultFilterOperator="or"
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      emptyMessage="No rows found"
      enableSaveActions={true}
      groupByColumns={{}}
      heightType="auto"
      hidden=""
      margin="0"
      primaryKeyColumnId="b7f5c"
      rowBackgroundColor=""
      rowHeight="small"
      rowSelection="none"
      showBorder={true}
      showColumnBorders={true}
      showHeader={true}
      showSummaryRow={true}
      style={{ headerBackground: "#f5f5f5" }}
    >
      <Column
        id="b9bca"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        hidden="true"
        label="매장코드"
        placeholder="Enter value"
        position="center"
        referenceId="shop_cd"
        size={100}
        summaryAggregationMode="none"
        valueOverride={'{{ self.data[i]["shop_cd"] }}'}
      />
      <Column
        id="b7f5c"
        alignment="left"
        cellTooltip={'{{ self.data[i]["shop_cd"] }}'}
        cellTooltipMode="custom"
        editable="false"
        format="string"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="tp_nm"
        label="매장"
        optionList={{ mode: "manual" }}
        placeholder="Enter value"
        position="center"
        referenceId="shop_nm"
        size={191.765625}
        summaryAggregationMode="none"
        valueOverride={'{{ self.data[i]["shop_nm"] }}'}
      >
        <Event
          event="clickCell"
          method="run"
          params={{
            ordered: [
              {
                src: "utils.copyToClipboard(currentSourceRow.shop_cd)\n\nutils.showNotification({\n  title: '복사가 완료되었습니다.',\n  description: '매장코드가 클립보드에 복사되었습니다',\n  notificationType: 'success'\n    })",
              },
            ],
          }}
          pluginId=""
          type="script"
          waitMs="0"
          waitType="debounce"
        />
      </Column>
      <Column
        id="b17a1"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        key="2025"
        label="{{(thisYear.value).toString().slice(2)}}실적"
        placeholder="Enter value"
        position="center"
        referenceId="thisYearRev"
        size={124.3125}
        summaryAggregationMode="sum"
        valueOverride="{{ self.data[i][(thisYear.value).toString()]}}"
      >
        <Event
          event="clickCell"
          method="trigger"
          params={{ ordered: [] }}
          pluginId="testQuery"
          type="datasource"
          waitMs="0"
          waitType="debounce"
        />
      </Column>
      <Column
        id="a312d"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        label="{{(thisYear.value).toString().slice(2)}}목표"
        placeholder="Enter value"
        position="center"
        referenceId="thisYearTarget"
        size={76.3125}
        summaryAggregationMode="sum"
        valueOverride={
          '{{ self.data[i]["target_sales"] === 0 ? null: self.data[i]["target_sales"] }}'
        }
      />
      <Column
        id="b97a4"
        alignment="right"
        backgroundColor={'{{ item < 1 ? "rgba(237, 41, 57, 0.1)" : null }}'}
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "1",
        }}
        groupAggregationMode="average"
        label="목표달성율"
        placeholder="Enter value"
        position="center"
        referenceId="목표달성율"
        size={90.90625}
        summaryAggregationMode="none"
        valueOverride={
          '{{ self.data[i]["target_sales"] === 0 ? null : self.data[i][thisYear.value] / self.data[i]["target_sales"] }}'
        }
      />
      <Column
        id="b646b"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        label="목표차액"
        placeholder="Enter value"
        position="center"
        referenceId="목표차액"
        size={82.515625}
        summaryAggregationMode="sum"
        textColor={'{{ item > 0 ? "green" : "red" }}'}
        valueOverride={
          '{{ self.data[i]["2025"] - self.data[i]["target_sales"] }}'
        }
      />
      <Column
        id="8a9cb"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        key="2024"
        label="{{(thisYear.value-1).toString().slice(2)}}실적"
        placeholder="Enter value"
        position="center"
        referenceId="lastYearRev"
        size={121.3125}
        summaryAggregationMode="sum"
        valueOverride="{{ self.data[i][(thisYear.value-1).toString()]}}"
      />
      <Column
        id="36681"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "1",
        }}
        groupAggregationMode="average"
        label="{{(thisYear.value-1).toString().slice(2)}}대비신장율"
        placeholder="Enter value"
        position="center"
        referenceId="lastYearGrowthRate"
        size={91.453125}
        summaryAggregationMode="none"
        textColor={
          '{{ item > 0 ? "rgba(0, 128, 0, 1)" : "rgba(255, 0, 0, 1)" }}'
        }
        valueOverride="{{ self.data[i][(thisYear.value).toString()] / self.data[i][(thisYear.value-1).toString()] - 1 }}"
      />
      <Column
        id="e0872"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        label="{{(thisYear.value-1).toString().slice(2)}}대비신장액"
        placeholder="Enter value"
        position="center"
        referenceId="lastYearGrowth"
        size={89.453125}
        summaryAggregationMode="sum"
        valueOverride="{{ self.data[i][(thisYear.value).toString()] - self.data[i][(thisYear.value-1).toString()]}}"
      />
      <Column
        id="ba994"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        key="2023"
        label="{{(thisYear.value-2).toString().slice(2)}}실적"
        placeholder="Enter value"
        position="center"
        referenceId="yearBeforeLastRev"
        size={121.3125}
        summaryAggregationMode="sum"
        valueOverride="{{ self.data[i][(thisYear.value-2).toString()]}}"
      />
      <Column
        id="2783a"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "1",
        }}
        groupAggregationMode="average"
        label="{{(thisYear.value-2).toString().slice(2)}}대비신장율"
        placeholder="Enter value"
        position="center"
        referenceId="yearBeforeLastGrowthRate"
        size={89.453125}
        summaryAggregationMode="none"
        textColor={
          '{{ item > 0 ? "rgba(0, 128, 0, 1)" : "rgba(255, 0, 0, 1)" }}'
        }
        valueOverride="{{ self.data[i][(thisYear.value).toString()] / self.data[i][(thisYear.value-2).toString()] - 1 }}"
      />
      <Column
        id="cc18b"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        groupAggregationMode="sum"
        label="{{(thisYear.value-2).toString().slice(2)}}대비신장액"
        placeholder="Enter value"
        position="center"
        referenceId="yearBeforeLastGrowth"
        size={83.453125}
        summaryAggregationMode="sum"
        valueOverride="{{ self.data[i][(thisYear.value).toString()] - self.data[i][(thisYear.value-2).toString()]}}"
      />
      <ToolbarButton
        id="3c"
        icon="bold/interface-download-button-2"
        label="엑셀 다운로드"
        type="custom"
      >
        <Event
          event="clickToolbar"
          method="run"
          params={{
            ordered: [
              {
                src: 'const fileName = revDetailByShopModal.value.replace("매출 상세", "").trim()\n\nutils.changeLocale("ko")\nutils.exportData(salesByShop.value.map(obj => {\n  const newObj = {}\n  newObj["매장명"] = obj["shop_nm"]\n  newObj["매장코드"] = obj["shop_cd"]  \n  for (let year = thisYear.value; year >= thisYear.value -2; year--) {\n    newObj[`${year}년도`] = obj[year]\n\n    if (year === thisYear.value) {\n      newObj["목표매출"] = obj?.target_sales\n      newObj["목표차액"] = obj[year] - newObj["목표매출"]\n      newObj["목표달성률"] = obj[year] / newObj["목표매출"]\n    } else {\n      newObj[`${year}대비`] = (obj[thisYear.value] - obj[year]) / obj[year]\n      newObj[`${year}신장액`] =  obj[thisYear.value] - obj[year]   \n    }\n  }\n  return newObj\n}), fileName, "xlsx")',
              },
            ],
          }}
          pluginId=""
          type="script"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
    </Table>
  </Body>
</ModalFrame>
