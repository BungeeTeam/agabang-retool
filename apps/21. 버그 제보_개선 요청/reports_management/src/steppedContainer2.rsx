<Container
  id="steppedContainer2"
  _align="center"
  _direction="vertical"
  _gap="0px"
  _justify="space-between"
  _type="stack"
  currentViewKey="{{ self.viewKeys[0] }}"
  footerPadding="4px 12px"
  headerPadding="4px 12px"
  heightType="fill"
  margin="0"
  padding="0"
  showBody={true}
  showBorder={false}
  showFooterBorder={false}
  showHeader={true}
  transition="slide"
>
  <Header>
    <Steps
      id="steps2"
      hidden="{{ current_user.fullName != '클리브' }}"
      horizontalAlign="center"
      itemMode="static"
      navigateContainer={true}
      showStepNumbers={true}
      targetContainerId="steppedContainer2"
      value="{{ self.values[0] }}"
    >
      <Option id="1b8f6" value="Step 1" />
      <Option id="6146b" value="Step 2" />
      <Option id="4e433" value="Step 3" />
    </Steps>
  </Header>
  <View id="66fa7" viewKey="Step 1">
    <Spacer id="spacer22" />
    <TextEditor
      id="richTextEditor11"
      events={[]}
      showInEditor={false}
      value=""
    />
    <Text
      id="text25"
      horizontalAlign="center"
      style={{
        ordered: [
          { fontSize: "15px" },
          { fontWeight: "400" },
          { fontFamily: "Pretendard Variable" },
        ],
      }}
      value="#### {{ questions.value[select4.value].q_1.question }}
{{ questions.value[select4.value].q_1.description }}"
      verticalAlign="center"
    />
    <Container
      id="stack14"
      _flexWrap={true}
      _gap="0px"
      _justify="space-between"
      _type="stack"
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      padding="12px"
      showBody={true}
      showBorder={false}
    >
      <View id="210f0" viewKey="View 1">
        <Button
          id="nextButton12"
          disabled={'{{ richTextEditor11.value === "<p><br></p>" }}'}
          hidden="{{ steppedContainer1.currentViewIndex + 1 === steppedContainer1.viewKeys.length || steppedContainer1.currentViewIndex + 1 === 8}}"
          iconAfter="bold/interface-arrows-right-alternate"
          text="다음"
        >
          <Event
            event="click"
            method="showNextVisibleView"
            params={{ ordered: [{ wrap: false }] }}
            pluginId="steppedContainer2"
            type="widget"
            waitMs="0"
            waitType="debounce"
          />
        </Button>
        <Button
          id="prevButton11"
          disabled="{{ steppedContainer1.currentViewIndex === 0 || steppedContainer1.currentViewIndex + 1 === steppedContainer1.viewKeys.length }}"
          hidden="{{ steppedContainer1.currentViewIndex === 0 || steppedContainer1.currentViewIndex + 1 === steppedContainer1.viewKeys.length || steppedContainer1.currentViewIndex + 1 === 8}}"
          iconBefore="bold/interface-arrows-left-alternate"
          maintainSpaceWhenHidden={true}
          styleVariant="outline"
          text="이전"
        >
          <Event
            event="click"
            method="showPreviousVisibleView"
            params={{ ordered: [{ wrap: false }] }}
            pluginId="steppedContainer1"
            type="widget"
            waitMs="0"
            waitType="debounce"
          />
        </Button>
      </View>
    </Container>
  </View>
  <View id="e8356" viewKey="Step 2">
    <Spacer id="spacer23" />
    <TextEditor
      id="richTextEditor12"
      events={[]}
      showInEditor={false}
      value=""
    />
    <Text
      id="text26"
      horizontalAlign="center"
      style={{
        ordered: [
          { fontSize: "15px" },
          { fontWeight: "400" },
          { fontFamily: "Pretendard Variable" },
        ],
      }}
      value="#### {{ questions.value[select4.value].q_2.question }}
{{ questions.value[select4.value].q_2.description }}"
      verticalAlign="center"
    />
    <Container
      id="stack15"
      _flexWrap={true}
      _gap="0px"
      _justify="space-between"
      _type="stack"
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      padding="12px"
      showBody={true}
      showBorder={false}
    >
      <View id="210f0" viewKey="View 1">
        <Button
          id="nextButton13"
          disabled={'{{ richTextEditor12.value === "<p><br></p>" }}'}
          hidden="{{ steppedContainer1.currentViewIndex + 1 === steppedContainer1.viewKeys.length || steppedContainer1.currentViewIndex + 1 === 8}}"
          iconAfter="bold/interface-arrows-right-alternate"
          text="다음"
        >
          <Event
            event="click"
            method="showNextVisibleView"
            params={{ ordered: [{ wrap: false }] }}
            pluginId="steppedContainer2"
            type="widget"
            waitMs="0"
            waitType="debounce"
          />
        </Button>
        <Button
          id="prevButton12"
          disabled="{{ steppedContainer1.currentViewIndex === 0 || steppedContainer1.currentViewIndex + 1 === steppedContainer1.viewKeys.length }}"
          hidden="{{ steppedContainer1.currentViewIndex === 0 || steppedContainer1.currentViewIndex + 1 === steppedContainer1.viewKeys.length || steppedContainer1.currentViewIndex + 1 === 8}}"
          iconBefore="bold/interface-arrows-left-alternate"
          maintainSpaceWhenHidden={true}
          styleVariant="outline"
          text="이전"
        >
          <Event
            event="click"
            method="showPreviousVisibleView"
            params={{ ordered: [{ wrap: false }] }}
            pluginId="steppedContainer2"
            type="widget"
            waitMs="0"
            waitType="debounce"
          />
        </Button>
      </View>
    </Container>
  </View>
  <View id="eb74b" viewKey="Step 3">
    <Spacer id="spacer24" />
    <TextEditor
      id="richTextEditor13"
      events={[]}
      showInEditor={false}
      value=""
    />
    <Text
      id="text27"
      horizontalAlign="center"
      style={{
        ordered: [
          { fontSize: "15px" },
          { fontWeight: "400" },
          { fontFamily: "Pretendard Variable" },
        ],
      }}
      value="#### {{ questions.value[select4.value].q_3.question }}
{{ questions.value[select4.value].q_3.description }}"
      verticalAlign="center"
    />
    <Container
      id="stack16"
      _flexWrap={true}
      _gap="0px"
      _justify="space-between"
      _type="stack"
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      padding="12px"
      showBody={true}
      showBorder={false}
    >
      <View id="210f0" viewKey="View 1">
        <Button
          id="nextButton14"
          disabled={'{{ richTextEditor13.value === "<p><br></p>" }}'}
          hidden="{{ steppedContainer1.currentViewIndex + 1 === steppedContainer1.viewKeys.length || steppedContainer1.currentViewIndex + 1 === 8}}"
          iconAfter="bold/interface-arrows-right-alternate"
          text="다음"
        >
          <Event
            event="click"
            method="showNextVisibleView"
            params={{ ordered: [{ wrap: false }] }}
            pluginId="steppedContainer2"
            type="widget"
            waitMs="0"
            waitType="debounce"
          />
        </Button>
        <Button
          id="prevButton13"
          disabled="{{ steppedContainer1.currentViewIndex === 0 || steppedContainer1.currentViewIndex + 1 === steppedContainer1.viewKeys.length }}"
          hidden="{{ steppedContainer1.currentViewIndex === 0 || steppedContainer1.currentViewIndex + 1 === steppedContainer1.viewKeys.length || steppedContainer1.currentViewIndex + 1 === 8}}"
          iconBefore="bold/interface-arrows-left-alternate"
          maintainSpaceWhenHidden={true}
          styleVariant="outline"
          text="이전"
        >
          <Event
            event="click"
            method="showPreviousVisibleView"
            params={{ ordered: [{ wrap: false }] }}
            pluginId="steppedContainer2"
            type="widget"
            waitMs="0"
            waitType="debounce"
          />
        </Button>
      </View>
    </Container>
  </View>
  <View
    id="38ff7"
    disabled={false}
    hidden={false}
    iconPosition="left"
    viewKey="Step 4"
  >
    <TextEditor
      id="richTextEditor14"
      events={[]}
      showInEditor={false}
      value=""
    />
    <Spacer id="spacer25" />
    <Text
      id="text28"
      horizontalAlign="center"
      style={{
        ordered: [
          { fontSize: "15px" },
          { fontWeight: "400" },
          { fontFamily: "Pretendard Variable" },
        ],
      }}
      value="#### {{ questions.value[select4.value].q_4.question }}

