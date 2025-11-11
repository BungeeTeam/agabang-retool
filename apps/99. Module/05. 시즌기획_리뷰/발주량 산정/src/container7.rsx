<Container
  id="container7"
  footerPadding="4px 12px"
  headerPadding="4px 12px"
  hidden="{{ var_main_item_info.value == null }}"
  padding="12px"
  showBody={true}
  style={{ ordered: [{ background: "canvas" }] }}
>
  <Header>
    <Text
      id="containerTitle21"
      value="#### Container title"
      verticalAlign="center"
    />
  </Header>
  <View id="6c73f" viewKey="View 1">
    <Include src="./container6.rsx" />
    <Spacer id="spacer2" />
    <TextInput
      id="md_memo"
      label=""
      labelPosition="top"
      margin="0"
      placeholder="의견을 입력하세요"
      textBefore="MD 의견"
      value={
        '{{ get_assort.data[var_main_item_info.value.sty_cd + var_main_item_info.value.col_cd] == null ? "" : get_assort.data[var_main_item_info.value.sty_cd + var_main_item_info.value.col_cd].md_memo  }}'
      }
    />
    <Spacer id="spacer3" />
    <TextInput
      id="final_memo"
      label=""
      labelPosition="top"
      margin="0"
      placeholder="의견을 입력하세요"
      textBefore="팀장 의견"
      value={
        '{{ get_assort.data[var_main_item_info.value.sty_cd + var_main_item_info.value.col_cd] == null ? "" : get_assort.data[var_main_item_info.value.sty_cd + var_main_item_info.value.col_cd].final_memo  }}'
      }
    />
    <Spacer id="spacer4" hidden="true" />
    <TextInput
      id="price_memo"
      disabled=""
      hidden="true"
      label=""
      labelPosition="top"
      margin="0"
      placeholder="의견을 입력하세요"
      textBefore="최종 의견"
      value="{{ get_assort.data[var_main_item_info.value.sty_cd + var_main_item_info.value.col_cd] == null ? 0 : get_assort.data[var_main_item_info.value.sty_cd + var_main_item_info.value.col_cd].price_memo  }}"
    />
  </View>
</Container>
