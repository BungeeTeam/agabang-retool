<ModalFrame
  id="modalFrame2"
  footerPadding="8px 12px"
  headerPadding="8px 12px"
  hidden={true}
  hideOnEscape={true}
  isHiddenOnMobile={true}
  overlayInteraction={true}
  padding="8px 12px"
  showFooter={true}
  showHeader={true}
  showOverlay={true}
  size="large"
>
  <Header>
    <Text id="modalTitle2" value="### ⬆ 파일 업로드" verticalAlign="center" />
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
        pluginId="modalFrame2"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        event="click"
        method="clearValue"
        params={{ ordered: [] }}
        pluginId="upload_file_dropzone"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </Button>
  </Header>
  <Body>
    <Text
      id="text4"
      value="##### 📂 {{ sel_folder.value }}"
      verticalAlign="center"
    />
    <FileDropzone
      id="upload_file_dropzone"
      _isUpgraded={true}
      appendNewSelection={true}
      iconBefore="bold/programming-browser-search"
      label=""
      labelPosition="top"
      maxCount="100"
      placeholder="업로드할 사진을 끌어오거나 선택하세요"
      selectionType="multiple"
    >
      <Event
        event="parse"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="delete_image"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </FileDropzone>
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
        id="50286"
        alignment="center"
        format="string"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="name"
        label="파일명"
        placeholder="Enter value"
        position="center"
        size={168}
        summaryAggregationMode="none"
      >
        <Event
          event="clickCell"
          method="openUrl"
          params={{ ordered: [{ url: "{{ item }}" }] }}
          pluginId=""
          type="util"
          waitMs="0"
          waitType="debounce"
        />
      </Column>
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
        size={100}
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
        pluginId="s3_multi_upload"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </Button>
  </Body>
</ModalFrame>
