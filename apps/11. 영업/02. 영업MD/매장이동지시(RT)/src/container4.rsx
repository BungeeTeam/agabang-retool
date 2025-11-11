<Container
  id="container4"
  _direction="vertical"
  _gap="0px"
  _justify="center"
  _type="stack"
  footerPadding="4px 12px"
  headerPadding="4px 12px"
  hoistFetching={true}
  margin="4px 4px"
  padding="8px"
  showBody={true}
  showHeader={true}
>
  <Header>
    <Image
      id="image1"
      heightType="fixed"
      horizontalAlign="center"
      margin="0px 4px"
      src="https://agabang-image.s3.ap-northeast-2.amazonaws.com/item_final/{{ item.sty_cd }}{{ item.col_cd }}.jpg"
      style={{ ordered: [] }}
    />
    <Text
      id="containerTitle4"
      margin="0px"
      value="###### {{ item.sty_nm }}"
      verticalAlign="center"
    />
    <Text
      id="containerTitle5"
      margin="0"
      style={{ ordered: [{ color: "rgba(0, 0, 0, 0.6)" }] }}
      value="{{ item.sty_cd }}"
      verticalAlign="center"
    />
    <Text
      id="containerTitle7"
      margin="0px"
      value="**색상 / 사이즈**"
      verticalAlign="center"
    />
    <Text
      id="containerTitle8"
      margin="4px 0px"
      value="{{ item.col_nm }} / {{ item.size_nm }}"
      verticalAlign="center"
    />
  </Header>
  <View id="79a48" viewKey="View 1">
    <Container
      id="stack1"
      _gap="0px"
      _type="stack"
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      margin="0"
      padding="0"
      showBody={true}
      showBorder={false}
    >
      <View id="47126" viewKey="View 1">
        <Icon
          id="icon1"
          horizontalAlign="center"
          icon="bold/interface-arrows-button-right"
          margin="4px 4px"
          style={{ ordered: [] }}
        >
          <Event
            event="click"
            method="setValue"
            params={{ ordered: [{ value: "{{ item }}" }] }}
            pluginId="selectedItem"
            type="state"
            waitMs="0"
            waitType="debounce"
          />
        </Icon>
        <KeyValue
          id="keyValue1"
          data="{
  매장명: {{ item.shop_nm_b }},
  매장코드: {{ item.shop_cd_b }}
}"
          editIcon="bold/interface-edit-pencil"
          enableSaveActions={true}
          itemLabelPosition="top"
          margin="0"
          minColumnWidth=""
          overflowType="hidden"
          style={{ hoverBackground: "tokens/9dc0c2b5" }}
        >
          <Property
            id="매장코드"
            editable="false"
            editableOptions={{ showStepper: true }}
            format="string"
            formatOptions={{}}
            hidden="false"
            label="매장코드"
          />
          <Property
            id="매장명"
            editable="false"
            editableOptions={{}}
            format="string"
            formatOptions={{}}
            hidden="false"
            label="매장명"
          />
          <Property
            id="재고수량"
            editable="false"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            hidden="false"
            label="재고수량"
          />
          <Property
            id="보유기간"
            editable="false"
            editableOptions={{ showStepper: true }}
            format="string"
            formatOptions={{}}
            hidden="false"
            label="보유기간"
          />
          <Property
            id="판매수량"
            editable="false"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            hidden="false"
            label="판매수량"
          />
          <Property
            id="판매율"
            editable="false"
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "0",
            }}
            hidden="false"
            label="판매율"
          />
        </KeyValue>
      </View>
    </Container>
    <Divider id="divider1" margin="4px 0px 8px 0px" />
    <Text
      id="text2"
      margin="0"
      value="###### 보내는 매장 정보"
      verticalAlign="center"
    />
    <Text
      id="text3"
      margin="0"
      value="###### ➡️ 받는 매장 정보"
      verticalAlign="center"
    />
    <KeyValue
      id="keyValue2"
      data={
        '{\n  매장명: {{ item.shop_nm }},\n  매장코드: {{ item.shop_cd }},\n  재고수량: {{ item.stock_qty }},\n  최근입고일자: {{ item.lin_dt + "(" + item.days_after_in + "일)"}},\n  보유기간: {{ item.days_after_in + "일" }},\n  판매수량: {{ item.tot_sales_qty || 0 }},\n  판매율: {{ item.sales_ratio || 0 }},\n  시즌RT입고수량: {{ item.tot_rt_in_qty }},\n  시즌RT출고수량: {{ item.tot_rt_out_qty }},\n}'
      }
      editIcon="bold/interface-edit-pencil"
      enableSaveActions={true}
      itemLabelPosition="top"
      labelWrap={true}
      margin="0"
      minColumnWidth=""
      style={{ hoverBackground: "tokens/9dc0c2b5" }}
    >
      <Property
        id="매장코드"
        editable="false"
        editableOptions={{ showStepper: true }}
        format="string"
        formatOptions={{}}
        hidden="false"
        label="매장코드"
      />
      <Property
        id="매장명"
        editable="false"
        editableOptions={{}}
        format="string"
        formatOptions={{}}
        hidden="false"
        label="매장명"
      />
      <Property
        id="재고수량"
        editable="false"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        hidden="false"
        label="재고수량"
      />
      <Property
        id="보유기간"
        editable="false"
        editableOptions={{ showStepper: true }}
        format="string"
        formatOptions={{}}
        hidden="true"
        label="보유기간"
      />
      <Property
        id="판매수량"
        editable="false"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        hidden="false"
        label="판매수량"
      />
      <Property
        id="판매율"
        editable="false"
        editableOptions={{ showStepper: true }}
        format="percent"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          decimalPlaces: "0",
        }}
        hidden="false"
        label="판매율"
      />
      <Property
        id="최근입고일"
        editable="false"
        editableOptions={{}}
        format="string"
        formatOptions={{}}
        hidden="false"
        label="최근입고일"
      />
      <Property
        id="최근입고일자"
        editable="false"
        editableOptions={{}}
        format="string"
        formatOptions={{}}
        hidden="false"
        label="최근입고일자(보유일)"
      />
      <Property
        id="시즌RT입고수량"
        editable="false"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        hidden="false"
        label="해당시즌RT입고수량"
      />
      <Property
        id="시즌RT출고수량"
        editable="false"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        hidden="false"
        label="해당시즌RT출고수량"
      />
    </KeyValue>
  </View>
</Container>
