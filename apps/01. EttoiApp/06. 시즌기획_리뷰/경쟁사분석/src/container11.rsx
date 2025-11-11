<Container
  id="container11"
  footerPadding="4px 12px"
  headerPadding="4px 12px"
  margin="0"
  overflowType="hidden"
  padding="0"
  showBody={true}
  showBorder={false}
  style={{ ordered: [{ background: "" }, { borderRadius: "0px" }] }}
>
  <Header>
    <Text
      id="containerTitle11"
      value="#### {{ item.item_name }}"
      verticalAlign="center"
    />
  </Header>
  <View id="e3d8a" viewKey="View 1">
    <Image
      id="image1"
      fit="contain"
      horizontalAlign="center"
      margin="0"
      src="{{ item.image_url}}"
      style={{ ordered: [] }}
    >
      <Event
        event="click"
        method="setValue"
        params={{ ordered: [{ value: "{{item}}" }] }}
        pluginId="var_item_info"
        type="state"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        event="click"
        method="show"
        params={{ ordered: [] }}
        pluginId="modalFrame4"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </Image>
    <Text
      id="text5"
      horizontalAlign="center"
      margin="0"
      value="{{Number(item.origin_price).toLocaleString()}}원"
      verticalAlign="center"
    />
    <Divider id="divider1" textSize="default" />
    <Text
      id="text4"
      horizontalAlign="center"
      margin="0"
      style={{ ordered: [{ color: "rgba(13, 13, 13, 0.44)" }] }}
      value="{{item.item_code}}"
      verticalAlign="center"
    />
    <Container
      id="container12"
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      heightType="fixed"
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
      <View id="822f5" viewKey="View 1">
        <Link
          id="link1"
          allowWrap={true}
          horizontalAlign="center"
          margin="0"
          showUnderline="hover"
          text="{{item.item_name}}"
          textSize="default"
          underlineStyle="dotted"
        >
          <Event
            event="click"
            method="openUrl"
            params={{ ordered: [{ url: "{{ item.item_link }}" }] }}
            pluginId=""
            type="util"
            waitMs="0"
            waitType="debounce"
          />
        </Link>
      </View>
    </Container>
    <Tags
      id="tags1"
      allowWrap={true}
      colors=""
      hashColors={true}
      hidden={'{{ item.color == null || item.color == "" }}'}
      horizontalAlign="center"
      style={{ ordered: [{ defaultBackground: "canvas" }] }}
      value="[{{item.color}}]"
    />
    <Text
      id="text7"
      hidden="{{ item.sale_per == 0 }}"
      horizontalAlign="center"
      style={{
        ordered: [
          {
            color:
              '{{ item.sale_per > 60 ? "danger" : item.sale_per > 40 ? "success" : "gray" }}',
          },
        ],
      }}
      value="**{{ item.sale_per }}%**"
      verticalAlign="center"
    />
    <Text
      id="text9"
      horizontalAlign="center"
      style={{ ordered: [{ color: "rgba(13, 13, 13, 0.52)" }] }}
      value="{{ item.origin_price_ranking}}"
      verticalAlign="center"
    />
    <Spacer id="spacer1" />
  </View>
</Container>
