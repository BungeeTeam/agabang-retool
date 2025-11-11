<Container
  id="steppedContainer2"
  currentViewKey="{{ self.viewKeys[0] }}"
  footerPadding="4px 12px"
  headerPadding="4px 12px"
  heightType="fixed"
  padding="12px"
  showBody={true}
  showFooter={true}
  showHeader={true}
>
  <Header>
    <Steps
      id="steps2"
      horizontalAlign="center"
      itemMode="static"
      navigateContainer={true}
      showStepNumbers={true}
      targetContainerId="steppedContainer2"
      value="{{ self.values[0] }}"
    >
      <Option id="de72d" value="Step 1" />
      <Option id="438d8" value="Step 2" />
      <Option id="d4ad2" value="Step 3" />
    </Steps>
  </Header>
  <View id="bc563" label="파일 업로드" viewKey="Step 2">
    <Text
      id="text13"
      horizontalAlign="center"
      value="작업한 엑셀파일을 아래에 업로드하면 미리보기를 할 수 있습니다"
      verticalAlign="center"
    />
    <FileDropzone
      id="fileDropzone3"
      _isUpgraded={true}
      appendNewSelection={true}
      iconBefore="bold/programming-browser-search"
      label=""
      labelPosition="top"
      placeholder="여기를 눌러 파일을 선택"
    />
    <Button
      id="button10"
      iconBefore="bold/shopping-business-table"
      style={{ ordered: [{ background: "primary" }] }}
      text="미리보기"
    >
      <Event
        event="click"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="upload_production_file"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        event="click"
        method="showNotification"
        params={{
          ordered: [
            {
              options: {
                ordered: [
                  { notificationType: "info" },
                  { title: "파일 업로드 시작" },
                  {
                    description:
                      "파일 크기에 따라 처리 시간이 길어질수 있으니 기다려주세요...",
                  },
                  { duration: "3.0" },
                ],
              },
            },
          ],
        }}
        pluginId=""
        type="util"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        event="click"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="s3_upload_file"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </Button>
  </View>
  <View id="88574" label="미리보기" viewKey="Step 3">
    <Table
      id="production_table_temp"
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ production_temp_data.value }}"
      defaultSelectedRow={{ mode: "none", indexType: "display", index: 0 }}
      emptyMessage="No rows found"
      hidden=""
      rowHeight="small"
      rowSelection="none"
      showBorder={true}
      showFooter={true}
      showHeader={true}
      toolbarPosition="bottom"
    >
      <Column
        id="d9ccd"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="STY NO"
        label="Sty no"
        placeholder="Enter value"
        position="left"
        size={85.828125}
        summaryAggregationMode="none"
      />
      <Column
        id="29137"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="상품명"
        label="상품명"
        placeholder="Enter value"
        position="left"
        size={91.328125}
        summaryAggregationMode="none"
      />
      <Column
        id="92f77"
        alignment="left"
        editableOptions={{ showStepper: true }}
        format="string"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="품평NO"
        label="품평no"
        placeholder="Enter value"
        position="center"
        size={87.9375}
        summaryAggregationMode="none"
      />
      <Column
        id="b4a00"
        alignment="left"
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="성별"
        label="성별"
        placeholder="Select option"
        position="center"
        size={69.90625}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="4ba0f"
        alignment="left"
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="카테고리"
        label="카테고리"
        placeholder="Select option"
        position="center"
        size={83.515625}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="e22fd"
        alignment="left"
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="매핑카테고리"
        label="매핑카테고리"
        placeholder="Select option"
        position="center"
        size={78.28125}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="ffef6"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="아이템"
        label="아이템"
        placeholder="Enter value"
        position="center"
        size={78.28125}
        summaryAggregationMode="none"
      />
      <Column
        id="56417"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="매핑카테고리ID"
        label="매핑카테고리id"
        placeholder="Enter value"
        position="center"
        size={102.5625}
        summaryAggregationMode="none"
      />
      <Column
        id="3ba40"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="소재"
        label="소재"
        placeholder="Enter value"
        position="center"
        size={109.421875}
        summaryAggregationMode="none"
      />
      <Column
        id="0c3ae"
        alignment="left"
        format="string"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="생산지"
        label="생산지"
        placeholder="Enter value"
        position="center"
        size={47.125}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="05753"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="판가"
        label="판가"
        placeholder="Enter value"
        position="center"
        size={58.171875}
        summaryAggregationMode="none"
      />
      <Column
        id="80eb2"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="판가검토"
        label="판가검토"
        placeholder="Enter value"
        position="center"
        size={58.171875}
        summaryAggregationMode="none"
      />
      <Column
        id="c8884"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="샘플원가(-V)"
        label="샘플원가(-V)"
        placeholder="Enter value"
        position="center"
        size={144.84375}
        summaryAggregationMode="none"
      />
      <Column
        id="88755"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="2nd원가(V-)"
        label="2nd원가(-V)"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="2c978"
        alignment="left"
        format="string"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="납기"
        label="납기"
        placeholder="Enter value"
        position="center"
        size={43.59375}
        summaryAggregationMode="none"
      />
      <Column
        id="a27fb"
        alignment="left"
        format="string"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="조정납기"
        label="조정납기"
        placeholder="Enter value"
        position="center"
        size={57.515625}
        summaryAggregationMode="none"
      />
      <Column
        id="0e2b5"
        alignment="left"
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="디자이너"
        label="디자이너"
        placeholder="Select option"
        position="center"
        size={63.125}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="064f4"
        alignment="left"
        editableOptions={{ showStepper: true }}
        format="rating"
        formatOptions={{
          showSeparators: true,
          notation: "standard",
          size: "default",
          icons: "stars",
        }}
        groupAggregationMode="average"
        key="품평점수"
        label="품평점수"
        placeholder="Enter value"
        position="center"
        size={110.953125}
        summaryAggregationMode="none"
      />
      <Column
        id="62a81"
        alignment="left"
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="품평등급"
        label="품평등급"
        placeholder="Select option"
        position="center"
        size={57.515625}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="05c31"
        alignment="left"
        cellTooltipMode="overflow"
        format="multilineString"
        groupAggregationMode="none"
        key="품평의견"
        label="품평의견"
        placeholder="Enter value"
        position="center"
        size={417.84375}
        summaryAggregationMode="none"
      />
      <Column
        id="8c5a4"
        alignment="left"
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        hidden="false"
        key="컨셉"
        label="컨셉"
        placeholder="Select option"
        position="center"
        size={128.515625}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="d1d20"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="상태"
        label="상태"
        placeholder="Enter value"
        position="center"
        size={36.75}
        summaryAggregationMode="none"
      />
      <Column
        id="50be4"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="강제시즌"
        label="강제시즌"
        placeholder="Enter value"
        position="center"
        size={57.515625}
        summaryAggregationMode="none"
      />
      <Column
        id="4ba76"
        alignment="left"
        format="string"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="칼라1"
        label="칼라 1"
        placeholder="Enter value"
        position="center"
        size={93.40625}
        summaryAggregationMode="none"
      />
      <Column
        id="86bdc"
        alignment="left"
        editableOptions={{ showStepper: true }}
        format="string"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="칼라1수량"
        label="칼라 1 수량"
        placeholder="Enter value"
        position="center"
        size={72.03125}
        summaryAggregationMode="none"
      />
      <Column
        id="9184c"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="칼라2"
        label="칼라 2"
        placeholder="Enter value"
        position="center"
        size={54.671875}
        summaryAggregationMode="none"
      />
      <Column
        id="9d8a9"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="칼라2수량"
        label="칼라 2 수량"
        placeholder="Enter value"
        position="center"
        size={72.03125}
        summaryAggregationMode="none"
      />
      <Column
        id="6ef10"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="칼라3"
        label="칼라 3"
        placeholder="Enter value"
        position="center"
        size={47.90625}
        summaryAggregationMode="none"
      />
      <Column
        id="9b92d"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="칼라3수량"
        label="칼라 3 수량"
        placeholder="Enter value"
        position="center"
        size={72.03125}
        summaryAggregationMode="none"
      />
      <Column
        id="78c15"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="칼라4"
        label="칼라 4"
        placeholder="Enter value"
        position="center"
        size={47.90625}
        summaryAggregationMode="none"
      />
      <Column
        id="8966e"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="칼라4수량"
        label="칼라 4 수량"
        placeholder="Enter value"
        position="center"
        size={72.03125}
        summaryAggregationMode="none"
      />
      <Column
        id="8d253"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="칼라5"
        label="칼라 5"
        placeholder="Enter value"
        position="center"
        size={47.90625}
        summaryAggregationMode="none"
      />
      <Column
        id="34408"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="칼라5수량"
        label="칼라 5 수량"
        placeholder="Enter value"
        position="center"
        size={72.03125}
        summaryAggregationMode="none"
      />
      <Column
        id="a84e4"
        alignment="left"
        editableOptions={{ showStepper: true }}
        format="string"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="브랜드코드"
        label="브랜드코드"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="f5c9a"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="2nd원가(V-)"
        label="칼라 6"
        placeholder="Enter value"
        position="center"
        referenceId="칼라6"
        size={100}
        summaryAggregationMode="none"
      />
    </Table>
  </View>
  <View
    id="562fc"
    disabled={false}
    hidden={false}
    iconPosition="left"
    label="서비스 적용하기"
    viewKey="Step 4"
  >
    <Alert
      id="alert2"
      description={
        '{{ check_production_temp.data.length == 0 ? "아래 버튼을 누르시면 반영됩니다" : "아래 문제를 확인해 주세요"}}'
      }
      title={
        '{{ check_production_temp.data.length == 0 ? "검증완료" : "실패"}}'
      }
      type={'{{ check_production_temp.data.length == 0 ? "success" : "error"}}'}
    />
    <Button
      id="button11"
      hidden="{{ check_production_temp.data.length == 0 ? false : true}}"
      style={{ ordered: [] }}
      text="✅ 서비스 적용하기"
    >
      <Event
        event="click"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="update_production"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </Button>
    <Table
      id="table2"
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ check_item_info_temp.data }}"
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      emptyMessage="No rows found"
      enableSaveActions={true}
      hidden="{{ check_production_temp.data.length == 0 ? true : false }}"
      rowHeight="small"
      showBorder={true}
      showFooter={true}
      showHeader={true}
      toolbarPosition="bottom"
    >
      <Column
        id="5e449"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="sty_no"
        label="상품코드"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="d0119"
        alignment="left"
        format="string"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="msg"
        label="에러 메시지"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
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
          pluginId="table2"
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
          pluginId="table2"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
    </Table>
  </View>
  <Footer>
    <Button
      id="prevButton2"
      disabled="{{ steppedContainer2.currentViewIndex === 0 }}"
      iconBefore="bold/interface-arrows-left-alternate"
      styleVariant="outline"
      text="이전"
    >
      <Event
        event="click"
        method="showPreviousVisibleView"
        params={{ ordered: [{ wrap: false }] }}
        pluginId="steppedContainer2"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </Button>
    <Button
      id="nextButton2"
      disabled="{{ (steppedContainer2.currentViewIndex + 1 === steppedContainer2.viewKeys.length) || !production_table_temp.data?.length }}"
      iconAfter="bold/interface-arrows-right-alternate"
      text="다음"
    >
      <Event
        event="click"
        method="showNextVisibleView"
        params={{ ordered: [{ wrap: false }] }}
        pluginId="steppedContainer2"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </Button>
  </Footer>
</Container>
