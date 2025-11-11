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
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      emptyMessage="No rows found"
      enableSaveActions={true}
      hidden=""
      rowHeight="small"
      showBorder={true}
      showFooter={true}
      showHeader={true}
      toolbarPosition="bottom"
    >
      <Column
        id="c1992"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="품번"
        label="품번"
        placeholder="Enter value"
        position="center"
        size={85.859375}
        summaryAggregationMode="none"
      />
      <Column
        id="0cb1e"
        alignment="left"
        format="json"
        groupAggregationMode="none"
        key="품평번호"
        label="품평번호"
        placeholder="Enter value"
        position="center"
        size={90.375}
        summaryAggregationMode="none"
      />
      <Column
        id="f7195"
        alignment="left"
        cellTooltipMode="overflow"
        format="multilineString"
        groupAggregationMode="none"
        key="소재세부"
        label="소재세부"
        placeholder="Enter value"
        position="center"
        size={170.765625}
        summaryAggregationMode="none"
      />
      <Column
        id="4d5fa"
        alignment="left"
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="성별"
        label="성별"
        placeholder="Select option"
        position="center"
        size={42.375}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="65e2b"
        alignment="left"
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="대분류"
        label="대분류"
        placeholder="Select option"
        position="center"
        size={73.515625}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="f0782"
        alignment="left"
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="중분류"
        label="중분류"
        placeholder="Select option"
        position="center"
        size={84.765625}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="d5bf7"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="소분류"
        label="소분류"
        placeholder="Enter value"
        position="center"
        size={85.515625}
        summaryAggregationMode="none"
      />
      <Column
        id="79ab0"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="예상TAG가(원)"
        label="예상tag가 원"
        placeholder="Enter value"
        position="center"
        size={100.34375}
        summaryAggregationMode="none"
      />
      <Column
        id="1f9e6"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="확정TAG가(원)"
        label="확정tag가 원"
        placeholder="Enter value"
        position="center"
        size={98.34375}
        summaryAggregationMode="none"
      />
      <Column
        id="b88e6"
        alignment="left"
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="디자이너"
        label="디자이너"
        placeholder="Select option"
        position="center"
        size={63.140625}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="1e054"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="MD제안납기"
        label="Md제안납기"
        placeholder="Enter value"
        position="center"
        size={89.640625}
        summaryAggregationMode="none"
      />
      <Column
        id="99672"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="확정납기"
        label="확정납기"
        placeholder="Enter value"
        position="center"
        size={67.515625}
        summaryAggregationMode="none"
      />
      <Column
        id="c7cde"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="매핑카테고리ID"
        label="매핑카테고리id"
        placeholder="Enter value"
        position="center"
        size={106.578125}
        summaryAggregationMode="none"
      />
      <Column
        id="2f513"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="매핑카테고리"
        label="매핑카테고리"
        placeholder="Enter value"
        position="center"
        size={78.28125}
        summaryAggregationMode="none"
      />
      <Column
        id="6be57"
        alignment="left"
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="색상"
        label="색상"
        placeholder="Select option"
        position="center"
        size={98.046875}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="85786"
        alignment="right"
        editableOptions={{ showStepper: true }}
        format="decimal"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="기획량"
        label="기획량"
        placeholder="Enter value"
        position="center"
        size={58.171875}
        summaryAggregationMode="none"
      />
      <Column
        id="ad6a2"
        alignment="left"
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="색상2"
        label="색상2"
        placeholder="Select option"
        position="center"
        size={88}
        summaryAggregationMode="none"
      />
      <Column
        id="b9c66"
        alignment="left"
        editableOptions={{ showStepper: true }}
        format="string"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="기획량2"
        label="발주수량2"
        placeholder="Enter value"
        position="center"
        size={66}
        summaryAggregationMode="none"
      />
      <Column
        id="e096b"
        alignment="left"
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="색상3"
        label="색상3"
        placeholder="Select option"
        position="center"
        size={87}
        summaryAggregationMode="none"
      />
      <Column
        id="e11cc"
        alignment="left"
        editableOptions={{ showStepper: true }}
        format="string"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="기획량3"
        label="발주수량3"
        placeholder="Enter value"
        position="center"
        size={80}
        summaryAggregationMode="none"
      />
      <Column
        id="247bc"
        alignment="left"
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="색상4"
        label="색상4"
        placeholder="Select option"
        position="center"
        size={68}
        summaryAggregationMode="none"
      />
      <Column
        id="c8e66"
        alignment="left"
        editableOptions={{ showStepper: true }}
        format="string"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="기획량4"
        label="발주수량4"
        placeholder="Enter value"
        position="center"
        size={72}
        summaryAggregationMode="none"
      />
      <Column
        id="248bd"
        alignment="left"
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="색상5"
        label="색상5"
        placeholder="Select option"
        position="center"
        size={89}
        summaryAggregationMode="none"
      />
      <Column
        id="0d528"
        alignment="left"
        editableOptions={{ showStepper: true }}
        format="string"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="기획량5"
        label="발주수량5"
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
          pluginId="production_table_temp"
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
          pluginId="production_table_temp"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
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
      <Event
        event="click"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="query_get_info"
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
