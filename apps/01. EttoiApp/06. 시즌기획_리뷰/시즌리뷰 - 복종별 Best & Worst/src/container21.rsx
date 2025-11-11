<Container
  id="container21"
  footerPadding="4px 12px"
  headerPadding="4px 12px"
  margin="0"
  padding="0"
  showBody={true}
  showBorder={false}
>
  <Header>
    <Text
      id="containerTitle27"
      value="#### Container title"
      verticalAlign="center"
    />
  </Header>
  <View id="065c2" viewKey="View 1">
    <Text
      id="text26"
      heightType="fixed"
      hidden="{{ get_item_list.data[item] == null }}"
      horizontalAlign="center"
      style={{ ordered: [{ background: "rgba(225, 225, 225, 0.46)" }] }}
      value="###### WORST"
      verticalAlign="center"
    />
    <Text
      id="text25"
      heightType="fixed"
      hidden="{{ get_item_list.data[item] == null }}"
      horizontalAlign="center"
      style={{ ordered: [{ background: "rgba(234, 235, 255, 1)" }] }}
      value="###### BEST"
      verticalAlign="center"
    />
    <ListViewBeta
      id="gridView2"
      _primaryKeys="{{ i }}"
      data="{{ get_item_list.data[item]
  .filter(item => item.sale_qty >= 200 && item.sale_qty_per >= 50)
  .splice(0, 5)
  .map(item => item.sty_cd + item.col_cd)
  .reduce((acc, key) => acc.filter(item => !(item.sty_cd + item.col_cd === key)), get_item_list.data[item].filter(item => item.sale_qty_per < 50))
  .slice(-5).reverse() }}"
      heightType="auto"
      itemWidth="200px"
      layoutType="grid"
      margin="0"
      numColumns="5"
      padding="0"
    >
      <Text
        id="text41"
        horizontalAlign="center"
        style={{ ordered: [] }}
        value="**{{i+1}}**"
        verticalAlign="center"
      />
      <Divider id="divider7" margin="0" textSize="default" />
      <Image
        id="image3"
        fit="contain"
        heightType="fixed"
        horizontalAlign="center"
        margin="0"
        src="https://agabang-image.s3.ap-northeast-2.amazonaws.com/item_final/{{item.sty_cd}}{{item.col_cd}}.jpg"
      />
      <Divider id="divider27" margin="0" textSize="default" />
      <Text
        id="text39"
        heightType="fixed"
        horizontalAlign="center"
        margin="0"
        style={{ ordered: [{ color: "rgba(13, 13, 13, 0.44)" }] }}
        value="{{item.sty_cd}}{{item.col_cd}}"
        verticalAlign="center"
      />
      <Divider id="divider29" margin="0" textSize="default" />
      <Container
        id="container19"
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
            id="containerTitle23"
            value="#### Container title"
            verticalAlign="center"
          />
        </Header>
        <View id="ce711" viewKey="View 1">
          <Text
            id="text42"
            horizontalAlign="center"
            value={'**{{item.sty_nm.split("-")[0]}}**'}
            verticalAlign="center"
          />
        </View>
      </Container>
      <Divider id="divider30" margin="0" textSize="default" />
      <Tags
        id="tags2"
        allowWrap={true}
        colors={'["#EEEEEE"]'}
        hashColors={true}
        horizontalAlign="center"
        margin="0"
        style={{ ordered: [{ defaultBackground: "automatic" }] }}
        value={'[{{item.sty_nm.split("-")[1]}}]'}
      />
      <Divider id="divider34" margin="0" textSize="default" />
      <Text
        id="text40"
        horizontalAlign="center"
        value="{{ Number(item.tag_prce).toLocaleString() }} 원"
        verticalAlign="center"
      />
      <Divider id="divider31" margin="0" textSize="default" />
      <Text
        id="text43"
        horizontalAlign="center"
        value="{{ Number(item.tot_in_qty).toLocaleString() }}"
        verticalAlign="center"
      />
      <Divider id="divider32" margin="0" textSize="default" />
      <Text
        id="text44"
        horizontalAlign="center"
        value="{{ item.fout_date }}"
        verticalAlign="center"
      />
      <Divider id="divider33" margin="0" textSize="default" />
      <Container
        id="container20"
        footerPadding="4px 12px"
        headerPadding="4px 12px"
        padding="0"
        showBody={true}
        style={{
          ordered: [{ border: "primary" }, { background: "highlight" }],
        }}
      >
        <Header>
          <Text
            id="containerTitle24"
            value="#### Container title"
            verticalAlign="center"
          />
        </Header>
        <View id="1ed63" viewKey="View 1">
          <Text
            id="text46"
            horizontalAlign="center"
            style={{ ordered: [{ color: "primary" }] }}
            value="**{{ Number(item.sale_qty).toLocaleString() }}**"
            verticalAlign="center"
          />
          <Text
            id="text45"
            horizontalAlign="center"
            style={{ ordered: [{ color: "primary" }] }}
            value="**{{ item.sale_qty_per}}%**"
            verticalAlign="center"
          />
        </View>
      </Container>
      <Divider id="divider10" margin="0" textSize="default" />
      <Text
        id="text47"
        horizontalAlign="center"
        value="{{ Number(item.cost_prce).toLocaleString() }} 원"
        verticalAlign="center"
      />
      <Divider id="divider28" margin="0" textSize="default" />
      <Text
        id="text48"
        horizontalAlign="center"
        value="{{ item.mark_up.toFixed(1) }}"
        verticalAlign="center"
      />
    </ListViewBeta>
    <ListViewBeta
      id="gridView1"
      _primaryKeys="{{ i }}"
      data="{{ get_item_list.data[item].filter(item => item.sale_qty >= 200 && item.sale_qty_per >= 50).splice(0,5) }}"
      heightType="auto"
      itemWidth="200px"
      layoutType="grid"
      margin="0"
      numColumns="5"
      padding="0"
    >
      <Text
        id="text9"
        horizontalAlign="center"
        style={{ ordered: [] }}
        value="**{{i+1}}**"
        verticalAlign="center"
      />
      <Divider id="divider5" margin="0" textSize="default" />
      <Image
        id="image2"
        fit="contain"
        heightType="fixed"
        horizontalAlign="center"
        margin="0"
        src="https://agabang-image.s3.ap-northeast-2.amazonaws.com/item_final/{{item.sty_cd}}{{item.col_cd}}.jpg"
      />
      <Divider id="divider8" margin="0" textSize="default" />
      <Text
        id="text7"
        heightType="fixed"
        horizontalAlign="center"
        margin="0"
        style={{ ordered: [{ color: "rgba(13, 13, 13, 0.44)" }] }}
        value="{{item.sty_cd}}{{item.col_cd}}"
        verticalAlign="center"
      />
      <Divider id="divider12" margin="0" textSize="default" />
      <Container
        id="container15"
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
        </View>
      </Container>
      <Divider id="divider26" margin="0" textSize="default" />
      <Tags
        id="tags1"
        allowWrap={true}
        colors={
          '{{ [JSON.parse(retoolContext.configVars.var_color_dict)[item.sty_nm.split("-")[1]]] }}'
        }
        hashColors={true}
        horizontalAlign="center"
        margin="0"
        style={{ ordered: [{ defaultBackground: "automatic" }] }}
        value={'[{{item.sty_nm.split("-")[1]}}]'}
      />
      <Divider id="divider11" margin="0" textSize="default" />
      <Text
        id="text8"
        horizontalAlign="center"
        value="{{ Number(item.tag_prce).toLocaleString() }} 원"
        verticalAlign="center"
      />
      <Divider id="divider25" margin="0" textSize="default" />
      <Text
        id="text19"
        horizontalAlign="center"
        value="{{ Number(item.tot_in_qty).toLocaleString() }}"
        verticalAlign="center"
      />
      <Divider id="divider24" margin="0" textSize="default" />
      <Text
        id="text20"
        horizontalAlign="center"
        value="{{ item.fout_date }}"
        verticalAlign="center"
      />
      <Divider id="divider23" margin="0" textSize="default" />
      <Container
        id="container16"
        footerPadding="4px 12px"
        headerPadding="4px 12px"
        padding="0"
        showBody={true}
        style={{
          ordered: [{ border: "primary" }, { background: "highlight" }],
        }}
      >
        <Header>
          <Text
            id="containerTitle19"
            value="#### Container title"
            verticalAlign="center"
          />
        </Header>
        <View id="1ed63" viewKey="View 1">
          <Text
            id="text22"
            horizontalAlign="center"
            style={{ ordered: [{ color: "primary" }] }}
            value="**{{ Number(item.sale_qty).toLocaleString() }}**"
            verticalAlign="center"
          />
          <Text
            id="text21"
            horizontalAlign="center"
            style={{ ordered: [{ color: "primary" }] }}
            value="**{{ item.sale_qty_per}}%**"
            verticalAlign="center"
          />
        </View>
      </Container>
      <Divider id="divider22" margin="0" textSize="default" />
      <Text
        id="text23"
        horizontalAlign="center"
        value="{{ Number(item.cost_prce).toLocaleString() }} 원"
        verticalAlign="center"
      />
      <Divider id="divider21" margin="0" textSize="default" />
      <Text
        id="text24"
        horizontalAlign="center"
        value="{{ item.mark_up.toFixed(1) }}"
        verticalAlign="center"
      />
    </ListViewBeta>
  </View>
</Container>
