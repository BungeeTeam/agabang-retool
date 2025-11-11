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
    primary="#dd5e2c"
    secondary="#4f6d7a"
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
  <AppStyles id="$appStyles" css={include("./lib/$appStyles.css", "string")} />
  <Include src="./header.rsx" />
  <Include src="./src/modalFrame1.rsx" />
  <Include src="./src/modalFrame2.rsx" />
  <Frame
    id="$main"
    enableFullBleed={false}
    isHiddenOnDesktop={false}
    isHiddenOnMobile={false}
    padding="8px 12px"
    sticky={null}
    type="main"
  >
    <Include src="./src/tabbedContainer2.rsx" />
    <ListViewBeta
      id="image_list_view"
      _primaryKeys="{{ i }}"
      data="{{ get_image_list.data }}"
      itemWidth="200px"
      layoutType="grid"
      margin="0"
      numColumns="4"
      padding="0"
    >
      <Container
        id="container4"
        footerPadding="4px 12px"
        headerPadding="0px 12px 0px 12px"
        padding="12px"
        showBody={true}
        showHeader={true}
      >
        <Header>
          <Icon
            id="icon1"
            horizontalAlign="center"
            icon="bold/interface-delete-bin-2"
            margin="0"
            style={{ ordered: [{ color: "rgba(58, 59, 60, 0.3)" }] }}
          >
            <Event
              event="click"
              method="setValue"
              params={{ ordered: [{ value: "{{ item.s3_key }}" }] }}
              pluginId="sel_s3_key"
              type="state"
              waitMs="0"
              waitType="debounce"
            />
            <Event
              event="click"
              method="trigger"
              params={{ ordered: [] }}
              pluginId="delete_image"
              type="datasource"
              waitMs="0"
              waitType="debounce"
            />
          </Icon>
          <Container
            id="stack1"
            _align="center"
            _gap="0px"
            _type="stack"
            footerPadding="4px 12px"
            headerPadding="4px 12px"
            heightType="fixed"
            margin="0"
            padding="0"
            showBody={true}
            showBorder={false}
          >
            <View id="96d49" viewKey="View 1">
              <Text
                id="containerTitle4"
                style={{
                  ordered: [
                    { fontSize: "12px" },
                    { fontWeight: "900" },
                    {
                      fontFamily:
                        '"Pretendard Variable", Pretendard, -apple-system, BlinkMacSystemFont, system-ui, Roboto, "Helvetica Neue", "Segoe UI", "Apple SD Gothic Neo", "Noto Sans KR", "Malgun Gothic", "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol", sans-serif',
                    },
                  ],
                }}
                value={
                  "**{{ item.s3_key.split('/')[3].replace(\"..\", \".\").split('.')[0] }}**"
                }
                verticalAlign="center"
              />
              <Text
                id="text5"
                heightType="fill"
                overflowType="hidden"
                style={{
                  ordered: [
                    { fontSize: "labelFont" },
                    { fontWeight: "labelFont" },
                    { fontFamily: "labelFont" },
                    {
                      color:
                        '{{ text5.value.includes("없음") ? "warning" : "#000000" }}',
                    },
                  ],
                }}
                value={
                  "{{ \n  (() => {\n    const parts = item.s3_key?.split('/');\n    if (!parts || parts.length <= 3) return '경로 오류';\n    \n    // 파일명 부분 추출\n    const fileName = parts[3];\n    if (!fileName) return '파일명 없음';\n    \n    // \"..\" -> \".\" 변환 후 확장자 제거\n    const cleanedName = fileName.replace(\"..\", \".\");\n    const nameParts = cleanedName.split('.');\n    if (!nameParts || nameParts.length === 0) return '파싱 오류';\n    \n    const preview_cd = nameParts[0];\n    if (!preview_cd || !get_matched_preview_cd_and_item.data?.preview_cd) return '기획현황에 이 품평코드가 없음';\n    \n    const index = get_matched_preview_cd_and_item.data.preview_cd.indexOf(preview_cd);\n    if (index === -1) return '매핑된 상품 없음';\n    \n    // 데이터 추출\n    const sty_nm = get_matched_preview_cd_and_item.data.sty_nm?.[index] || '';\n    const sty_cd = get_matched_preview_cd_and_item.data.sty_cd?.[index] || '';\n    const col_nm = get_matched_preview_cd_and_item.data.col_nm?.[index] || '';\n    const col_cd = get_matched_preview_cd_and_item.data.col_cd?.[index] || '';\n    \n    // col_cd가 없으면 col_nm 사용\n    const color_code = col_cd || col_nm;\n    \n    // 형식: 상품명_컬러명(상품코드_컬러코드)\n    return `${sty_nm} ${col_nm} (${sty_cd})`;\n  })()\n}}"
                }
                verticalAlign="center"
              />
            </View>
          </Container>
        </Header>
        <View id="21f73" viewKey="View 1">
          <Image
            id="image1"
            fit="contain"
            heightType="fixed"
            horizontalAlign="center"
            src={
              "{{ \"https://agabang-image.s3.ap-northeast-2.amazonaws.com/\" + item.s3_key.split('/').map(part => encodeURIComponent(part)).join('/') }}"
            }
            style={{ ordered: [{ borderColor: "info" }] }}
          >
            <Event
              event="click"
              method="show"
              params={{ ordered: [] }}
              pluginId="modalFrame1"
              type="widget"
              waitMs="0"
              waitType="debounce"
            />
            <Event
              event="click"
              method="setValue"
              params={{ ordered: [{ value: "{{item.s3_key}}" }] }}
              pluginId="sel_s3_key"
              type="state"
              waitMs="0"
              waitType="debounce"
            />
          </Image>
          <Image
            id="image2"
            fit="contain"
            heightType="fixed"
            horizontalAlign="center"
            src={
              "{{ \"https://agabang-image.s3.ap-northeast-2.amazonaws.com/\" + item.transform_s3_key.split('/').map(part => encodeURIComponent(part)).join('/') }}"
            }
            style={{ ordered: [{ borderColor: "primary" }] }}
          >
            <Event
              event="click"
              method="show"
              params={{ ordered: [] }}
              pluginId="modalFrame1"
              type="widget"
              waitMs="0"
              waitType="debounce"
            />
            <Event
              event="click"
              method="setValue"
              params={{ ordered: [{ value: "{{item.transform_s3_key}}" }] }}
              pluginId="sel_s3_key"
              type="state"
              waitMs="0"
              waitType="debounce"
            />
          </Image>
        </View>
      </Container>
    </ListViewBeta>
  </Frame>
</App>
