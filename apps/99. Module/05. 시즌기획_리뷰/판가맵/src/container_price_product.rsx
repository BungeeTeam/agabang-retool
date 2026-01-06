<Container
  id="container_price_product"
  footerPadding="4px 12px"
  headerPadding="4px 12px"
  margin="0"
  padding="0"
  showBody={true}
>
  <Header>
    <Text
      id="containerTitle7"
      value="#### Container title"
      verticalAlign="center"
    />
  </Header>
  <View id="28726" viewKey="View 1">
    <HTML
      id="renewedHtml"
      css={include("../lib/renewedHtml.css", "string")}
      html={include("../lib/renewedHtml.html", "string")}
    >
      <Event
        enabled="{{ target.type === 'memo_target' }}"
        event="change"
        method="setValue"
        params={{ ordered: [{ value: "{{ target.value }}" }] }}
        pluginId="var_price_memo"
        type="state"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        enabled="{{ target.type === 'memo_target' }}"
        event="click"
        method="setValue"
        params={{ ordered: [{ value: "null" }] }}
        pluginId="var_price_memo"
        type="state"
        waitMs="0"
        waitType="debounce"
      />
      <Event
        enabled={'{{ target.type === "memo_click" }}'}
        event="click"
        method="run"
        params={{
          ordered: [
            {
              src: '// Get sty_cd and col_cd and \nconst targetValue = target.value\nconst styCd = targetValue.split("|")[0] || ""\nconst colCd = targetValue.split("|")[1] || ""\nvar_selected_item.setValue({\n  sty_cd: styCd,\n  col_cd: colCd\n})\n\nif (var_price_memo.value === null || var_price_memo.value === "") {\n  utils.showNotification({\n    title: "메모 입력 안내",\n    description: "메모를 입력해 주세요",\n    notificationType: "warning"\n  });  \n} else {\n  update_price_memo.trigger()\n}',
            },
          ],
        }}
        pluginId=""
        type="script"
        waitMs="0"
        waitType="debounce"
      />
    </HTML>
    <HTML
      id="html2"
      css={include("../lib/html2.css", "string")}
      html={include("../lib/html2.html", "string")}
    />
    <HTML
      id="html3"
      css={include("../lib/html3.css", "string")}
      html={include("../lib/html3.html", "string")}
    />
    <HTML
      id="html7"
      css={include("../lib/html7.css", "string")}
      hidden="{{ switch_competitor.value == false }}"
      html={include("../lib/html7.html", "string")}
    />
    <HTML
      id="html4"
      css={include("../lib/html4.css", "string")}
      hidden="{{ switch_competitor.value == false }}"
      html={include("../lib/html4.html", "string")}
    />
    <HTML
      id="html5"
      css={include("../lib/html5.css", "string")}
      hidden="{{ switch_competitor.value == false }}"
      html={include("../lib/html5.html", "string")}
    />
    <ListViewBeta
      id="gridView1"
      _primaryKeys="{{ i }}"
      data="{{ formatDataAsArray(get_item_list.data).filter(item => Number(item.item_price) === var_price_list.value[i] && item.year_sesn_nm_eng == var_season_list.value[0] )}}"
      direction="horizontal"
      heightType="auto"
      hidden="true"
      itemWidth="200px"
      layoutType="grid"
      maxHeight="100vh"
      numColumns="3"
      padding="0"
    >
      <Container
        id="container1"
        footerPadding="4px 12px"
        headerPadding="4px 12px"
        margin="0"
        padding="0"
        showBody={true}
      >
        <Header>
          <Text
            id="containerTitle8"
            value="#### {{ item.sty_cd }}"
            verticalAlign="center"
          />
        </Header>
        <View id="bff08" viewKey="View 1">
          <HTML
            id="html6"
            css={include("../lib/html6.css", "string")}
            html={include("../lib/html6.html", "string")}
            margin="0"
          >
            <Event
              event="click"
              method="trigger"
              params={{ ordered: [] }}
              pluginId="get_item_list"
              type="datasource"
              waitMs="0"
              waitType="debounce"
            />
            <Event
              event="change"
              method="setValue"
              params={{ ordered: [] }}
              pluginId="var_price_memo"
              type="state"
              waitMs="0"
              waitType="debounce"
            />
          </HTML>
          <TextInput
            id="textInput_price_memo"
            iconBefore="bold/interface-edit-write-2"
            label=""
            labelPosition="top"
            margin="0"
            placeholder="메모입력"
            style={{
              ordered: [
                { fontSize: "10px" },
                { fontWeight: "400" },
                { fontFamily: "Inter" },
              ],
            }}
            value="{{ item.price_memo }}"
          >
            <Event
              event="focus"
              method="setValue"
              params={{ ordered: [{ value: "{{ item }}" }] }}
              pluginId="var_selected_item"
              type="state"
              waitMs="0"
              waitType="debounce"
            />
            <Event
              event="change"
              method="setValue"
              params={{ ordered: [{ value: "{{ self.value }}" }] }}
              pluginId="var_price_memo"
              type="state"
              waitMs="0"
              waitType="debounce"
            />
            <Event
              event="submit"
              method="trigger"
              params={{ ordered: [] }}
              pluginId="update_price_memo"
              type="datasource"
              waitMs="0"
              waitType="debounce"
            />
          </TextInput>
        </View>
      </Container>
    </ListViewBeta>
  </View>
</Container>
