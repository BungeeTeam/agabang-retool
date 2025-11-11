<Container
  id="steppedContainer1"
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
      id="steps1"
      horizontalAlign="center"
      itemMode="static"
      navigateContainer={true}
      showStepNumbers={true}
      targetContainerId="steppedContainer1"
      value="{{ self.values[0] }}"
    >
      <Option id="de72d" value="Step 1" />
      <Option id="438d8" value="Step 2" />
      <Option id="d4ad2" value="Step 3" />
    </Steps>
  </Header>
  <View id="ec83b" label="파일 다운로드" viewKey="Step 1">
    <Text
      id="text8"
      value="현재 제품 정보 전체를 엑셀파일로 다운로드합니다.
"
      verticalAlign="center"
    />
    <Button
      id="button3"
      iconBefore="bold/interface-download-circle-alternate"
      style={{ ordered: [{ background: "success" }] }}
      text="엑셀 다운로드"
    >
      <Event
        event="click"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="download_file"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </Button>
    <Text
      id="text10"
      horizontalAlign="right"
      style={{ ordered: [{ color: "rgba(13, 13, 13, 0.71)" }] }}
      value="이미 작업한 파일을 업로드 하시려면 다음으로 바로 넘어가세요 👇"
      verticalAlign="center"
    />
  </View>
  <View id="bc563" label="파일 업로드" viewKey="Step 2">
    <Text
      id="text9"
      horizontalAlign="center"
      value="작업한 엑셀파일을 아래에 업로드하면 미리보기를 할 수 있습니다"
      verticalAlign="center"
    />
    <FileDropzone
      id="fileDropzone2"
      _isUpgraded={true}
      appendNewSelection={true}
      iconBefore="bold/programming-browser-search"
      label=""
      labelPosition="top"
      placeholder="여기를 눌러 파일을 선택"
    />
    <Button
      id="button4"
      iconBefore="bold/shopping-business-table"
      style={{ ordered: [{ background: "primary" }] }}
      text="미리보기"
    >
      <Event
        event="click"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="upload_file"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </Button>
  </View>
  <View id="88574" label="미리보기" viewKey="Step 3">
    <Table
      id="item_table_temp"
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ item_info_temp_data.value }}"
      defaultSelectedRow={{ mode: "none", indexType: "display", index: 0 }}
      emptyMessage="No rows found"
      rowHeight="small"
      rowSelection="none"
      showBorder={true}
      showFooter={true}
      showHeader={true}
      toolbarPosition="bottom"
    >
      <Column
        id="b5768"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        hidden="true"
        label="Column 31"
        placeholder="Enter value"
        position="center"
        referenceId="colab_nm"
        size={80.109375}
        summaryAggregationMode="none"
      />
      <Column
        id="58c72"
        alignment="center"
        format="string"
        groupAggregationMode="none"
        key="품번(sty_cd)"
        label="품번(sty_cd)"
        placeholder="Enter value"
        position="center"
        size={85.609375}
        summaryAggregationMode="none"
      />
      <Column
        id="76f09"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="스타일명(sty_nm)"
        label="스타일명(sty_nm)"
        placeholder="Enter value"
        position="center"
        size={122.609375}
        summaryAggregationMode="none"
      />
      <Column
        id="b93b0"
        alignment="center"
        format="string"
        groupAggregationMode="none"
        key="품평회코드(preview_cd)"
        label="품평회코드(preview_cd)"
        placeholder="Enter value"
        position="center"
        size={144.875}
        summaryAggregationMode="none"
      />
      <Column
        id="78d46"
        alignment="center"
        format="string"
        groupAggregationMode="none"
        key="상태(status)"
        label="상태(status)"
        placeholder="Enter value"
        position="center"
        size={83.6875}
        summaryAggregationMode="none"
      />
      <Column
        id="9550f"
        alignment="center"
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="카테고리(cat_nm)"
        label="카테고리(cat_nm)"
        placeholder="Select option"
        position="center"
        size={111.703125}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="cdfc5"
        alignment="center"
        format="string"
        groupAggregationMode="none"
        key="아이템(item_raw_nm)"
        label="아이템(item_raw_nm)"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Column
        id="8e7ea"
        alignment="center"
        format="string"
        groupAggregationMode="none"
        key="성별(sex_nm)"
        label="성별(sex_nm)"
        placeholder="Enter value"
        position="center"
        size={92.53125}
        summaryAggregationMode="none"
      />
      <Column
        id="726ad"
        alignment="center"
        format="string"
        groupAggregationMode="none"
        key="시리즈(series)"
        label="시리즈(series)"
        placeholder="Enter value"
        position="center"
        size={92.78125}
        summaryAggregationMode="none"
      />
      <Column
        id="9af54"
        alignment="center"
        format="string"
        groupAggregationMode="none"
        key="소재(fabric)"
        label="소재(fabric)"
        placeholder="Enter value"
        position="center"
        size={81.015625}
        summaryAggregationMode="none"
      />
      <Column
        id="8251e"
        alignment="center"
        format="string"
        groupAggregationMode="none"
        key="생산처(prod_comp)"
        label="생산처(prod_comp)"
        placeholder="Enter value"
        position="center"
        size={124.328125}
        summaryAggregationMode="none"
      />
      <Column
        id="2f4b5"
        alignment="center"
        format="string"
        groupAggregationMode="none"
        key="생산국가(prod_country)"
        label="생산국가(prod_country)"
        placeholder="Enter value"
        position="center"
        size={147.65625}
        summaryAggregationMode="none"
      />
      <Column
        id="ace81"
        alignment="center"
        format="string"
        groupAggregationMode="none"
        key="납기일(deli_dt)"
        label="납기일(deli_dt)"
        placeholder="Enter value"
        position="center"
        size={97.90625}
        summaryAggregationMode="none"
      />
      <Column
        id="c3b75"
        alignment="center"
        format="string"
        groupAggregationMode="none"
        key="디자이너(designer_nm)"
        label="디자이너(designer_nm)"
        placeholder="Enter value"
        position="center"
        size={144.21875}
        summaryAggregationMode="none"
      />
      <Column
        id="f527e"
        alignment="left"
        format="rating"
        formatOptions={{ size: "default", icons: "stars" }}
        groupAggregationMode="none"
        key="품평 점수(preview_score)"
        label="품평 점수(preview_score)"
        placeholder="Enter value"
        position="center"
        size={156.125}
        summaryAggregationMode="none"
      />
      <Column
        id="4cf9a"
        alignment="center"
        format="string"
        groupAggregationMode="none"
        key="품평 등급(preview_grade)"
        label="품평 등급(preview_grade)"
        placeholder="Enter value"
        position="center"
        size={157.5}
        summaryAggregationMode="none"
      />
      <Column
        id="972ad"
        alignment="center"
        format="string"
        groupAggregationMode="none"
        key="품평의견(opinion)"
        label="품평의견(opinion)"
        placeholder="Enter value"
        position="center"
        size={110.984375}
        summaryAggregationMode="none"
      />
      <Column
        id="eba62"
        alignment="center"
        format="string"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="콜라보여부(colab_yn)"
        label="콜라보여부(colab_yn)"
        placeholder="Enter value"
        position="center"
        size={131.4375}
        summaryAggregationMode="none"
        valueOverride="{{ item }}"
      />
      <Column
        id="1a4dd"
        alignment="center"
        format="string"
        groupAggregationMode="none"
        key="콜라보명(colab_nm)"
        label="콜라보명(colab_nm)"
        placeholder="Enter value"
        position="center"
        size={124.953125}
        summaryAggregationMode="none"
      />
      <Column
        id="778b1"
        alignment="center"
        format="string"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="통계제외(stat_exclude_yn)"
        label="통계제외(stat_exclude_yn)"
        placeholder="Enter value"
        position="center"
        size={164.65625}
        summaryAggregationMode="none"
        valueOverride="{{ item }}"
      />
      <Column
        id="523e4"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="메모(memo)"
        label="메모(memo)"
        placeholder="Enter value"
        position="center"
        size={82.96875}
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
      id="alert1"
      description={
        '{{ check_item_info_temp.data.length == 0 ? "아래 버튼을 누르시면 반영됩니다" : "아래 문제를 확인해 주세요"}}'
      }
      title={'{{ check_item_info_temp.data.length == 0 ? "검증완료" : "실패"}}'}
      type={'{{ check_item_info_temp.data.length == 0 ? "success" : "error"}}'}
    />
    <Button
      id="button5"
      hidden="{{ check_item_info_temp.data.length == 0 ? false : true}}"
      style={{ ordered: [] }}
      text="✅ 서비스 적용하기"
    >
      <Event
        event="click"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="query_backup_item_info"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </Button>
    <Table
      id="table1"
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ check_item_info_temp.data }}"
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      emptyMessage="No rows found"
      enableSaveActions={true}
      hidden="{{ check_item_info_temp.data.length == 0 ? true : false }}"
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
          pluginId="table1"
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
          pluginId="table1"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
    </Table>
  </View>
  <Footer>
    <Button
      id="prevButton1"
      disabled="{{ steppedContainer1.currentViewIndex === 0 }}"
      iconBefore="bold/interface-arrows-left-alternate"
      styleVariant="outline"
      text="이전"
    >
      <Event
        event="click"
        method="showPreviousVisibleView"
        params={{ ordered: [{ wrap: false }] }}
        pluginId="steppedContainer1"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </Button>
    <Button
      id="nextButton1"
      disabled="{{ steppedContainer1.currentViewIndex + 1 === steppedContainer1.viewKeys.length }}"
      iconAfter="bold/interface-arrows-right-alternate"
      text="다음"
    >
      <Event
        event="click"
        method="showNextVisibleView"
        params={{ ordered: [{ wrap: false }] }}
        pluginId="steppedContainer1"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </Button>
  </Footer>
</Container>
