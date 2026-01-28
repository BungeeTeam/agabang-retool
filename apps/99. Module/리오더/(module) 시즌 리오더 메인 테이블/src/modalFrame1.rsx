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
    <Text id="modalTitle1" value="##### 최종 확인" verticalAlign="center" />
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
    <Text
      id="text1"
      value="###### [요청 아이템 리스트]"
      verticalAlign="center"
    />
    <Table
      id="table9"
      autoColumnWidth={true}
      cellSelection="none"
      clearChangesetOnSave={true}
      data="{{ getSelectedItems.data.map(i=>i.reference_info) }}"
      defaultSelectedRow={{ mode: "index", indexType: "display", index: 0 }}
      emptyMessage="No rows found"
      enableSaveActions={true}
      heightType="auto"
      rowHeight="medium"
      showBorder={true}
      showHeader={true}
      toolbarPosition="bottom"
    >
      <Column
        id="e47bc"
        alignment="left"
        format="image"
        formatOptions={{ widthType: "fit" }}
        groupAggregationMode="none"
        placeholder="Enter value"
        position="center"
        referenceId="image"
        size={516}
        summaryAggregationMode="none"
        valueOverride="{{ currentSourceRow.sty_cd?.length>0 ? `https://agabang-image.s3.ap-northeast-2.amazonaws.com/item_final/${currentSourceRow.sty_cd}${currentSourceRow.col_cd}.jpg` : null }}"
      />
      <Column
        id="f2e42"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="sty_nm"
        label="품명"
        placeholder="Enter value"
        position="center"
        size={127.015625}
        summaryAggregationMode="none"
      />
      <Column
        id="519a6"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="sty_cd"
        label="품번"
        placeholder="Enter value"
        position="center"
        size={75.8125}
        summaryAggregationMode="none"
      />
      <Column
        id="d77ee"
        alignment="left"
        format="string"
        groupAggregationMode="none"
        key="col_nm"
        label="컬러"
        placeholder="Enter value"
        position="center"
        size={56.40625}
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
          pluginId="table9"
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
          pluginId="table9"
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
      imageByIndex=""
      label="생산 담당자 선택"
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
      value="{{ localStorage.values.seasonProduction ?? [] }}"
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
    >
      <Event
        event="click"
        method="openUrl"
        params={{
          ordered: [
            {
              url: "{{ \n  var_brand_code.value === '01' \n  ? 'https://agabang.cleave.work/app/reorder_simulation_season_agabang' \n  : var_brand_code.value === '07' \n    ? 'https://agabang.cleave.work/app/reorder_simulation_season_ettoi'\n    : var_brand_code.value === '79'\n      ? 'https://agabang.cleave.work/app/reorder_simulation_season_disney'\n      : ''\n}}",
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
        pluginId="insertReorderSimulationTargets"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        event="click"
        method="setValue"
        params={{
          ordered: [
            { newValue: "{{ multiselect1.value }}" },
            { key: "seasonProduction" },
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
        params={{ ordered: [] }}
        pluginId="sendTeamsAlert"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        event="click"
        method="clearSelection"
        params={{ ordered: [] }}
        pluginId="table_main_list"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </Button>
  </Footer>
</ModalFrame>
