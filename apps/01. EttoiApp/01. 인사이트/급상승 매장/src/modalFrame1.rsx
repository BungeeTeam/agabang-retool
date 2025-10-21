<ModalFrame
  id="modalFrame1"
  footerPadding="8px 12px"
  headerPadding="8px 12px"
  hidden={true}
  hideOnEscape={true}
  isHiddenOnMobile={true}
  overlayInteraction={true}
  padding="8px 12px"
  showHeader={true}
  showOverlay={true}
  size="medium"
>
  <Header>
    <Text
      id="modalTitle1"
      heightType="fixed"
      value="#### 상세 정보 보기"
      verticalAlign="center"
    />
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
    <PlotlyChart
      id="chart1"
      data={include("../lib/chart1.data.json", "string")}
      dataseries={{
        ordered: [
          {
            3: {
              ordered: [
                { label: "누적 판매량" },
                {
                  datasource:
                    "{{formatDataAsObject(get_daily_sales_by_style.data)['sale_cumsum']}}",
                },
                { chartType: "line" },
                { aggregationType: "sum" },
                { color: "#1E3A8A" },
                { visible: true },
                {
                  hovertemplate:
                    "{{formatDataAsObject(get_daily_sales_by_style.data)['sale_cumsum']}}",
                },
              ],
            },
          },
          {
            5: {
              ordered: [
                { label: "누적 입고량" },
                {
                  datasource:
                    "{{formatDataAsObject(get_daily_sales_by_style.data)['in_cumsum']}}",
                },
                { chartType: "line" },
                { aggregationType: "none" },
                { color: "#60A5FA" },
                { visible: true },
              ],
            },
          },
        ],
      }}
      datasourceDataType="array"
      datasourceInputMode="javascript"
      datasourceJS="{{get_daily_sales_by_style.data}}"
      groupByDropdown={null}
      isDataTemplateDirty={true}
      isJsonTemplateDirty={true}
      isLayoutJsonDirty={true}
      layout={include("../lib/chart1.layout.json", "string")}
      margin="0"
      skipDatasourceUpdate={true}
      xAxis="{{formatDataAsObject(get_daily_sales_by_style.data).sale_dt.map(item => moment(item).format())}}"
      xAxisDropdown="sale_dt"
      xAxisMode="javascript"
    />
  </Body>
</ModalFrame>
