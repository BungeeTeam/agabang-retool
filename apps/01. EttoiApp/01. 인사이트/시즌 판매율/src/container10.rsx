<Container
  id="container10"
  footerPadding="4px 12px"
  headerPadding="4px 12px"
  padding="12px"
  showBody={true}
>
  <Header>
    <Text
      id="containerTitle8"
      value="#### Container title"
      verticalAlign="center"
    />
  </Header>
  <View id="a260c" viewKey="View 1">
    <Text
      id="text13"
      style={{ ordered: [] }}
      value="#### 시즌 판매율"
      verticalAlign="center"
    />
    <Container
      id="stack1"
      _gap="0px"
      _justify="end"
      _type="stack"
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      margin="0"
      padding="0"
      showBody={true}
      showBorder={false}
    >
      <View id="8af76" viewKey="View 1">
        <Select
          id="select_price_unit"
          emptyMessage="No options"
          hidden="true"
          itemMode="static"
          label=""
          labelPosition="top"
          overlayMaxHeight={375}
          placeholder="Select an option"
          showSelectionIndicator={true}
          textBefore="금액 단위"
          value="1000000"
        >
          <Option id="24370" label="백만원" value="1000000" />
          <Option id="10d0b" label="천원" value="1000" />
          <Option id="4a79c" label="원" value="1" />
        </Select>
        <Select
          id="season_select"
          data="{{ season_list_new.data }}"
          emptyMessage="No options"
          label=""
          labelPosition="top"
          labels="{{ item.year_sesn_nm_kor}}"
          overlayMaxHeight={375}
          placeholder="Select an option"
          showSelectionIndicator={true}
          textBefore="시즌선택"
          tooltipText="최근 30일간 판매 상승폭이 가장 큰 시즌이 기본으로 선택됩니다."
          value="{{ urlparams?.hash?.year_sesn_cd ?? get_latest_season.data[0] }}"
          values="{{ item.year_sesn_cd}}"
        >
          <Event
            event="change"
            method=""
            params={{ ordered: [] }}
            pluginId=""
            type="state"
            waitMs="0"
            waitType="debounce"
          />
        </Select>
        <Date
          id="date_select"
          dateFormat="yyyy-MM-dd"
          datePlaceholder="{{ self.dateFormat.toUpperCase() }}"
          iconBefore="bold/interface-calendar"
          label=""
          labelPosition="top"
          margin="4px 0px"
          textBefore="마감기준일"
          value="{{ urlparams.hash?.deadline_date ?? (() => { const yesterday = new Date(); yesterday.setDate(yesterday.getDate() - 1); return yesterday.toISOString().split('T')[0]; })() }}"
        >
          <Event
            event="change"
            method="trigger"
            params={{ ordered: [] }}
            pluginId="get_same_date"
            type="datasource"
            waitMs="0"
            waitType="debounce"
          />
          <Event
            event="change"
            method="trigger"
            params={{ ordered: [] }}
            pluginId="get_same_weekday"
            type="datasource"
            waitMs="0"
            waitType="debounce"
          />
          <Event
            event="change"
            method="trigger"
            params={{ ordered: [] }}
            pluginId="salesByColor"
            type="datasource"
            waitMs="0"
            waitType="debounce"
          />
          <Event
            event="change"
            method="trigger"
            params={{ ordered: [] }}
            pluginId="get_same_weekday_new"
            type="datasource"
            waitMs="0"
            waitType="debounce"
          />
        </Date>
      </View>
    </Container>
    <Text
      id="text14"
      margin="0"
      style={{
        ordered: [
          { fontSize: "11px" },
          { fontWeight: "400" },
          { fontFamily: "pretendard variable" },
        ],
      }}
      value="💡 대분류별 판매율을 확인하고 복종, 아이템, 매장까지 세부적으로 분석할 수 있습니다."
      verticalAlign="center"
    />
    <Container
      id="stack2"
      _gap="0px"
      _justify="end"
      _type="stack"
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      margin="0"
      padding="0"
      showBody={true}
      showBorder={false}
    >
      <View id="8af76" viewKey="View 1">
        <Switch
          id="inventory_columns_toggle"
          label="입출고 컬럼 숨기기"
          labelAlign="right"
          labelPosition="left"
          style={{
            ordered: [
              { checkedBackground: "#00a0e6" },
              { sharedLabelFontSize: "12px" },
              { sharedLabelFontWeight: "500" },
              { sharedLabelFontFamily: "pretendard variable" },
              { sharedLabel: "#464242" },
            ],
          }}
          value="{{ urlparams?.hash?.hide_columns ?? inventory_columns_toggle.value }}"
        >
          <Event
            event="change"
            method="trigger"
            params={{ ordered: [] }}
            pluginId="get_sales_data_cur"
            type="datasource"
            waitMs="0"
            waitType="debounce"
          />
        </Switch>
        <RadioGroup
          id="comparison_basis_select"
          data="{{ set_params_onLoad.data }}"
          groupLayout="wrap"
          itemMode="static"
          label="비교 기준:"
          labelAlign="right"
          labelWidth="20"
          style={{
            ordered: [
              { sharedLabelFontSize: "12px" },
              { sharedLabelFontWeight: "500" },
              { sharedLabelFontFamily: "pretendard variable" },
              { sharedLabel: "rgba(70, 66, 66, 1)" },
              { optionText: "#464242" },
              { checkedBackground: "#00a0e6" },
            ],
          }}
          value="{{ urlparams?.hash?.comparison_basis ?? self.data[0].value }}"
        >
          <Option
            id="01e9f"
            label="전년도 동일 요일 ({{ get_same_weekday_new.data.same_weekday }})"
            value="same_weekday"
          />
          <Option
            id="f1148"
            label="전년도 동일 날짜 ({{ get_same_weekday_new.data.same_date}})"
            value="same_date"
          />
        </RadioGroup>
        <DropdownButton
          id="dropdownButton1"
          _colorByIndex={["", "", ""]}
          _fallbackTextByIndex={["", "", ""]}
          _imageByIndex={["", "", ""]}
          _values={["", "", "Action 3"]}
          hidden=""
          icon="bold/interface-download-button-2"
          itemMode="static"
          overlayMaxHeight={375}
          style={{ ordered: [] }}
          styleVariant="outline"
          tooltipText="엑셀다운로드"
        >
          <Option
            id="b095d"
            label="대분류별"
            tooltip="대분류별 판매율 엑셀 다운로드"
          >
            <Event
              event="click"
              method="run"
              params={{
                ordered: [
                  {
                    src: 'large_cat_download.setHidden(false);\n\n// 100ms 정도 렌더링 대기\nawait new Promise(resolve => setTimeout(resolve, 100));\n\nawait large_cat_download.exportData({\n  fileName: `${season_select.selectedLabel}_대분류별_시즌판매율(${date_select.value} 마감)_${radioGroup1.selectedLabel}`,\n  fileType: "xlsx",\n  includeHiddenColumns: false\n});\n\nlarge_cat_download.setHidden(true);',
                  },
                ],
              }}
              pluginId=""
              type="script"
              waitMs="0"
              waitType="debounce"
            />
          </Option>
          <Option
            id="8f552"
            label="중분류별"
            tooltip="중분류별 판매율 엑셀 다운로드"
          >
            <Event
              event="click"
              method="run"
              params={{
                ordered: [
                  {
                    src: 'middle_cat_download.setHidden(false);\n\n// 100ms 정도 렌더링 대기\nawait new Promise(resolve => setTimeout(resolve, 100));\n\nawait middle_cat_download.exportData({\n  fileName: `${season_select.selectedLabel}_중분류별_시즌판매율(${date_select.value} 마감)_${radioGroup1.selectedLabel}`,\n  fileType: "xlsx",\n  includeHiddenColumns: false\n});\n\nmiddle_cat_download.setHidden(true);',
                  },
                ],
              }}
              pluginId=""
              type="script"
              waitMs="0"
              waitType="debounce"
            />
          </Option>
          <Option
            id="5bd64"
            disabled={false}
            hidden={false}
            label="증감대비"
            tooltip="판매율 증감대비 엑셀 다운로드"
          >
            <Event
              event="click"
              method="run"
              params={{
                ordered: [
                  {
                    src: 'comparison_large_cat_download.setHidden(false);\n\n// 100ms 정도 렌더링 대기\nawait new Promise(resolve => setTimeout(resolve, 100));\nseason_select.selectedLabel\nawait comparison_large_cat_download.exportData({\n  fileName: `${season_select.selectedLabel}_대분류별_시즌판매율_증감대비(${date_select.value} 마감)_${radioGroup1.selectedLabel}`,\n  fileType: "xlsx",\n  includeHiddenColumns: false\n});\n\ncomparison_large_cat_download.setHidden(true);\n\ncomparison_middle_cat_download.setHidden(false);\n\n// 100ms 정도 렌더링 대기\nawait new Promise(resolve => setTimeout(resolve, 100));\n\nawait comparison_middle_cat_download.exportData({\n  fileName: `${season_select.selectedLabel}_중분류별_시즌판매율_증감대비(${date_select.value} 마감)_${radioGroup1.selectedLabel}`,\n  fileType: "xlsx",\n  includeHiddenColumns: false\n});\n\ncomparison_middle_cat_download.setHidden(true);\n',
                  },
                ],
              }}
              pluginId=""
              type="script"
              waitMs="0"
              waitType="debounce"
            />
          </Option>
        </DropdownButton>
        <Container
          id="stack3"
          _direction="vertical"
          _flexWrap={true}
          _gap="0px"
          _type="stack"
          footerPadding="4px 12px"
          headerPadding="4px 12px"
          margin="0"
          padding="0"
          showBody={true}
          showBorder={false}
        >
          <View id="8c833" viewKey="View 1">
            <ToggleLink
              id="toggleLink1"
              text="{{ self.value ? '짝수 시즌 선택 열기' : '짝수 시즌 선택 닫기' }}"
              value="true"
            />
            <RadioGroup
              id="radioGroup1"
              hidden="{{ toggleLink1.value }}"
              itemMode="static"
              label=""
              labelPosition="top"
              value="{{ self.values[0] }}"
            >
              <Option
                id="2273d"
                label="시즌코드 {{ season_select.selectedItem.sesn_cd }}만 보기"
                value="odd"
              />
              <Option
                id="14e70"
                label="시즌코드 {{ Number(season_select.selectedItem.sesn_cd) + 1 }}만 보기"
                value="even"
              />
              <Option
                id="a3a97"
                label="시즌코드 {{ Number(season_select.selectedItem.sesn_cd) }}, {{ Number(season_select.selectedItem.sesn_cd) + 1 }} 함께 보기"
                value="both"
              />
              <Event
                event="change"
                method="trigger"
                params={{ ordered: [] }}
                pluginId="salesByColor"
                type="datasource"
                waitMs="0"
                waitType="debounce"
              />
            </RadioGroup>
          </View>
        </Container>
      </View>
    </Container>
  </View>
</Container>
