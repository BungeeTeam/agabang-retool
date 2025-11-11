<Container
  id="collapsibleContainer1"
  footerPadding="4px 12px"
  headerPadding="4px 12px"
  hidden="{{ select_item_type.value === 'season' ? false : true }}"
  overflowType="hidden"
  padding="12px"
  showBody={true}
  showHeader={true}
>
  <Header>
    <Text
      id="collapsibleTitle1"
      value="##### 📈 {{sel_category.selectedItem.cat_nm}} 판매율 그래프"
      verticalAlign="center"
    />
    <ToggleButton
      id="collapsibleToggle1"
      horizontalAlign="right"
      iconForFalse="bold/interface-arrows-button-down"
      iconForTrue="bold/interface-arrows-button-up"
      iconPosition="replace"
      styleVariant="outline"
      text="{{ self.value ? 'Hide' : 'Show' }}"
      value="{{ collapsibleContainer1.showBody }}"
    >
      <Event
        event="change"
        method="setShowBody"
        params={{ ordered: [{ showBody: "{{ self.value }}" }] }}
        pluginId="collapsibleContainer1"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </ToggleButton>
  </Header>
  <View id="495d9" viewKey="View 1">
    <RadioGroup
      id="radioGroup1"
      groupLayout="wrap"
      itemMode="static"
      label=""
      labelPosition="top"
      value="{{ self.values[0] }}"
    >
      <Option id="9e98a" label="누적 판매" value="cum" />
      <Option
        id="7bd11"
        caption="{{ radioGroup1.value === 'weekly'? '단위: 수량-개/ 금액-백만원' : '' }}"
        label="주차별 판매"
        value="weekly"
      />
    </RadioGroup>
    <PlotlyChart
      id="chart4"
      chartType="line"
      data={include("../lib/chart4.data.json", "string")}
      dataseries={{
        ordered: [
          {
            0: {
              ordered: [
                { label: "22WT" },
                {
                  datasource:
                    '{{formatDataAsObject([{\n  "date" : "11/02",\n  "22WT": 3700,\n  "23WT": 4000\n}, {\n  "date" : "11/03",\n  "sales": 6000,\n  "spend": 3895\n}, {\n  "date" : "11/04",\n  "sales": 4500,\n  "spend": 5500\n}, {\n  "date" : "11/05",\n  "sales": 5230,\n  "spend": 4200\n}, {\n  "date" : "11/06",\n  "sales": 3701,\n  "spend": 4000\n}, {\n  "date" : "11/07",\n  "sales": 6001,\n  "spend": 3895\n}, {\n  "date" : "11/08",\n  "sales": 4501,\n  "spend": 5500\n}, {\n  "date" : "11/09",\n  "sales": 5231,\n  "spend": 4200\n}])[\'22WT\']}}',
                },
                { chartType: "line" },
                { aggregationType: "sum" },
                { color: "#1E3A8A" },
                { colors: { ordered: [] } },
                { visible: true },
                {
                  hovertemplate:
                    "<b>%{x}</b><br>%{fullData.name}: %{y}<extra></extra>",
                },
              ],
            },
          },
          {
            1: {
              ordered: [
                { label: "23WT" },
                {
                  datasource:
                    '{{formatDataAsObject([{\n  "date" : "11/02",\n  "22WT": 3700,\n  "23WT": 4000\n}, {\n  "date" : "11/03",\n  "sales": 6000,\n  "spend": 3895\n}, {\n  "date" : "11/04",\n  "sales": 4500,\n  "spend": 5500\n}, {\n  "date" : "11/05",\n  "sales": 5230,\n  "spend": 4200\n}, {\n  "date" : "11/06",\n  "sales": 3701,\n  "spend": 4000\n}, {\n  "date" : "11/07",\n  "sales": 6001,\n  "spend": 3895\n}, {\n  "date" : "11/08",\n  "sales": 4501,\n  "spend": 5500\n}, {\n  "date" : "11/09",\n  "sales": 5231,\n  "spend": 4200\n}])[\'23WT\']}}',
                },
                { chartType: "line" },
                { aggregationType: "sum" },
                { color: "#3170F9" },
                { colors: { ordered: [] } },
                { visible: true },
                {
                  hovertemplate:
                    "<b>%{x}</b><br>%{fullData.name}: %{y}<extra></extra>",
                },
              ],
            },
          },
        ],
      }}
      datasourceDataType="array"
      datasourceInputMode="javascript"
      datasourceJS={
        '[{\n  "date" : "11/02",\n  "22WT": 3700,\n  "23WT": 4000\n}, {\n  "date" : "11/03",\n  "sales": 6000,\n  "spend": 3895\n}, {\n  "date" : "11/04",\n  "sales": 4500,\n  "spend": 5500\n}, {\n  "date" : "11/05",\n  "sales": 5230,\n  "spend": 4200\n}, {\n  "date" : "11/06",\n  "sales": 3701,\n  "spend": 4000\n}, {\n  "date" : "11/07",\n  "sales": 6001,\n  "spend": 3895\n}, {\n  "date" : "11/08",\n  "sales": 4501,\n  "spend": 5500\n}, {\n  "date" : "11/09",\n  "sales": 5231,\n  "spend": 4200\n}]'
      }
      isJsonTemplateDirty={true}
      isLayoutJsonDirty={true}
      layout={include("../lib/chart4.layout.json", "string")}
      margin="0"
      skipDatasourceUpdate={true}
      xAxis={
        '{{formatDataAsObject([{\n  "date" : "11/02",\n  "22WT": 3700,\n  "23WT": 4000\n}, {\n  "date" : "11/03",\n  "sales": 6000,\n  "spend": 3895\n}, {\n  "date" : "11/04",\n  "sales": 4500,\n  "spend": 5500\n}, {\n  "date" : "11/05",\n  "sales": 5230,\n  "spend": 4200\n}, {\n  "date" : "11/06",\n  "sales": 3701,\n  "spend": 4000\n}, {\n  "date" : "11/07",\n  "sales": 6001,\n  "spend": 3895\n}, {\n  "date" : "11/08",\n  "sales": 4501,\n  "spend": 5500\n}, {\n  "date" : "11/09",\n  "sales": 5231,\n  "spend": 4200\n}]).date}}'
      }
      xAxisDropdown="date"
    />
    <SegmentedControl
      id="segment_cum_sale_type"
      itemMode="static"
      label=""
      labelPosition="top"
      paddingType="spacious"
      value="{{ self.values[0] }}"
    >
      <Option id="c1c3c" label="수량기준" value="sale_qty_per" />
      <Option id="5703d" label="Tag판매금액기준" value="sale_tag_amt_per" />
      <Option
        id="40ffc"
        disabled={false}
        iconPosition="left"
        label="실판매금액기준"
        value="sale_amt_per"
      />
    </SegmentedControl>
  </View>
</Container>
