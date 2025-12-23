<App>
  <Include src="./functions.rsx" />
  <CustomAppTheme
    id="$appTheme"
    _migrated={true}
    automatic={[
      "#fde68a",
      "#eecff3",
      "#a7f3d0",
      "#bfdbfe",
      "#c7d2fe",
      "#fecaca",
      "#fcd6bb",
    ]}
    borderRadius="4px"
    canvas="#f6f6f6"
    danger="#dc2626"
    defaultFont={{
      size: "12px",
      name: '"Pretendard Variable", Pretendard, -apple-system, BlinkMacSystemFont, system-ui, Roboto, "Helvetica Neue", "Segoe UI", "Apple SD Gothic Neo", "Noto Sans KR", "Malgun Gothic", "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol", sans-serif',
      source:
        "https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard.min.css",
    }}
    h1Font={{ size: "36px" }}
    h2Font={{ size: "28px" }}
    h3Font={{ size: "24px" }}
    h4Font={{ size: "18px" }}
    h5Font={{ size: "16px" }}
    h6Font={{ size: "14px" }}
    highlight="#fde68a"
    info="#3170f9"
    primary="#3170f9"
    secondary=""
    success="#059669"
    surfacePrimary="#ffffff"
    surfacePrimaryBorder=""
    surfaceSecondary="#ffffff"
    surfaceSecondaryBorder=""
    tertiary=""
    textDark="#0d0d0d"
    textLight="#ffffff"
    warning="#cd6f00"
  />
  <GlobalWidgetOutput
    id="sitemap"
    description=""
    value="{{navigation1.data}}"
  />
  <Include src="./src/modalFrame1.rsx" />
  <Frame
    id="$main"
    enableFullBleed={false}
    isHiddenOnDesktop={false}
    isHiddenOnMobile={false}
    padding="8px 12px"
    sticky={null}
    type="main"
  >
    <ModuleContainerWidget
      id="moduleContainer"
      backgroundColor="white"
      isGlobalWidgetContainer={true}
      margin="0"
    >
      <Container
        id="stack1"
        _align="center"
        _flexWrap={true}
        _gap="0px"
        _justify="space-between"
        _type="stack"
        footerPadding="4px 12px"
        headerPadding="4px 12px"
        margin="0"
        padding="0"
        showBody={true}
        showBorder={false}
        style={{ ordered: [{ background: "rgba(255, 255, 255, 0)" }] }}
      >
        <View id="c010c" viewKey="View 1">
          <Navigation
            id="navigation1"
            dbBlobId="d3e265a3-7302-47a0-89ef-5dc40b9770c0"
            itemMode="static"
            src="https://agabang-image.s3.ap-northeast-2.amazonaws.com/logo/agabangandcompany_en_logo.png"
          >
            <Option
              id="8f5ac"
              appTarget="751e3cda-6053-11f0-8382-239825482f91"
              disabled={false}
              hidden={false}
              icon="bold/interface-search-circle"
              iconPosition="left"
              itemType="app"
              label="매장 검색"
            />
            <Option
              id="e6855"
              disabled={false}
              hidden={false}
              icon="bold/shopping-cloth-accessories-necktie"
              iconPosition="left"
              itemType="app"
              key="a5cf9"
              label="영업"
            />
            <Option
              id="5cde3"
              appTarget="ef24d28c-f99c-11ef-8c58-efeb0ef80c88"
              disabled={false}
              hidden={false}
              icon="bold/shopping-store-discount-percent-increase"
              iconPosition="left"
              itemType="app"
              label="목표매출 달성현황"
              parentKey="a5cf9"
            />
            <Option
              id="522b8"
              appTarget="88f62050-fb37-11ef-9dfc-47aabcf5b8e0"
              disabled={false}
              hidden={false}
              icon="bold/shopping-store-2"
              iconPosition="left"
              itemType="app"
              label="매장상세 현황"
              parentKey="a5cf9"
            />
            <Option
              id="b1ebf"
              appTarget="42846b3c-3f79-11f0-ad84-83bea367728a"
              disabled={false}
              hidden={false}
              icon="bold/interface-page-controller-settings"
              iconPosition="left"
              itemType="app"
              parentKey="a5cf9"
            />
            <Option
              id="e16c4"
              appTarget="09da10c8-15be-11f0-9819-0be9e5ff6a59"
              disabled={false}
              hidden={false}
              icon="bold/interface-content-chart"
              iconPosition="left"
              itemType="app"
              label="매장 수 현황"
              parentKey="a5cf9"
            />
            <Option
              id="ab0ed"
              disabled={false}
              hidden={false}
              icon="bold/money-graph"
              iconPosition="left"
              itemType="app"
              key="a184b"
              label="영업MD"
            />
            <Option
              id="e03a4"
              appTarget="a0325d0a-0f6a-11f0-9928-b3a1bd9d8e13"
              disabled={false}
              hidden={false}
              icon="bold/interface-alert-warning-diamond-alternate"
              iconPosition="left"
              itemType="app"
              parentKey="a184b"
            />
            <Option
              id="a274f"
              appTarget="ba83363a-0f91-11f0-872c-1fefe51f5d8e"
              disabled={false}
              hidden={false}
              icon="bold/interface-alert-warning-diamond-alternate"
              iconPosition="left"
              itemType="app"
              label="RT 성과 분석"
              parentKey="a184b"
            />
            <Option
              id="7df12"
              appTarget="8787f894-2c77-11f0-92b7-afea289567e4"
              disabled={false}
              hidden={false}
              icon="bold/interface-arrows-expand-1"
              iconPosition="left"
              itemType="app"
              label="판매유형별 매출 현황"
              parentKey="a184b"
            />
            <Option
              id="585c7"
              appTarget="f5077e88-39f8-11f0-af68-5770912d62be"
              disabled={false}
              hidden={false}
              icon="bold/interface-edit-pin-2"
              iconPosition="left"
              itemType="app"
              label="정상 매출현황"
              parentKey="a184b"
            />
            <Option
              id="867be"
              appTarget="fe1f9300-2be5-11f0-9c8f-7704c5245279"
              disabled={false}
              hidden={false}
              icon="bold/interface-arrows-loop"
              iconPosition="left"
              itemType="app"
              label="이월 매출현황"
              parentKey="a184b"
            />
            <Option
              id="e5346"
              appTarget="1cf7632a-52f1-11f0-93fc-d71253ef960f"
              disabled={false}
              hidden={false}
              icon="bold/catergories-baby-botlle"
              iconPosition="left"
              itemType="app"
              label="용품 매출현황"
              parentKey="a184b"
              screenTargetId="SuppliesSales"
            />
            <Option
              id="fc39e"
              appTarget="ff1f2d4e-3f75-11f0-8eb1-1315800c3013"
              disabled={false}
              hidden={false}
              icon="bold/shopping-cart-heavy"
              iconPosition="left"
              itemType="app"
              label="채널별 매출현황"
              parentKey="a184b"
            />
            <Option
              id="ed03a"
              appTarget="2f799e00-1a2a-11f0-8cd9-e37cf2af7c39"
              disabled={false}
              hidden={false}
              icon="bold/interface-setting-cog"
              iconPosition="left"
              itemType="app"
              label="설정/관리"
            />
            <Event
              event="logoClick"
              method="openApp"
              params={{
                ordered: [{ uuid: "ef24d28c-f99c-11ef-8c58-efeb0ef80c88" }],
              }}
              pluginId=""
              type="util"
              waitMs="0"
              waitType="debounce"
            />
            <Event
              event="click"
              method="openUrl"
              params={{
                ordered: [
                  {
                    url: "https://ettoi-bi.bungee.work/public/dashboard/75dfa11c-007a-4989-b6ce-2413acd1e2ab",
                  },
                ],
              }}
              pluginId=""
              targetId="fece9"
              type="util"
              waitMs="0"
              waitType="debounce"
            />
            <Event
              event="click"
              method="run"
              params={{
                ordered: [
                  {
                    src: "switch(localStorage.values.toolbar_br_cd){\n  case '01': {\n    utils.openApp('f21d971a-d3f6-11ef-89bd-6f266399acb3', {\n      newTab: false,\n    })\n  } break;\n  case '07': {\n    utils.openApp('d9dd5858-d39b-11ef-a502-3f868f2c0aad', {\n      newTab: false,\n    })\n  } break;\n  case '79': {\n    \n  } break;\n}",
                  },
                ],
              }}
              pluginId=""
              targetId="190c8"
              type="script"
              waitMs="0"
              waitType="debounce"
            />
            <Event
              event="click"
              method="openUrl"
              params={{
                ordered: [
                  {
                    url: "https://ettoi-bi.bungee.work/public/dashboard/75dfa11c-007a-4989-b6ce-2413acd1e2ab",
                  },
                ],
              }}
              pluginId=""
              targetId="1abad"
              type="util"
              waitMs="0"
              waitType="debounce"
            />
          </Navigation>
          <Navigation
            id="navigation2"
            hidden=""
            horizontalAlignment="right"
            itemMode="static"
            retoolFileObject={{ ordered: [] }}
          >
            <Option
              id="542ad"
              icon="bold/interface-link-square"
              iconPosition="left"
              itemType="app"
              key="5d597"
              label="MD page 이동"
            />
            <Option
              id="76ba3"
              appTarget="d499ad1c-113d-11f0-864d-5ff5d5683925"
              disabled={false}
              hidden={false}
              iconPosition="left"
              itemType="app"
              label="에뜨와"
              parentKey="5d597"
            />
            <Option
              id="3358b"
              appTarget="77ea68b0-1127-11f0-a410-cbd0cb28563d"
              disabled={false}
              hidden={false}
              iconPosition="left"
              itemType="app"
              label="아가방"
              parentKey="5d597"
            />
            <Option
              id="d4753"
              appTarget="af525d9c-113d-11f0-8a0b-3bdb65966113"
              disabled={false}
              hidden={false}
              iconPosition="left"
              itemType="app"
              label="디즈니베이비"
              parentKey="5d597"
            />
            <Option
              id="812a3"
              disabled={false}
              hidden={false}
              icon="bold/interface-help-customer-support-1"
              iconPosition="replace"
              itemType="app"
              key="653b17ab-cbee-4289-906c-10e88832fb1b"
              label="Menu item 6"
            />
            <Option
              id="376ea"
              disabled={false}
              icon="bold/mail-chat-bubble-oval-question-alternate"
              iconPosition="left"
              itemType="custom"
              label="버그 제보/개선 요청"
              parentKey="653b17ab-cbee-4289-906c-10e88832fb1b"
              tooltip="버그 제보 및 기능 개선 요청"
            >
              <Event
                event="click"
                method="openUrl"
                params={{
                  ordered: [
                    {
                      url: "https://agabang.cleave.work/app/reports_management/form#email={{ current_user.email }}&name={{ current_user.fullName }}&url={{ urlparams.href }}&version={{ retoolContext.pageTag }}&app_name={{ decodeURIComponent(retoolContext.appName) }}",
                    },
                  ],
                }}
                pluginId=""
                type="util"
                waitMs="0"
                waitType="debounce"
              />
            </Option>
            <Option
              id="d3841"
              appTarget="f7886b86-67b1-11f0-b2e8-b37eb6286f64"
              disabled={false}
              hidden={false}
              icon="bold/interface-content-note-pad-text-alternate"
              iconPosition="left"
              itemType="app"
              label="문의 내역 확인하기"
              parentKey="653b17ab-cbee-4289-906c-10e88832fb1b"
              screenTargetId="all_reports"
            />
          </Navigation>
          <DropdownButton
            id="AccountDropdown"
            _colorByIndex={["", "", ""]}
            _fallbackTextByIndex={["", "", ""]}
            _imageByIndex={["", "", ""]}
            _values={["", "", "Action 3"]}
            horizontalAlign="right"
            icon="bold/interface-user-circle"
            itemMode="static"
            margin="8px 2px 6px 8px"
            overlayMaxHeight={375}
            style={{
              ordered: [
                { fontSize: "12px" },
                { fontWeight: "600" },
                { fontFamily: "Pretendard Variable" },
                { icon: "#292929" },
              ],
            }}
            styleVariant="outline"
            text="{{current_user.lastName}}{{current_user.firstName}}"
          >
            <Option
              id="16e70"
              caption="{{ current_user.email }}"
              disabled="true"
              icon="bold/interface-user-circle"
              label="{{current_user.lastName}}{{current_user.firstName}}"
            />
            <Option
              id="516a6"
              icon="bold/interface-logout-circle-alternate"
              label="로그아웃"
            >
              <Event
                event="click"
                method="openUrl"
                params={{
                  ordered: [
                    { url: "/logout" },
                    { options: { ordered: [{ newTab: false }] } },
                  ],
                }}
                pluginId=""
                type="util"
                waitMs="0"
                waitType="debounce"
              />
            </Option>
            <Option
              id="4ae08"
              disabled={false}
              hidden="true"
              icon="bold/interface-user-profile-focus"
              label="개인정보 재설정"
            />
          </DropdownButton>
        </View>
      </Container>
    </ModuleContainerWidget>
  </Frame>
</App>
