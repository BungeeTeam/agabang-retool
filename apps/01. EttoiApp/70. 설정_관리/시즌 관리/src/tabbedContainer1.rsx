<Container
  id="tabbedContainer1"
  currentViewKey="{{ self.viewKeys[0] }}"
  footerPadding="4px 12px"
  headerPadding="4px 12px"
  heightType="fixed"
  padding="12px"
  showBody={true}
>
  <View id="de7eb" label="제품 사진" viewKey="image">
    <Text id="containerTitle5" value="##### 시즌 관리" verticalAlign="center" />
    <Text
      id="text3"
      value="월별로 데이터를 살펴볼 시즌을 선택해 주세요. 선택한 정보에 맞춰서 엑셀파일이나 알림이 설정됩니다."
      verticalAlign="center"
    />
    <Button
      id="button7"
      iconBefore="bold/interface-content-save"
      text="저장하기"
    >
      <Event
        event="click"
        method="trigger"
        params={{
          ordered: [
            {
              options: {
                object: {
                  onSuccess: null,
                  onFailure: null,
                  additionalScope: null,
                },
              },
            },
          ],
        }}
        pluginId="update_chages"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </Button>
  </View>
  <View id="3dd61" label="품평회 사진 업로드" viewKey="upload">
    <FileDropzone
      id="fileDropzone1"
      _isUpgraded={true}
      appendNewSelection={true}
      iconBefore="bold/programming-browser-search"
      label=""
      labelPosition="top"
      placeholder="업로드할 사진을 끌어오거나 선택하세요"
      selectionType="multiple"
    />
    <Table
      id="table1"
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ fileDropzone1.value }}"
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
      id="button2"
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
