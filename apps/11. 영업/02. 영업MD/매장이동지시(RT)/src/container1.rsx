<Container
  id="container1"
  footerPadding="4px 12px"
  headerPadding="4px 12px"
  margin="4px 4px"
  padding="12px"
  showBody={true}
>
  <Header>
    <Text
      id="containerTitle1"
      value="#### Container title"
      verticalAlign="center"
    />
  </Header>
  <View id="44fff" viewKey="View 1">
    <Text
      id="text31"
      margin="0"
      value="#### 매장 이동 지시(RT)"
      verticalAlign="center"
    />
    <Spacer id="spacer5" />
    <Select
      id="bizSelect"
      emptyMessage="No options"
      itemMode="static"
      label="사업부"
      labelPosition="top"
      margin="0"
      overlayMaxHeight={375}
      placeholder="Select an option"
      showSelectionIndicator={true}
      value="{{ current_user.groups.map(i => i.name).includes('admin') ? 'A1' :
  current_user.groups.map(i => i.name).includes('아가방 부문') ? 'A1' : 
  current_user.groups.map(i => i.name).includes('에뜨와 부문') ? 'A4' : 'A1'}}"
    >
      <Option
        id="ef8f6"
        color="{{ theme.tokens.primaryOpacity20 }}"
        label="아가방사업부"
        value={'"A1"'}
      />
      <Option
        id="3f9fb"
        color="{{ theme.tokens.primaryOpacity20 }}"
        label="에뜨와사업부"
        value={'"A4"'}
      />
    </Select>
    <Multiselect
      id="brandSelect"
      captionByIndex=""
      colorByIndex="{{ theme.tokens.primaryOpacity20 }}"
      data="{{ brandList.data }}"
      emptyMessage="No options"
      fallbackTextByIndex="{{ item.br_cd }}"
      iconByIndex=""
      label="브랜드"
      labelPosition="top"
      labels="{{ item.br_nm }}"
      margin="0"
      overlayMaxHeight={375}
      placeholder="Select an option"
      showSelectionIndicator={true}
      style={{ ordered: [] }}
      values="{{ item.br_cd }}"
      wrapTags={true}
    />
    <Multiselect
      id="yearSelect"
      colorByIndex=""
      data="{{ yearList.data }}"
      emptyMessage="No options"
      label="연도"
      labelPosition="top"
      labels="{{ item.year_nm }}"
      margin="0"
      overlayMaxHeight={375}
      placeholder="Select an option"
      showSelectionIndicator={true}
      value={'["S"]'}
      values="{{ item.year_cd }}"
      wrapTags={true}
    >
      <Option id="ef8f6" value="Option 1" />
      <Option id="58cd0" value="Option 2" />
      <Option id="3f9fb" value="Option 3" />
    </Multiselect>
    <Multiselect
      id="seasonSelect"
      colorByIndex=""
      data="{{ seasonList.data }}"
      emptyMessage="No options"
      label="시즌"
      labelPosition="top"
      labels="{{ item.season_nm }}"
      margin="0"
      overlayMaxHeight={375}
      placeholder="Select an option"
      showSelectionIndicator={true}
      value=""
      values="{{ item.season_cd }}"
      wrapTags={true}
    >
      <Option id="ef8f6" value="Option 1" />
      <Option id="58cd0" value="Option 2" />
      <Option id="3f9fb" value="Option 3" />
    </Multiselect>
    <Multiselect
      id="itSelect"
      colorByIndex=""
      data="{{ itList.data }}"
      emptyMessage="No options"
      fallbackTextByIndex="{{ item.it }}"
      label="복종대분류"
      labelPosition="top"
      labels="{{ item.it_nm }}"
      margin="0"
      overlayMaxHeight={375}
      placeholder="Select an option"
      showSelectionIndicator={true}
      value=""
      values="{{ item.it }}"
      wrapTags={true}
    >
      <Option id="ef8f6" value="Option 1" />
      <Option id="58cd0" value="Option 2" />
      <Option id="3f9fb" value="Option 3" />
    </Multiselect>
  </View>
</Container>
