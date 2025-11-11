<App>
  <Include src="./functions.rsx" />
  <Include src="./header.rsx" />
  <Frame
    id="$main"
    enableFullBleed={false}
    isHiddenOnDesktop={false}
    isHiddenOnMobile={false}
    padding="8px 12px"
    sticky={null}
    type="main"
  >
    <Include src="./src/container1.rsx" />
    <Spacer id="spacer1" />
    <Text
      id="text18"
      margin="4px 4px"
      value="**[받는 매장 조건]**"
      verticalAlign="center"
    />
    <Include src="./src/container6.rsx" />
    <Spacer id="spacer2" />
    <Text
      id="text5"
      margin="4px 4px"
      value="**[보내는 매장 조건]**"
      verticalAlign="center"
    />
    <Include src="./src/container5.rsx" />
    <Spacer id="spacer3" />
    <Spacer id="spacer4" />
    <Text
      id="text1"
      margin="0px 4px"
      value="###### 이동지시 대상 상품({{ rtListQuery.data?.length.toLocaleString() || 0}}개)"
      verticalAlign="center"
    />
    <Text
      id="text4"
      margin="0px 4px"
      value="###### 추천 매장 상세"
      verticalAlign="center"
    />
    <ListViewBeta
      id="toListView"
      data="{{ 
  rtListQuery.data.filter(
    item => item.shop_cd === selectedItem.value.shop_cd 
      && item.sty_cd === selectedItem.value.sty_cd 
      && item.col_cd === selectedItem.value.col_cd 
      && item.size_cd === selectedItem.value.size_cd
  )
}}"
      heightType="auto"
      hidden="false"
      itemWidth="200px"
      margin="0px 4px"
      numColumns={3}
      padding="0"
    >
      <Container
        id="container3"
        footerPadding="4px 12px"
        headerPadding="4px 12px"
        margin="4px 0px"
        padding="12px"
        showBody={true}
        showHeader={true}
      >
        <Header>
          <Text
            id="containerTitle3"
            margin="0"
            value="#### {{ item.shop_nm_b }}"
            verticalAlign="center"
          />
          <Text
            id="text21"
            margin="0"
            value="{{ item.shop_cd_b }}"
            verticalAlign="center"
          />
        </Header>
        <View id="54679" viewKey="View 1">
          <KeyValue
            id="keyValue3"
            data="{{ item }}"
            editIcon="bold/interface-edit-pencil"
            enableSaveActions={true}
            itemLabelPosition="top"
            labelWrap={true}
            margin="0"
          >
            <Property
              id="biz_cd"
              editable="false"
              editableOptions={{}}
              format="string"
              formatOptions={{}}
              hidden="true"
              label="Biz cd"
            />
            <Property
              id="br_cd"
              editable="false"
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              hidden="true"
              label="Br cd"
            />
            <Property
              id="tp_cd"
              editable="false"
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              hidden="true"
              label="Tp cd"
            />
            <Property
              id="tp_nm"
              editable="false"
              editableOptions={{}}
              format="string"
              formatOptions={{}}
              hidden="false"
              label="유통채널"
              valueOverride="{{ self.data.tp_nm_b }}({{ self.data.tp_cd_b }})"
            />
            <Property
              id="year_cd"
              editable="false"
              editableOptions={{}}
              format="string"
              formatOptions={{}}
              hidden="true"
              label="Year cd"
            />
            <Property
              id="shop_cd"
              editable="false"
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              hidden="true"
              label="Shop cd"
            />
            <Property
              id="shop_nm"
              editable="false"
              editableOptions={{}}
              format="string"
              formatOptions={{}}
              hidden="true"
              label="Shop nm"
            />
            <Property
              id="item"
              editable="false"
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              hidden="false"
              label="복종코드"
            />
            <Property
              id="season_cd"
              editable="false"
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              hidden="true"
              label="Season cd"
            />
            <Property
              id="sty_cd"
              editable="false"
              editableOptions={{}}
              format="string"
              formatOptions={{}}
              hidden="true"
              label="Sty cd"
            />
            <Property
              id="sty_nm"
              editable="false"
              editableOptions={{}}
              format="string"
              formatOptions={{}}
              hidden="true"
              label="Sty nm"
            />
            <Property
              id="col_cd"
              editable="false"
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              hidden="true"
              label="Col cd"
            />
            <Property
              id="col_nm"
              editable="false"
              editableOptions={{}}
              format="string"
              formatOptions={{}}
              hidden="true"
              label="Col nm"
            />
            <Property
              id="size_cd"
              editable="false"
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              hidden="true"
              label="Size cd"
            />
            <Property
              id="size_nm"
              editable="false"
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              hidden="true"
              label="Size nm"
            />
            <Property
              id="stock_qty"
              editable="false"
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              hidden="true"
              label="보유수량"
            />
            <Property
              id="days_after_in"
              editable="false"
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              hidden="true"
              label="Days after in"
            />
            <Property
              id="tot_sales_qty"
              editable="false"
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              hidden="true"
              label="Tot sales qty"
            />
            <Property
              id="tot_col_sales_qty"
              editable="false"
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              hidden="true"
              label="Tot col sales qty"
            />
            <Property
              id="tot_col_stock_qty"
              editable="false"
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              hidden="true"
              label="Tot col stock qty"
            />
            <Property
              id="lin_dt"
              editable="false"
              editableOptions={{}}
              format="date"
              formatOptions={{}}
              hidden="true"
              label="Lin dt"
            />
            <Property
              id="fsale_dt"
              editable="false"
              editableOptions={{}}
              format="string"
              formatOptions={{}}
              hidden="true"
              label="Fsale dt"
            />
            <Property
              id="sales_ratio"
              editable="false"
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              hidden="true"
              label="Sales ratio"
            />
            <Property
              id="tot_col_sales_ratio"
              editable="false"
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              hidden="true"
              label="Tot col sales ratio"
            />
            <Property
              id="tot_sty_sales_ratio"
              editable="false"
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              hidden="true"
              label="Tot sty sales ratio"
            />
            <Property
              id="tot_item_sales_ratio"
              editable="false"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              hidden="true"
              label="Tot item sales ratio"
            />
            <Property
              id="scaled_days_since_sale"
              editable="false"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              hidden="true"
              label="Scaled days since sale"
            />
            <Property
              id="scaled_tot_sales_qty"
              editable="false"
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              hidden="true"
              label="Scaled tot sales qty"
            />
            <Property
              id="scaled_tot_col_stock_qty"
              editable="false"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              hidden="true"
              label="Scaled tot col stock qty"
            />
            <Property
              id="B.sty_cd"
              editable="false"
              editableOptions={{}}
              format="string"
              formatOptions={{}}
              hidden="true"
              label="B sty cd"
            />
            <Property
              id="B.col_cd"
              editable="false"
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              hidden="true"
              label="B col cd"
            />
            <Property
              id="B.size_cd"
              editable="false"
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              hidden="true"
              label="B size cd"
            />
            <Property
              id="shop_cd_b"
              editable="false"
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              hidden="true"
              label="Shop cd b"
            />
            <Property
              id="shop_nm_b"
              editable="false"
              editableOptions={{}}
              format="string"
              formatOptions={{}}
              hidden="true"
              label="Shop nm b"
            />
            <Property
              id="stock_qty_b"
              editable="false"
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              hidden="false"
              label="재고수량"
            />
            <Property
              id="tot_col_stock_qty_b"
              editable="false"
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              hidden="false"
              label="동색상재고수량"
            />
            <Property
              id="tot_sales_qty_b"
              editable="false"
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              hidden="false"
              label="총판매수량"
            />
            <Property
              id="tot_col_sales_qty_b"
              editable="false"
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              hidden="false"
              label="동색상판매수량"
            />
            <Property
              id="lsale_dt_b"
              editable="false"
              editableOptions={{}}
              format="string"
              formatOptions={{}}
              hidden="false"
              label="최근판매일"
            />
            <Property
              id="sales_ratio_b"
              editable="false"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              hidden="false"
              label="동사이즈판매율"
            />
            <Property
              id="tot_col_sales_ratio_b"
              editable="false"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{
                showSeparators: true,
                notation: "standard",
                decimalPlaces: "1",
              }}
              hidden="false"
              label="동색상판매율"
            />
            <Property
              id="tot_sty_sales_ratio_b"
              editable="false"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{
                showSeparators: true,
                notation: "standard",
                decimalPlaces: "1",
              }}
              hidden="false"
              label="동상품판매율"
            />
            <Property
              id="tot_item_sales_ratio_b"
              editable="false"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{
                showSeparators: true,
                notation: "standard",
                decimalPlaces: "1",
              }}
              hidden="false"
              label="동복종판매율"
            />
            <Property
              id="scaled_days_since_sale_b"
              editable="false"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              hidden="false"
              label="Scaled days since sale b"
            />
            <Property
              id="scaled_tot_sales_qty_b"
              editable="false"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              hidden="false"
              label="Scaled tot sales qty b"
            />
            <Property
              id="scaled_tot_col_stock_qty_b"
              editable="false"
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              hidden="false"
              label="Scaled tot col stock qty b"
            />
            <Property
              id="sales_ratio_diff"
              editable="false"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              hidden="false"
              label="Sales ratio diff"
            />
            <Property
              id="tot_col_sales_ratio_diff"
              editable="false"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              hidden="false"
              label="Tot col sales ratio diff"
            />
            <Property
              id="tot_sty_sales_ratio_diff"
              editable="false"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              hidden="false"
              label="Tot sty sales ratio diff"
            />
            <Property
              id="tot_item_sales_ratio_diff"
              editable="false"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              hidden="false"
              label="Tot item sales ratio diff"
            />
            <Property
              id="scaled_days_since_sale_diff"
              editable="false"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              hidden="false"
              label="Scaled days since sale diff"
            />
            <Property
              id="scaled_tot_sales_qty_diff"
              editable="false"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              hidden="false"
              label="Scaled tot sales qty diff"
            />
            <Property
              id="scaled_tot_col_stock_qty_diff"
              editable="false"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              hidden="false"
              label="Scaled tot col stock qty diff"
            />
            <Property
              id="scaled_tot_col_sales_qty_diff"
              editable="false"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              hidden="false"
              label="Scaled tot col sales qty diff"
            />
            <Property
              id="tot_score"
              editable="false"
              editableOptions={{ showStepper: true }}
              format="tag"
              formatOptions={{ automaticColors: true }}
              hidden="false"
              label="추천 점수 (권장: 3이상)"
              valueOverride="{{ self.data.tot_score.toFixed(3) }}"
            />
            <Property
              id="rn"
              editable="false"
              editableOptions={{ showStepper: true }}
              format="tag"
              formatOptions={{
                automaticColors: false,
                color:
                  "{{ \n  item === 1 ? '#ffcccc' : \n  item === 2 ? '#ff9999' : \n  item === 3 ? '#ffcc99' : \n  item === 4 ? '#ffe699' : \n  '#ffffcc' \n}}",
              }}
              hidden="false"
              label="순위"
            />
            <Property
              id="tp_cd_b"
              editable="false"
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              hidden="true"
              label="Tp cd b"
            />
            <Property
              id="tp_nm_b"
              editable="false"
              editableOptions={{}}
              format="string"
              formatOptions={{}}
              hidden="true"
              label="Tp nm b"
            />
            <Property
              id="tot_rt_in_qty"
              editable="false"
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              hidden="true"
              label="Tot rt in qty"
            />
            <Property
              id="tot_rt_out_qty"
              editable="false"
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              hidden="true"
              label="Tot rt out qty"
            />
            <Property
              id="col_cnt"
              editable="false"
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              hidden="false"
              label="Col cnt"
            />
            <Property
              id="size_cnt"
              editable="false"
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              hidden="false"
              label="Size cnt"
            />
            <Property
              id="it"
              editable="false"
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              hidden="true"
              label="It"
            />
            <Property
              id="it_nm"
              editable="false"
              editableOptions={{}}
              format="string"
              formatOptions={{}}
              hidden="true"
              label="It nm"
            />
            <Property
              id="it_gb"
              editable="false"
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              hidden="true"
              label="It gb"
            />
            <Property
              id="it_gb_nm"
              editable="false"
              editableOptions={{}}
              format="string"
              formatOptions={{}}
              hidden="true"
              label="It gb nm"
            />
            <Property
              id="item_nm"
              editable="false"
              editableOptions={{}}
              format="string"
              formatOptions={{}}
              hidden="true"
              label="Item nm"
            />
            <Property
              id="inventory_qty"
              editable="false"
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              hidden="true"
              label="Inventory qty"
            />
            <Property
              id="fin_dt"
              editable="false"
              editableOptions={{}}
              format="date"
              formatOptions={{}}
              hidden="true"
              label="Fin dt"
            />
            <Property
              id="rt_dt"
              editable="false"
              editableOptions={{}}
              format="date"
              formatOptions={{}}
              hidden="true"
              label="Rt dt"
            />
            <Property
              id="lsale_dt"
              editable="false"
              editableOptions={{}}
              format="date"
              formatOptions={{}}
              hidden="true"
              label="Lsale dt"
            />
            <Property
              id="days_since_sale"
              editable="false"
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              hidden="true"
              label="Days since sale"
            />
            <Property
              id="min_days_since_sale"
              editable="false"
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              hidden="true"
              label="Min days since sale"
            />
            <Property
              id="max_days_since_sale"
              editable="false"
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              hidden="true"
              label="Max days since sale"
            />
            <Property
              id="tot_in_qty"
              editable="false"
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              hidden="true"
              label="Tot in qty"
            />
            <Property
              id="min_tot_sales_qty"
              editable="false"
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              hidden="true"
              label="Min tot sales qty"
            />
            <Property
              id="max_tot_sales_qty"
              editable="false"
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              hidden="true"
              label="Max tot sales qty"
            />
            <Property
              id="tot_col_in_qty"
              editable="false"
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              hidden="true"
              label="Tot col in qty"
            />
            <Property
              id="min_tot_col_sales_qty"
              editable="false"
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              hidden="true"
              label="Min tot col sales qty"
            />
            <Property
              id="max_tot_col_sales_qty"
              editable="false"
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              hidden="true"
              label="Max tot col sales qty"
            />
            <Property
              id="min_tot_col_stock_qty"
              editable="false"
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              hidden="true"
              label="Min tot col stock qty"
            />
            <Property
              id="max_tot_col_stock_qty"
              editable="false"
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              hidden="true"
              label="Max tot col stock qty"
            />
            <Property
              id="tot_sty_in_qty"
              editable="false"
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              hidden="true"
              label="Tot sty in qty"
            />
            <Property
              id="tot_sty_sales_qty"
              editable="false"
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              hidden="true"
              label="Tot sty sales qty"
            />
            <Property
              id="tot_sty_stock_qty"
              editable="false"
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              hidden="true"
              label="Tot sty stock qty"
            />
            <Property
              id="tot_item_in_qty"
              editable="false"
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              hidden="true"
              label="Tot item in qty"
            />
            <Property
              id="tot_item_sales_qty"
              editable="false"
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              hidden="true"
              label="Tot item sales qty"
            />
            <Property
              id="tot_item_stock_qty"
              editable="false"
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              hidden="true"
              label="Tot item stock qty"
            />
            <Property
              id="scaled_tot_col_sales_qty"
              editable="false"
              editableOptions={{ showStepper: true }}
              format="percent"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              hidden="true"
              label="Scaled tot col sales qty"
            />
            <Property
              id="scaled_tot_col_sales_qty_b"
              editable="false"
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              hidden="true"
              label="Scaled tot col sales qty b"
            />
            <Property
              id="days_since_out"
              editable="false"
              editableOptions={{}}
              format="string"
              formatOptions={{}}
              hidden="false"
              label="Days since out"
            />
            <Property
              id="rt_in_dt"
              editable="false"
              editableOptions={{}}
              format="string"
              formatOptions={{}}
              hidden="false"
              label="Rt in dt"
            />
            <Property
              id="rt_out_dt"
              editable="false"
              editableOptions={{}}
              format="string"
              formatOptions={{}}
              hidden="false"
              label="Rt out dt"
            />
            <Property
              id="rt_ratio"
              editable="false"
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              hidden="false"
              label="Rt ratio"
            />
            <Property
              id="sendQty"
              editable="false"
              editableOptions={{ showStepper: true }}
              format="decimal"
              formatOptions={{ showSeparators: true, notation: "standard" }}
              hidden="false"
              label="Send qty"
            />
          </KeyValue>
        </View>
      </Container>
    </ListViewBeta>
    <TextInput
      id="searchInput"
      label=""
      labelPosition="top"
      placeholder="매장이나 상품을 검색해 보세요"
      textBefore="검색창"
    />
    <ListViewBeta
      id="fromListView"
      _primaryKeys="{{ i }}"
      data="{{ rtListQuery.data }}"
      heightType="auto"
      itemWidth="200px"
      layoutType="grid"
      margin="0"
      numColumns="1"
      padding="0"
    >
      <Include src="./src/container4.rsx" />
    </ListViewBeta>
    <Button
      id="button1"
      loading="false"
      margin="2px 2px"
      style={{ ordered: [] }}
      submitTargetId=""
      text="엑셀 출력"
    >
      <Event
        enabled="{{ resultForExcel.value.length > 0 }}"
        event="click"
        method="exportData"
        params={{
          ordered: [
            { fileType: "xlsx" },
            { data: "{{ resultForExcel.value }}" },
            {
              fileName:
                "{{ bizSelect.value }}_RT_{{ new Date().toISOString().split('T')[0] }}",
            },
          ],
        }}
        pluginId=""
        type="util"
        waitMs="0"
        waitType="debounce"
      />
    </Button>
  </Frame>
</App>
