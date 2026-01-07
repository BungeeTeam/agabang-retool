<App>
  <Include src="./functions.rsx" />
  <DocumentTitle id="$customDocumentTitle" value="영업" />
  <Include src="./header.rsx" />
  <Include src="./src/modalFrame1.rsx" />
  <Frame
    id="$main"
    enableFullBleed={false}
    isHiddenOnDesktop={false}
    isHiddenOnMobile={false}
    padding="8px 12px"
    sticky={null}
    style={{ ordered: [{ canvas: "surfacePrimary" }] }}
    type="main"
  >
    <Image
      id="image1"
      fit="contain"
      heightType="fixed"
      horizontalAlign="center"
      margin="0"
      src="https://agabang-image.s3.ap-northeast-2.amazonaws.com/logo/agabangandcompany_en_logo.png"
    />
    <Container
      id="stack1"
      _flexWrap={true}
      _gap="5px"
      _justify="center"
      _type="stack"
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      margin="0"
      padding="0"
      showBody={true}
      showBorder={false}
    >
      <View id="4e677" viewKey="View 1">
        <TextInput
          id="search_text"
          iconAfter="bold/interface-search"
          label=""
          labelPosition="top"
          margin="0"
          placeholder="매장명이나 매장코드로 검색해보세요"
          showClear={true}
          style={{ ordered: [{ borderRadius: "40px" }] }}
        />
        <Select
          id="select1"
          data={
            '{{\n(() => {\n  const seen = new Set();\n  let result = shopInfoQuery\n    .data\n    .filter(item => {\n      const key = `${item.biz_cd}-${item.biz_nm}`;\n      if (seen.has(key)) return false;\n      seen.add(key);\n      return true;\n  })\n\n  result.unshift({biz_cd: "-1", biz_nm: "사업부 전체"})\n\n  return result\n})()\n}}'
          }
          emptyMessage="No options"
          fallbackTextByIndex="{{ item.biz_cd }}"
          iconAfter="bold/interface-text-formatting-filter-2-alternate"
          label=""
          labelPosition="top"
          labels="{{ item.biz_nm }}"
          margin="0"
          overlayMaxHeight={375}
          placeholder="Select an option"
          showSelectionIndicator={true}
          style={{ ordered: [{ borderRadius: "40px" }] }}
          value="'-1'"
          values="{{ item.biz_cd }}"
        />
      </View>
    </Container>
    <Table
      id="table1"
      actionsOverflowPosition={1}
      autoColumnWidth={true}
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ getShopList.data }}"
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      emptyMessage="검색한 매장이 없습니다"
      enableSaveActions={true}
      hidden="{{ search_text.value ? false : true }}"
      margin="0px 18px 4px 18px"
      primaryKeyColumnId="e08bb"
      rowBackgroundColor=""
      rowHeight="large"
      rowSelection="none"
      showHeader={true}
      toolbarPosition="bottom"
    >
      <Column
        id="84dd2"
        alignment="left"
        editable="false"
        editableOptions={{ showStepper: true }}
        format="string"
        formatOptions={{ showSeparators: true, notation: "standard" }}
        groupAggregationMode="sum"
        key="shop_cd"
        label="매장코드"
        placeholder="Enter value"
        position="center"
        size={57.96875}
        summaryAggregationMode="none"
      />
      <Column
        id="4fdcd"
        alignment="center"
        caption="{{ currentSourceRow.shop_cd }}"
        format="string"
        groupAggregationMode="none"
        key="shop_nm"
        label="매장명"
        placeholder="Enter value"
        position="center"
        size={164.203125}
        summaryAggregationMode="none"
      />
      <Column
        id="d55f2"
        alignment="center"
        format="string"
        formatOptions={{ automaticColors: true }}
        groupAggregationMode="none"
        key="biz_nm"
        label="사업부"
        placeholder="Enter value"
        position="center"
        referenceId="biz_nm"
        size={78.21875}
        summaryAggregationMode="none"
      />
      <Column
        id="11c46"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="biz_cd"
        placeholder="Enter value"
        position="center"
        size={31.515625}
        summaryAggregationMode="none"
      />
      <Column
        id="e08bb"
        alignment="left"
        editable={false}
        format="string"
        groupAggregationMode="none"
        hidden="true"
        key="idx"
        label="Idx"
        placeholder="Enter value"
        position="center"
        size={100}
        summaryAggregationMode="none"
      />
      <Action
        id="ad524"
        icon="bold/interface-link-circle-alternate"
        label="매장상세 이동"
      >
        <Event
          event="clickAction"
          method="openApp"
          params={{
            ordered: [
              {
                options: {
                  ordered: [
                    { newTab: true },
                    { queryParams: [] },
                    {
                      hashParams: [
                        {
                          ordered: [
                            { key: "searchText" },
                            { value: "{{ currentSourceRow.shop_cd }}" },
                          ],
                        },
                        {
                          ordered: [
                            { key: "bizMultiSelect" },
                            {
                              value:
                                "{{ JSON.stringify([currentSourceRow.biz_cd])}}",
                            },
                          ],
                        },
                      ],
                    },
                  ],
                },
              },
              { uuid: "88f62050-fb37-11ef-9dfc-47aabcf5b8e0" },
            ],
          }}
          pluginId=""
          type="util"
          waitMs="0"
          waitType="debounce"
        />
      </Action>
      <Event
        event="clickRow"
        method="openApp"
        params={{
          ordered: [
            {
              options: {
                ordered: [
                  { queryParams: [] },
                  {
                    hashParams: [
                      {
                        ordered: [
                          { key: "searchText" },
                          { value: "{{ currentSourceRow.shop_cd }}" },
                        ],
                      },
                      {
                        ordered: [
                          { key: "bizMultiSelect" },
                          {
                            value:
                              "{{ JSON.stringify([currentSourceRow.biz_cd])}}",
                          },
                        ],
                      },
                    ],
                  },
                  { newTab: true },
                ],
              },
            },
            { uuid: "88f62050-fb37-11ef-9dfc-47aabcf5b8e0" },
          ],
        }}
        pluginId=""
        type="util"
        waitMs="0"
        waitType="debounce"
      />
    </Table>
  </Frame>
</App>
