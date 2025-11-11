<Container
  id="container_item_category"
  footerPadding="4px 12px"
  headerPadding="4px 12px"
  padding="12px"
  showBody={true}
  showHeader={true}
  style={{ ordered: [] }}
>
  <Header>
    <Text
      id="containerTitle13"
      margin="0"
      value="##### {{ item }}"
      verticalAlign="center"
    />
    <Text
      id="containerTitle14"
      heightType="fixed"
      horizontalAlign="right"
      margin="0"
      value="총 SKU : {{get_item_list.data[item] == null ? 0 : get_item_list.data[item].length}}"
      verticalAlign="center"
    />
  </Header>
  <View id="0a507" viewKey="View 1">
    <Spacer id="spacer13" />
    <PlotlyChart
      id="chart4"
      data={include("../lib/chart4.data.json", "string")}
      dataseries={{
        ordered: [
          {
            4: {
              ordered: [
                { label: "판매율(%)" },
                {
                  datasource:
                    "{{formatDataAsObject(get_item_list.data[item])['sale_qty_per']}}",
                },
                { chartType: "line" },
                { aggregationType: "none" },
                { color: "#CD6F00" },
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
            3: {
              ordered: [
                { label: "판매량" },
                {
                  datasource:
                    "{{formatDataAsObject(get_item_list.data[item])['sale_qty']}}",
                },
                { chartType: "bar" },
                { aggregationType: "sum" },
                { color: "#DBEAFE" },
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
            2: {
              ordered: [
                { label: "입고량" },
                {
                  datasource:
                    "{{formatDataAsObject(get_item_list.data[item])['tot_in_qty']}}",
                },
                { chartType: "bar" },
                { aggregationType: "sum" },
                { color: "#60A5FA" },
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
      datasourceJS="{{get_item_list.data[item]}}"
      hidden="{{ get_item_list.data[item] == null }}"
      isDataTemplateDirty={true}
      isJsonTemplateDirty={true}
      isLayoutJsonDirty={true}
      layout={include("../lib/chart4.layout.json", "string")}
      legendAlignment="top"
      margin="4px 8px"
      skipDatasourceUpdate={true}
      xAxis="{{formatDataAsObject(get_item_list.data[item])['sty_nm']}}"
      xAxisDropdown="sty_nm"
      xAxisMode="javascript"
    />
    <ListViewBeta
      id="gridView1"
      _primaryKeys="{{ i }}"
      data="{{ get_item_list.data[item] }}"
      itemWidth="200px"
      layoutType="grid"
      margin="0"
      numColumns="{{get_item_list.data[item].length}}"
      padding="0"
    >
      <Text
        id="text9"
        horizontalAlign="center"
        style={{ ordered: [{ color: "primary" }] }}
        value="**{{ item.sale_qty_per}}%**"
        verticalAlign="center"
      />
      <Container
        id="container10"
        footerPadding="4px 12px"
        headerPadding="4px 12px"
        heightType="fixed"
        margin="0"
        padding="0"
        showBody={true}
        showBorder={false}
      >
        <Header>
          <Text
            id="containerTitle12"
            value="#### Container title"
            verticalAlign="center"
          />
        </Header>
        <View id="ce711" viewKey="View 1">
          <Text
            id="text10"
            horizontalAlign="center"
            value={'**{{item.sty_nm.split("-")[0]}}**'}
            verticalAlign="center"
          />
          <Tags
            id="tags1"
            allowWrap={true}
            colors={
              '{{ [JSON.parse(retoolContext.configVars.var_color_dict)[item.sty_nm.split("-")[1]]] }}'
            }
            horizontalAlign="center"
            margin="0"
            style={{ ordered: [{ defaultBackground: "automatic" }] }}
            value={'[{{item.sty_nm.split("-")[1]}}]'}
          />
        </View>
      </Container>
      <Text
        id="text7"
        horizontalAlign="center"
        margin="0"
        value="{{item.sty_cd}}{{item.col_cd}}"
        verticalAlign="center"
      />
      <Text
        id="text8"
        horizontalAlign="center"
        margin="0"
        value="{{ Number(item.tag_prce).toLocaleString() }} 원"
        verticalAlign="center"
      />
      <Image
        id="image2"
        fit="contain"
        heightType="fixed"
        horizontalAlign="center"
        margin="0"
        src="https://agabang-image.s3.ap-northeast-2.amazonaws.com/item_final/{{item.sty_cd}}{{item.col_cd}}.jpg"
      >
        <Event
          event="click"
          method="setValue"
          params={{ ordered: [{ value: "{{ item }}" }] }}
          pluginId="var_sel_sty_info"
          type="state"
          waitMs="0"
          waitType="debounce"
        />
      </Image>
    </ListViewBeta>
  </View>
</Container>
