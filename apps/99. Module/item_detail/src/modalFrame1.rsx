<ModalFrame
  id="modalFrame1"
  footerPadding="8px 12px"
  headerPadding="8px 12px"
  hidden={true}
  hideOnEscape={true}
  isHiddenOnMobile={true}
  overlayInteraction={true}
  padding="8px 12px"
  showHeader={true}
  showOverlay={true}
  size="large"
>
  <Header>
    <Text id="modalTitle2" value="### ⬆ 사진 업데이트" verticalAlign="center" />
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
        pluginId="modalFrame1"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </Button>
  </Header>
  <Body>
    <FileDropzone
      id="upload_file_dropzone"
      _isUpgraded={true}
      appendNewSelection={true}
      iconBefore="bold/programming-browser-search"
      label=""
      labelPosition="top"
      maxCount="100"
      placeholder="업로드할 사진을 끌어오거나 선택하세요"
    />
    <Table
      id="upload_list_table"
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ upload_file_dropzone.value }}"
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      emptyMessage="No rows found"
      enableSaveActions={true}
      rowHeight="medium"
      showBorder={true}
      showFooter={true}
      showHeader={true}
      toolbarPosition="bottom"
    >
      <Column
        id="7d860"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        label="브랜드"
        placeholder="Enter value"
        position="center"
        referenceId="brand"
        size={66}
        summaryAggregationMode="none"
        valueOverride="{{get_brand_and_season.data.brandName}}"
      />
      <Column
        id="543be"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        label="시즌"
        placeholder="Enter value"
        position="center"
        referenceId="season"
        size={85}
        summaryAggregationMode="none"
        valueOverride="{{ get_brand_and_season.data.seasonName }}"
      />
      <Column
        id="25938"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        label="품번"
        placeholder="Enter value"
        position="center"
        referenceId="style_code"
        size={156}
        summaryAggregationMode="none"
        valueOverride="{{ sel_sty.value.sty_cd+sel_sty.value.col_cd }}"
      />
      <Column
        id="dee89"
        alignment="center"
        format="tag"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="type"
        label="파일 종류"
        placeholder="Select option"
        position="center"
        size={102}
        summaryAggregationMode="none"
        valueOverride="{{ _.startCase(item) }}"
      />
      <Column
        id="76fb1"
        alignment="center"
        editableOptions={{ showStepper: true }}
        format="string"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="sizeBytes"
        label="크기"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
        valueOverride={
          '{{ item >= 1000000 ? (item / 1000000).toFixed(2) + " MB" : (item / 1000).toFixed(2) + " KB" }}'
        }
      />
    </Table>
    <Button
      id="button4"
      iconBefore="bold/interface-upload-button-2"
      text="업로드"
    >
      <Event
        event="click"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="s3_single_upload"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        enabled="{{s3_single_upload.finished}}"
        event="click"
        method="hide"
        params={{ ordered: [] }}
        pluginId="modalFrame1"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </Button>
  </Body>
</ModalFrame>
