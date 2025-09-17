<Container
  id="stack1"
  _align="center"
  _direction="vertical"
  _flexWrap={true}
  _gap="0px"
  _type="stack"
  footerPadding="4px 12px"
  headerPadding="4px 12px"
  padding="12px"
  showBody={true}
  showBorder={false}
>
  <View id="77d37" viewKey="View 1">
    <Button
      id="button5"
      heightType="auto"
      style={{ ordered: [] }}
      styleVariant="outline"
      text="메인으로 돌아가기"
    >
      <Event
        event="click"
        method="openUrl"
        params={{
          ordered: [
            { url: "https://agabang.cleave.work/app/landing-page" },
            { options: { ordered: [{ newTab: true }] } },
          ],
        }}
        pluginId=""
        type="util"
        waitMs="0"
        waitType="debounce"
      />
    </Button>
    <Text
      id="text11"
      horizontalAlign="center"
      style={{
        ordered: [
          { fontSize: "16px" },
          { fontWeight: "500" },
          { fontFamily: "Pretendard Variable" },
        ],
      }}
      value="## 제보/요청이 성공적으로 접수되었습니다.
소중한 의견을 남겨주셔서 진심으로 감사드립니다!
담당자가 내용을 확인한 후, 빠르게 처리될 수 있도록 최선을 다하겠습니다."
      verticalAlign="center"
    />
    <Spacer id="spacer17" />
    <Button
      id="button7"
      heightType="auto"
      hidden="{{!url.hashParams.url}}"
      style={{ ordered: [] }}
      styleVariant="outline"
      text="이전 화면으로 돌아가기"
    >
      <Event
        event="click"
        method="openUrl"
        params={{
          ordered: [
            { url: "{{url.hashParams.url}}" },
            { options: { ordered: [{ newTab: true }] } },
          ],
        }}
        pluginId=""
        type="util"
        waitMs="0"
        waitType="debounce"
      />
    </Button>
    <Button
      id="button8"
      heightType="auto"
      style={{ ordered: [] }}
      styleVariant="outline"
      text="문의 내용 확인하기"
    >
      <Event
        event="click"
        method="openUrl"
        params={{
          ordered: [
            {
              url: "https://agabang.cleave.work/app/reports_management/all_reports#id={{ result.value?.id }}",
            },
            { options: { ordered: [{ newTab: true }] } },
          ],
        }}
        pluginId=""
        type="util"
        waitMs="0"
        waitType="debounce"
      />
    </Button>
  </View>
</Container>
