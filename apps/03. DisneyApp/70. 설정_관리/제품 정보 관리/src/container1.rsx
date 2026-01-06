<Container
  id="container1"
  footerPadding="4px 12px"
  headerPadding="4px 12px"
  padding="12px"
  showBody={true}
>
  <View id="9139e" viewKey="View 1">
    <Text
      id="containerTitle1"
      value="##### 제품 정보 관리 (디즈니베이비)"
      verticalAlign="center"
    />
    <Text
      id="text1"
      value="MD팀에서 관리하는 제품 세부 정보를 관리합니다. 개별 항목은 아래 표에서 직접 변경할 수 있습니다. 각 항목위에 마우스 커서를 올리면, 각 항목의 의미와 사용 맥락을 확인할 수 있습니다."
      verticalAlign="center"
    />
    <Link
      id="link1"
      hidden="true"
      iconBefore="bold/interface-upload-button-2"
      text="엑셀 다운로드 후 대량 변경후 입력을 원하실 경우 대량변경을 이용해 주세요."
      textSize="default"
    >
      <Event
        event="click"
        method="show"
        params={{ ordered: [] }}
        pluginId="modalFrame_bulk_edit"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        event="click"
        method="setCurrentViewIndex"
        params={{ ordered: [{ viewIndex: "0" }] }}
        pluginId="steppedContainer1"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </Link>
    <Link id="link2" text="어떻게 사용하나요?">
      <Event
        event="click"
        method="show"
        params={{ ordered: [] }}
        pluginId="modalFrameTutorial"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </Link>
    <Spacer id="spacer1" />
    <Multiselect
      id="multiselect1"
      data="{{ season_list.data }}"
      emptyMessage="No options"
      label=""
      labelPosition="top"
      labels="{{ item.year_season_label }}"
      overlayMaxHeight={375}
      placeholder="Select options"
      showSelectionIndicator={true}
      textBefore="시즌 선택"
      value="{{ get_latest_seasons.data }}"
      values="{{ item.year_sesn_cd }}"
      wrapTags={true}
    />
    <TextInput
      id="search_text"
      iconBefore="bold/interface-search"
      label=""
      labelWidth="15
"
      placeholder="찾고싶은 검색어를 입력하세요"
    />
    <Button
      id="button6"
      iconBefore="bold/interface-content-save"
      text="변경사항 저장"
    >
      <Event
        event="click"
        method="trigger"
        params={{ ordered: [] }}
        pluginId="update_changes"
        type="datasource"
        waitMs="0"
        waitType="debounce"
      />
    </Button>
    <Button
      id="button8"
      iconBefore="bold/interface-upload-laptop"
      style={{ ordered: [{ background: "success" }] }}
      text="기획현황표"
    >
      <Event
        event="click"
        method="show"
        params={{ ordered: [] }}
        pluginId="modalFrame_production_upload"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        event="click"
        method="setCurrentViewIndex"
        params={{ ordered: [{ viewIndex: "0" }] }}
        pluginId="steppedContainer2"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </Button>
  </View>
</Container>
