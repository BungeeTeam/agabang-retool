<Container
  id="container1"
  footerPadding="4px 12px"
  headerPadding="4px 12px"
  padding="12px"
  showBody={true}
  showHeader={true}
>
  <Header>
    <Text
      id="containerTitle1"
      value="#### 시즌상품 매출비중"
      verticalAlign="center"
    />
    <Text
      id="text1"
      horizontalAlign="right"
      value="[단위: 백만원]"
      verticalAlign="center"
    />
  </Header>
  <View id="10302" viewKey="View 1">
    <SegmentedControl
      id="segmentedControl1"
      itemMode="static"
      label=""
      labelPosition="top"
      paddingType="spacious"
      value="{{ self.values[0] }}"
    >
      <Option id="d03c1" label="주간" value="week" />
      <Option id="17a26" label="월간" value="month" />
      <Option
        id="2d3f0"
        disabled={false}
        iconPosition="left"
        label="누적"
        value="accumulate"
      />
      <Event
        event="change"
        method="run"
        params={{
          ordered: [
            {
              src: "switch(segmentedControl1.selectedItem.value){\n  case 'week': {\n    dateRange1.setDisabled(true)\n    dateRange1.setRange([moment().day(-6), moment().day(0)])\n    dateRange2.setRange([moment().subtract(1, 'years').day(-6), moment().subtract(1, 'years').day(0)])\n  } break;\n  case 'month': {\n    dateRange1.setDisabled(true)\n    dateRange1.setRange([moment().subtract(1,'months').startOf('month').format('YYYY-MM-DD'), moment().subtract(1,'months').endOf('month').format('YYYY-MM-DD')])\n    dateRange2.setRange([moment().subtract(1,'years').subtract(1,'months').startOf('month').format('YYYY-MM-DD'), moment().subtract(1,'years').subtract(1,'months').endOf('month').format('YYYY-MM-DD')])\n  } break;\n  case 'accumulate': {\n    dateRange1.setDisabled(true)\n    dateRange1.setRange([moment().startOf('years').format('YYYY-MM-DD'), moment()])\n    dateRange2.setRange([moment().subtract(1,'years').startOf('years').format('YYYY-MM-DD'), moment()])\n  } break;\n  case 'manual': {\n    dateRange1.setDisabled(false)\n  } break;\n  default: {\n    dateRange1.setDisabled(true)\n  } break;\n}",
            },
          ],
        }}
        pluginId=""
        type="script"
        waitMs="0"
        waitType="debounce"
      />
    </SegmentedControl>
    <DateRange
      id="dateRange1"
      dateFormat="yyyy-MM-dd"
      disabled="true"
      endPlaceholder="End date"
      firstDayOfWeek={0}
      hidden="false"
      iconBefore="bold/interface-calendar-remove"
      label="기간(현재)"
      labelWidth="20"
      startPlaceholder="Start date"
      textBetween="-"
      value={{
        ordered: [
          { start: "{{ moment().day(-6) }}" },
          { end: "{{ moment().day(0) }}" },
        ],
      }}
    />
    <DateRange
      id="dateRange2"
      dateFormat="yyyy-MM-dd"
      disabled="true"
      endPlaceholder="End date"
      firstDayOfWeek={0}
      hidden="false"
      iconBefore="bold/interface-calendar-remove"
      label="기간(1년전)"
      labelWidth="20"
      startPlaceholder="Start date"
      textBetween="-"
      value={{
        ordered: [
          { start: "{{ moment().day(-6) }}" },
          { end: "{{ moment().day(0) }}" },
        ],
      }}
    />
    <Include src="./container2.rsx" />
  </View>
</Container>
