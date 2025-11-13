<ModalFrame
  id="modal_item_list"
  enableFullBleed={true}
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
      id="modalTitle1"
      heightType="fixed"
      margin="0"
      style={{
        ordered: [
          { fontSize: "16px" },
          { fontWeight: "600" },
          { fontFamily: "Pretendard variable" },
        ],
      }}
      value="[상세 아이템 리스트]"
      verticalAlign="center"
    />
    <Button
      id="modalCloseButton1"
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
        pluginId="modal_item_list"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </Button>
    <Text
      id="text17"
      margin="0"
      style={{
        ordered: [
          { fontSize: "20px" },
          { fontWeight: "500" },
          { fontFamily: "pretendard variable" },
        ],
      }}
      value="{{ var_clicked_middle_cat.value.year_nm }}년 {{ var_clicked_middle_cat.value.season_nm }} / {{ var_clicked_middle_cat.value.large_cat }} / {{ var_clicked_middle_cat.value.middle_cat }}"
      verticalAlign="center"
    />
    <Text
      id="text18"
      disableMarkdown={true}
      horizontalAlign="right"
      style={{
        ordered: [
          { fontSize: "12px" },
          { fontWeight: "500" },
          { fontFamily: "pretendard variable" },
        ],
      }}
      value="* 조회기간: ~ {{date_select.value  }}"
      verticalAlign="center"
    />
  </Header>
  <Body>
    <Table
      id="table_item_list"
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ formatDataAsArray(salesByColor.data).filter(i=>i.year_cd === var_clicked_middle_cat.value.year_cd  
  && i.large_cat === var_clicked_middle_cat.value.large_cat 
  && i.it === var_clicked_middle_cat.value.it 
  && i.middle_cat === var_clicked_middle_cat.value.middle_cat
  && i.cat_group === var_clicked_middle_cat.value.cat_group
  && i.apparel_group === var_clicked_middle_cat.value.apparel_group)}}"
      defaultSelectedRow={{ mode: "index", indexType: "display", index: "" }}
      emptyMessage="상품이 없습니다"
      enableSaveActions={true}
      margin="0"
      rowBackgroundColor="{{ currentSourceRow.bg_color ?? 'white'  }}"
      rowHeight="large"
      showBorder={true}
      showFooter={true}
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
        valueOverride={'{{ self.data[i]["sty_nm"] }}'}
      >
        <Event
          event="clickCell"
          method={null}
          params={{ ordered: [] }}
          pluginId=""
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </Column>
      <Column
        id="f1ed0"
        alignment="center"
        format="string"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="small_cat"
        label="소분류"
        placeholder="Enter value"
        position="left"
        size={77}
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
        valueOverride={'{{ self.data[i]["col_nm"] }}'}
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
        size={66.078125}
        valueOverride="{{ item }}"
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
        referenceId="inven_qty"
        size={68.078125}
        valueOverride="{{ currentSourceRow.tot_in_qty-currentSourceRow.tot_sale_qty }}"
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
        size={70.078125}
        valueOverride="{{ item }}"
      />
      <Column
        id="e27d1"
        alignment="center"
        backgroundColor="{{ theme.canvas }}"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "1",
          padDecimal: true,
        }}
        groupAggregationMode="average"
        key="sale_per_tot"
        label="판매율 (수량)"
        placeholder="Enter value"
        position="center"
        referenceId="tot_sale_rate_tag"
        size={87}
        textColor="{{color_grad(item)}}"
        valueOverride="{{ currentSourceRow.tot_sale_qty/currentSourceRow.tot_in_qty }}"
      >
        <Event
          event="clickCell"
          method="exportData"
          params={{
            ordered: [{ fileType: "csv" }, { data: "{{ currentSourceRow. }}" }],
          }}
          pluginId=""
          type="util"
          waitMs="0"
          waitType="debounce"
        />
      </Column>
      <Column
        id="0da7a"
        alignment="center"
        editableOptions={{ showStepper: true }}
        format="tag"
        formatOptions={{ automaticColors: false }}
        groupAggregationMode="sum"
        key="shop_gini"
        label="매장편중"
        placeholder="Select option"
        position="center"
        size={73}
        valueOverride={
          '{{ self.data[i]["gini"]  === null ? null : Math.max(0, Math.round(((self.data[i]["gini"] - 0.3) / (0.7 - 0.3))*100)) }}'
        }
      />
      <Column
        id="d97ad"
        alignment="center"
        editableOptions={{ showStepper: true }}
        format="tag"
        formatOptions={{ automaticColors: false }}
        groupAggregationMode="average"
        key="online_sale_per"
        label="온라인비율(%)"
        placeholder="Select option"
        position="center"
        size={107}
        valueOverride={
          '{{ (self.data[i]["online_sales_ratio"]*100).toFixed(0) }}%'
        }
      />
      <Column
        id="03dab"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="tag_price"
        label="TAG가"
        placeholder="Enter value"
        position="center"
        referenceId="price_retail"
        size={73.796875}
        valueOverride="{{ item }}"
      />
      <Column
        id="e2efd"
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
        label="입고금액(천원)"
        placeholder="Enter value"
        position="center"
        referenceId="amount_received"
        size={105.140625}
        valueOverride="{{ item/1000 }}"
      />
      <Column
        id="493c8"
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
        label="판매금액(천원)"
        placeholder="Enter value"
        position="center"
        referenceId="amount_sold"
        size={111.140625}
        valueOverride="{{ item/ 1000 }}"
      />
      <Column
        id="68f0b"
        alignment="center"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "1",
        }}
        groupAggregationMode="average"
        key="sale_tag_per"
        label="판매율 (금액)"
        placeholder="Enter value"
        position="center"
        referenceId="ratio_sold_by_amount"
        size={133.625}
        valueOverride="{{ currentSourceRow.tot_sale_tag/currentSourceRow.tot_in_tag }}"
      />
      <Column
        id="a02ff"
        alignment="center"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "1",
        }}
        groupAggregationMode="average"
        key="sale_return_per"
        label="회수율"
        placeholder="Enter value"
        position="center"
        referenceId="ratio_return_on_funds"
        size={73.4375}
        valueOverride="{{ currentSourceRow.tot_sale_amt/currentSourceRow.tot_in_cost }}"
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
                    { fileName: "{{ modalTitle1.value }} {{ text17.value }}" },
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
      <ToolbarButton
        id="22a10"
        icon="bold/interface-text-formatting-filter-2"
        label="필터"
        type="filter"
      />
      <Event
        event="clickCell"
        method="setValue"
        params={{
          ordered: [{ value: "{{ table_item_list.selectedSourceRow }}" }],
        }}
        pluginId="var_item_info"
        type="state"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        event="clickCell"
        method="show"
        params={{ ordered: [] }}
        pluginId="drawerFrame_item_detail_new"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </Table>
  </Body>
</ModalFrame>
