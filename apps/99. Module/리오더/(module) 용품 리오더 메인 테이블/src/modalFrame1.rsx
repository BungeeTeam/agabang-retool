<ModalFrame
  id="modalFrame1"
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
  size="medium"
>
  <Header>
    <Text id="modalTitle1" value="#### 최종 확인" verticalAlign="center" />
    <Button
      id="modalCloseButton1"
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
    <Text id="text1" value="###### [아이템 목록]" verticalAlign="center" />
    <Table
      id="table10"
      autoColumnWidth={true}
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ selectedReorderItems.value }}"
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      emptyMessage="No rows found"
      enableSaveActions={true}
      heightType="auto"
      rowHeight="medium"
      rowSelection="none"
      showHeader={true}
      toolbarPosition="bottom"
    >
      <Column
        id="a88b6"
        alignment="left"
        format="image"
        formatOptions={{
          showUnderline: "hover",
          underlineStyle: "solid",
          widthType: "fit",
        }}
        groupAggregationMode="none"
        key="이미지"
        label="이미지"
        placeholder="Enter value"
        position="center"
        size={47.109375}
        summaryAggregationMode="none"
        valueOverride="{{ item }}"
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
        id="207dc"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="sty_nm"
        label="품명"
        placeholder="Enter value"
        position="center"
        size={166.96875}
        summaryAggregationMode="none"
      />
      <Column
        id="9b427"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="sty_cd"
        label="품번"
        placeholder="Enter value"
        position="center"
        size={77.5625}
        summaryAggregationMode="none"
      />
      <Column
        id="c5020"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="col_nm"
        label="컬러"
        placeholder="Enter value"
        position="center"
        size={52.53125}
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
          pluginId="table10"
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
          pluginId="table10"
          type="widget"
          waitMs="0"
          waitType="debounce"
        />
      </ToolbarButton>
    </Table>
    <Multiselect
      id="multiselect1"
      captionByIndex="{{ item.email }}"
      data="{{ prodctionList.data }}"
      emptyMessage="No options"
      fallbackTextByIndex="{{ item.emp_name }}"
      iconBefore="bold/interface-user-multiple"
      iconByIndex=""
      imageByIndex=""
      label="생산 담당자 지정"
      labels="{{ item.emp_name }}"
      overlayMaxHeight={375}
      placeholder="담당자를 선택해주세요"
      showSelectionIndicator={true}
      style={{
        ordered: [
          { sharedLabelFontSize: "h6Font" },
          { sharedLabelFontWeight: "h6Font" },
          { sharedLabelFontFamily: "h6Font" },
        ],
      }}
      value="{{ localStorage.values.suppliesProduction ?? [] }}"
      values="{{ item.emp_cd }}"
      wrapTags={true}
    />
    <Text
      id="text2"
      disableMarkdown={true}
      value="* 생산 담당자 리스트에 찾으시는 담당자가 없을경우 DX팀에 인사정보 테이블의 최신화를 요청하세요! (팀 코드 'D290210'로 변경 요청)
수정된 담당자 정보는 익일부터 반영됩니다."
      verticalAlign="center"
    />
  </Body>
  <Footer>
    <Button
      id="button1"
      disabled="{{ (multiselect1.value).length === 0 }}"
      text="확인"
      tooltipText="{{ (multiselect1.value).length === 0 ? '생산 담당자를 지정해주세요' : '' }}"
    >
      <Event
        event="click"
        method="setValue"
        params={{
          ordered: [
            { key: "suppliesProduction" },
            { newValue: "{{ multiselect1.value }}" },
          ],
        }}
        pluginId=""
        type="localStorage"
        waitMs="0"
        waitType="debounce"
      />
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
        pluginId="insertReorderSimulationTargets"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        event="click"
        method="openUrl"
        params={{
          ordered: [
            {
              url: "{{ \n  var_brand_code.value === '01' \n  ? 'https://agabang.cleave.work/app/reorder_simulation_supplies_agabang' \n  : var_brand_code.value === '07' \n    ? 'https://agabang.cleave.work/app/reorder_simulation_supplies_ettoi'\n    : var_brand_code.value === '79'\n      ? 'https://agabang.cleave.work/app/reorder_simulation_supplies_disney'\n      : ''\n}}",
            },
            { options: { ordered: [{ newTab: true }] } },
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
        pluginId="sendTeamsAlert"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </Button>
  </Footer>
</ModalFrame>
