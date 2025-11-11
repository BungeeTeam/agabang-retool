<Container
  id="tabbedContainer2"
  currentViewKey="{{ self.viewKeys[0] }}"
  footerPadding="4px 12px"
  headerPadding="4px 12px"
  heightType="fixed"
  padding="12px"
  showBody={true}
>
  <View id="de7eb" label="제품 사진" viewKey="image">
    <Text
      id="containerTitle5"
      value="##### 품평 사진 관리"
      verticalAlign="center"
    />
    <Text
      id="text3"
      value={
        '업로드한 품평 사진을 폴더별로 살펴볼 수 있습니다. 좌측은 원본사진, 우측은 정사각형으로 자동변환된 사진입니다.\n상품명 대신 아래 메시지가 조회되면 조치가 필요합니다.\n- "기획현황에 이 품평코드가 없음": 엑셀에 해당 품평번호가 없음 → 엑셀 파일 확인 필요\n- "매핑된 상품 없음": 엑셀에 품평번호는 있지만 선택한 폴더(연도/시즌)와 불일치 → 다른 폴더에 업로드 필요'
      }
      verticalAlign="center"
    />
    <Button
      id="link2"
      heightType="auto"
      horizontalAlign="left"
      iconBefore="bold/interface-add-circle"
      style={{ ordered: [] }}
      text="품평사진 업로드"
    >
      <Event
        event="click"
        method="show"
        params={{ ordered: [] }}
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
    <Select
      id="sel_folder"
      data="{{ get_folder_list.data }}"
      emptyMessage="No options"
      iconBefore="bold/interface-file-folder"
      label=""
      labels="{{ item.extracted_path }} ({{ item.cnt }}개)"
      overlayMaxHeight={375}
      placeholder="Select an option"
      showSelectionIndicator={true}
      textBefore="폴더"
      value="{{ get_folder_list.data.extracted_path[0] }}"
      values="{{ item.extracted_path }}"
    >
      <Event
        event="change"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="get_image_list"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </Select>
    <TextInput
      id="search_text"
      iconBefore="bold/interface-search"
      label=""
      labelPosition="top"
      placeholder="품평번호, 스타일번호, 스타일명"
    >
      <Event
        event="submit"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="get_image_list"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </TextInput>
  </View>
  <View id="3dd61" label="품평회 사진 업로드" viewKey="upload">
    <FileDropzone
      id="fileDropzone2"
      _isUpgraded={true}
      appendNewSelection={true}
      iconBefore="bold/programming-browser-search"
      label=""
      labelPosition="top"
      placeholder="업로드할 사진을 끌어오거나 선택하세요"
      selectionType="multiple"
    />
    <Table
      id="table3"
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ fileDropzone2.value }}"
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
      id="button3"
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
  </View>
  <Event
    event="change"
    method="trigger"
    params={{ ordered: [] }}
    pluginId="get_season_month"
    type="datasource"
    waitMs="0"
    waitType="debounce"
  />
</Container>