{{ questions.value[select4.value].q_4.description }}"
      verticalAlign="center"
    />
    <Container
      id="stack17"
      _flexWrap={true}
      _gap="0px"
      _justify="space-between"
      _type="stack"
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      padding="12px"
      showBody={true}
      showBorder={false}
    >
      <View id="210f0" viewKey="View 1">
        <Button
          id="nextButton15"
          disabled={'{{ richTextEditor14.value === "<p><br></p>" }}'}
          hidden="{{ steppedContainer1.currentViewIndex + 1 === steppedContainer1.viewKeys.length || steppedContainer1.currentViewIndex + 1 === 8}}"
          iconAfter="bold/interface-arrows-right-alternate"
          text="다음"
        >
          <Event
            event="click"
            method="showNextVisibleView"
            params={{ ordered: [{ wrap: false }] }}
            pluginId="steppedContainer1"
            type="widget"
            waitMs="0"
            waitType="debounce"
          />
        </Button>
        <Button
          id="prevButton14"
          disabled="{{ steppedContainer1.currentViewIndex === 0 || steppedContainer1.currentViewIndex + 1 === steppedContainer1.viewKeys.length }}"
          hidden="{{ steppedContainer1.currentViewIndex === 0 || steppedContainer1.currentViewIndex + 1 === steppedContainer1.viewKeys.length || steppedContainer1.currentViewIndex + 1 === 8}}"
          iconBefore="bold/interface-arrows-left-alternate"
          maintainSpaceWhenHidden={true}
          styleVariant="outline"
          text="이전"
        >
          <Event
            event="click"
            method="showPreviousVisibleView"
            params={{ ordered: [{ wrap: false }] }}
            pluginId="steppedContainer2"
            type="widget"
            waitMs="0"
            waitType="debounce"
          />
        </Button>
      </View>
    </Container>
  </View>
  <Footer>
    <Button
      id="prevButton10"
      disabled="{{ steppedContainer2.currentViewIndex === 0 }}"
      iconBefore="bold/interface-arrows-left-alternate"
      styleVariant="outline"
      text="Previous"
    >
      <Event
        event="click"
        method="showPreviousVisibleView"
        params={{ ordered: [{ wrap: false }] }}
        pluginId="steppedContainer2"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </Button>
    <Button
      id="nextButton11"
      disabled="{{ steppedContainer2.currentViewIndex + 1 === steppedContainer2.viewKeys.length }}"
      iconAfter="bold/interface-arrows-right-alternate"
      text="Next"
    >
      <Event
        event="click"
        method="showNextVisibleView"
        params={{ ordered: [{ wrap: false }] }}
        pluginId="steppedContainer2"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </Button>
  </Footer>
</Container>
