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
    <Chart
      id="chart4"
      chartType="plotlyJson"
      plotlyDataJson="{{ radioGroup1.value === 'cum' ? get_cum_sales_by_day.data[segment_cum_sale_type.value] : get_cum_sales_by_week.data[segment_cum_sale_type.value]}}"
      plotlyLayoutJson={
        '{{ radioGroup1.value === \'cum\' ? {\n  // 누적 차트 레이아웃 (기존 유지)\n  "title": {\n    "text": "",\n    "font": {\n      "color": "#3D3D3D",\n      "size": 16\n    }\n  },\n  "font": {\n    "family": "var(--default-font, var(--sans-serif))",\n    "color": "#979797"\n  },\n  "showlegend": true,\n  "legend": {\n    "xanchor": "left",\n    "x": 1,\n    "y": 0.5,\n    "orientation": "v"\n  },\n  "margin": {\n    "l": 50,\n    "r": 50,\n    "t": 30,\n    "b": 50,  // 누적 차트는 하단 여백 줄임\n    "pad": 2\n  },\n  "hovermode": "closest",\n  "hoverlabel": {\n    "bgcolor": "#000",\n    "bordercolor": "#000",\n    "font": {\n      "color": "#fff",\n      "family": "var(--default-font, var(--sans-serif))",\n      "size": 12\n    }\n  },\n  "clickmode": "select+event",\n  "dragmode": "select",\n  "xaxis": {\n    "title": {\n      "text": "월 일",\n      "standoff": 6,\n      "font": {\n        "size": 12\n      }\n    },\n    "type": "category",\n    "categoryorder": "array",\n    "categoryarray": get_cum_sales_by_day.data.xCategories,\n    "tickmode": "linear",\n    "dtick": 30,\n    "automargin": true,\n    "fixedrange": true,\n    "gridcolor": "#fff",\n    "zerolinecolor": "#fff",\n    "range": get_cum_sales_by_day.data.xRange\n  },\n  "yaxis": {\n    "title": {\n      "text": "판매율(%)",\n      "standoff": 6,\n      "font": {\n        "size": 12\n      }\n    },\n    "type": "linear",\n    "tickformat": "",\n    "automargin": true,\n    "fixedrange": true,\n    "zerolinecolor": "#DEDEDE",\n    "autorange": true,\n    "rangemode": "tozero"\n  }\n} \n: {\n  // 주간 차트 레이아웃\n  "title": {\n    "text": "",\n    "font": {\n      "color": "#3D3D3D",\n      "size": 16\n    }\n  },\n  "font": {\n    "family": "var(--default-font, var(--sans-serif))",\n    "color": "#979797"\n  },\n  "showlegend": true,\n  "legend": {\n    "xanchor": "left",\n    "x": 1,\n    "y": 0.5,\n    "orientation": "v"\n  },\n  "margin": {\n    "l": 50,\n    "r": 50,\n    "t": 30,\n    "b": 100,  // 주간 차트는 x축 라벨 회전으로 하단 여백 유지\n    "pad": 2\n  },\n  "hovermode": "closest",\n  "hoverlabel": {\n    "bgcolor": "#000",\n    "bordercolor": "#000",\n    "font": {\n      "color": "#fff",\n      "family": "var(--default-font, var(--sans-serif))",\n      "size": 12\n    }\n  },\n  "clickmode": "select+event",\n  "dragmode": "select",\n  "xaxis": {\n    "title": {\n      "text": "기간",\n      "standoff": 6,\n      "font": {\n        "size": 12\n      }\n    },\n    "type": "category",\n    "tickangle": -45,\n    "tickmode": "auto",\n    "automargin": true,\n    "fixedrange": true,\n    "gridcolor": "#fff",\n    "zerolinecolor": "#fff"\n  },\n  "yaxis": {\n    "title": {\n      "text": "판매액 or 판매수량",\n      "standoff": 6,\n      "font": {\n        "size": 12\n      }\n    },\n    "type": "linear",\n    "tickformat": "",\n    "automargin": true,\n    "fixedrange": true,\n    "zerolinecolor": "#DEDEDE"\n  }\n}\n}}'
      }
      selectedPoints="[]"
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
