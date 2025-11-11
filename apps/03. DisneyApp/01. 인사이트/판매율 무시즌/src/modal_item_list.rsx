<ModalFrame
  id="modal_item_list"
  footerPadding="8px 12px"
  headerPadding="8px 12px"
  hidden={true}
  hideOnEscape={true}
  isHiddenOnMobile={true}
  overlayInteraction={true}
  padding="0"
  showHeader={true}
  showOverlay={true}
  size="large"
>
  <Header>
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
      id="modalTitle2"
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
      value="{{ var_clicked_middle_cat.value.year_sesn_nm }}년 무시즌 / {{ var_clicked_middle_cat.value.cat_nm }} / {{ var_clicked_middle_cat.value.middle_cat }}"
      verticalAlign="center"
    />
  </Header>
  <Body>
    <Table
      id="table_item_list"
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ var_item_status_list.value }}"
      defaultSelectedRow={{ mode: "index", indexType: "display", index: "" }}
      emptyMessage="상품이 없습니다"
      enableSaveActions={true}
      heightType="auto"
      margin="0"
      primaryKeyColumnId="9cd90"
      rowBackgroundColor="{{ currentSourceRow.bg_color ?? 'white'  }}"
      rowHeight="large"
      showBorder={true}
      showHeader={true}
      style={{}}
      toolbarPosition="bottom"
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
        summaryAggregationMode="none"
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
        summaryAggregationMode="none"
        valueOverride={'{{ self.data[i]["col_nm"] }}'}
      />
      <Column
        id="9cd90"
        alignment="left"
        editable={false}
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
        summaryAggregationMode="none"
        valueOverride={'{{ self.data[i]["tot_in_qty"] }}'}
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
        summaryAggregationMode="none"
        valueOverride={'{{ self.data[i]["tot_inventory"] }}'}
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
        size={70.078125}
        summaryAggregationMode="none"
        valueOverride={'{{ self.data[i]["tot_sale_qty"] }}'}
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
        }}
        groupAggregationMode="average"
        key="sale_per_tot"
        label="판매율(%)"
        placeholder="Enter value"
        position="center"
        size={87}
        summaryAggregationMode="none"
        textColor="{{color_grad(item)}}"
        valueOverride={'{{ self.data[i]["qty_sales_ratio"] }}'}
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
        id="23f5a"
        alignment="left"
        editableOptions={{ showStepper: true }}
        format="html"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="average"
        key="sale_per_tot"
        placeholder="Enter value"
        position="center"
        size={80.984375}
        valueOverride={
          '<div style="width: 60px; height: 10px; background-color: #e6e6e6; border-radius:10px; margin: none; padding: none;">\n  <div style="width: {{Math.max(10, item * 60)}}px; height: 10px; background-color: {{item >= 0.8 ? "#CC3333" : "#888"}}; border-radius: 10px;"></div>\n</div>'
        }
      />
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
        summaryAggregationMode="none"
        valueOverride={
          '{{ self.data[i]["gini"]  === null ? null : Math.max(0, Math.round(((self.data[i]["gini"] - 0.3) / (0.7 - 0.3))*100)) }}'
        }
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
        formatOptions={{ automaticColors: false }}
        groupAggregationMode="average"
        key="online_sale_per"
        label="온라인비율(%)"
        placeholder="Select option"
        position="center"
        size={107}
        summaryAggregationMode="none"
        valueOverride={
          '{{ (self.data[i]["online_sales_ratio"]*100).toFixed(0) }}%'
        }
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
        hidden="true"
        key="sale_per_3m"
        label="3M"
        placeholder="Enter value"
        position="center"
        size={48}
        summaryAggregationMode="none"
        textColor="{{color_grad(item)}}"
      />
      <Column
        id="23a50"
        alignment="center"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="average"
        hidden="true"
        key="sale_per_6m"
        label="6M"
        placeholder="Enter value"
        position="center"
        size={54}
        summaryAggregationMode="none"
        textColor="{{color_grad(item)}}"
      />
      <Column
        id="25597"
        alignment="center"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="average"
        hidden="true"
        key="sale_per_12m"
        label="12M"
        placeholder="Enter value"
        position="center"
        size={48}
        summaryAggregationMode="none"
        textColor="{{color_grad(item)}}"
      />
      <Column
        id="f2b32"
        alignment="center"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="average"
        hidden="true"
        key="sale_per_18m"
        label="18M"
        placeholder="Enter value"
        position="center"
        size={48}
        summaryAggregationMode="none"
        textColor="{{color_grad(item)}}"
      />
      <Column
        id="91638"
        alignment="center"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="average"
        hidden="true"
        key="sale_per_2y"
        label="2Y"
        placeholder="Enter value"
        position="center"
        size={51}
        summaryAggregationMode="none"
        textColor="{{color_grad(item)}}"
      />
      <Column
        id="7b740"
        alignment="center"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="average"
        hidden="true"
        key="sale_per_3y"
        label="3Y"
        placeholder="Enter value"
        position="center"
        size={40}
        summaryAggregationMode="none"
        textColor="{{color_grad(item)}}"
      />
      <Column
        id="a6f95"
        alignment="center"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="average"
        hidden="true"
        key="sale_per_4y"
        label="4Y"
        placeholder="Enter value"
        position="center"
        size={53}
        summaryAggregationMode="none"
        textColor="{{color_grad(item)}}"
      />
      <Column
        id="40f19"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="average"
        hidden="true"
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
        id="5ca3d"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="average"
        hidden="true"
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
        hidden="true"
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
        id="0ba92"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="average"
        hidden="true"
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
        id="b04c0"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="average"
        hidden="true"
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
        hidden="true"
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
        hidden="true"
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
        hidden="true"
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
        hidden="true"
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
        hidden="true"
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
        hidden="true"
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
        hidden="true"
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
        id="8e1bd"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="average"
        hidden="true"
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
        id="c0814"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="average"
        hidden="true"
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
        id="3ac66"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="average"
        hidden="true"
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
        hidden="true"
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
        hidden="true"
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
        hidden="true"
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
        id="6ec73"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="average"
        hidden="true"
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
        hidden="true"
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
        hidden="true"
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
        hidden="true"
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
        id="850fd"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="average"
        hidden="true"
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
        hidden="true"
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
        size={73.796875}
        summaryAggregationMode="none"
        valueOverride={'{{ self.data[i]["tag_price"] }}'}
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
        key="tot_in_tag_amt"
        label="입고금액(천원)"
        placeholder="Enter value"
        position="center"
        referenceId="amount_received"
        size={105.140625}
        summaryAggregationMode="none"
        valueOverride={'{{ self.data[i]["tot_in_tag_amt"] / 1000 }}'}
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
        summaryAggregationMode="none"
        valueOverride={'{{ self.data[i]["tot_sale_amt"] / 1000 }}'}
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
        summaryAggregationMode="none"
        valueOverride={'{{ self.data[i]["amt_sales_ratio"] }}'}
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
        summaryAggregationMode="none"
        valueOverride={'{{ self.data[i]["return_ratio"] }}'}
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
      <Event
        event="clickCell"
        method="setValue"
        params={{ ordered: [{ value: "{{ currentSourceRow}}" }] }}
        pluginId="var_selected_item_info"
        type="state"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        event="clickCell"
        method="show"
        params={{ ordered: [] }}
        pluginId="drawerFrame1"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </Table>
  </Body>
</ModalFrame>
