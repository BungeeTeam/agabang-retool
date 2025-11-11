<Container
  id="container_category"
  footerPadding="4px 12px"
  headerPadding="4px 12px"
  margin="0"
  padding="0"
  showBody={true}
  showBorder={false}
  style={{ ordered: [{ background: "rgba(255, 255, 255, 0)" }] }}
>
  <View id="e3d8a" viewKey="View 1">
    <Text id="text8" value="##### {{item}}" verticalAlign="center" />
    <ListViewBeta
      id="listView2"
      data="{{ var_brand_orders.value }}"
      heightType="auto"
      itemWidth="200px"
      margin="0"
      numColumns={3}
      padding="0"
    >
      <Container
        id="container_brand"
        footerPadding="4px 12px"
        headerPadding="4px 12px"
        padding="0"
        showBody={true}
        showHeader={true}
        style={{
          ordered: [
            {
              headerBackground:
                '{{ listView2.item.includes("에뜨와") ? "highlight" : "white"}}',
            },
          ],
        }}
      >
        <Header>
          <Text
            id="containerTitle10"
            margin="0"
            style={{ ordered: [] }}
            value="###### {{listView_top.item}} | {{ item }}"
            verticalAlign="center"
          />
          <Text
            id="containerTitle13"
            horizontalAlign="right"
            style={{ ordered: [] }}
            value="{{get_items.data[listView_top.item][item].length}} SKU, 평균 {{ Math.round(get_items.data[listView_top.item][item].reduce((sum, item) => sum + parseInt(item.origin_price), 0) / get_items.data[listView_top.item][item].length, 0).toLocaleString() }} 원</h7>"
            verticalAlign="center"
          />
        </Header>
        <View id="e3d8a" viewKey="View 1">
          <ListViewBeta
            id="gridView1"
            data="{{ get_items.data[listView_top.item][item] }}"
            heightType="auto"
            itemWidth="200px"
            layoutType="grid"
            numColumns="10"
            padding="0"
          >
            <Include src="./container11.rsx" />
          </ListViewBeta>
        </View>
      </Container>
    </ListViewBeta>
    <Divider id="divider2" textSize="default" />
    <KeyValue
      id="keyValue_sku_sum"
      data="{{ category_summary?.value[item] }}"
      editIcon="bold/interface-edit-pencil"
      enableSaveActions={true}
      itemLabelPosition="top"
      labelWrap={true}
    />
    <Divider id="divider3" textSize="default" />
    <Text
      id="containerTitle9"
      style={{ ordered: [] }}
      value="{{  get_category_memo.data?.[sel_season.value]?.[item] ?? '' }}"
      verticalAlign="center"
    />
    <IconText
      id="iconText2"
      icon="bold/interface-edit-write-1"
      textSize="default"
      tooltipText="메모"
    >
      <Event
        event="click"
        method="setValue"
        params={{ ordered: [{ value: "{{item}}" }] }}
        pluginId="var_category_info"
        type="state"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        event="click"
        method="show"
        params={{ ordered: [] }}
        pluginId="modalFrame5"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </IconText>
  </View>
</Container>
