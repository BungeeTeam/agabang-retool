<ModalFrame
  id="modalFrame3"
  footerPadding="8px 12px"
  headerPadding="8px 12px"
  hidden={true}
  hideOnEscape={true}
  isHiddenOnMobile={true}
  overlayInteraction={true}
  padding="8px 12px"
  showFooter={true}
  showHeader={true}
  showOverlay={true}
  size="medium"
>
  <Header>
    <Text
      id="modalTitle5"
      value="### 리오더 시뮬레이션 가이드"
      verticalAlign="center"
    />
    <Button
      id="modalCloseButton6"
      ariaLabel="Close"
      horizontalAlign="right"
      iconBefore="bold/interface-delete-1"
      style={{ ordered: [{ border: "transparent" }] }}
      styleVariant="outline"
    >
      <Event
        event="click"
        method="setHidden"
        params={{ ordered: [{ hidden: true }] }}
        pluginId="modalFrame3"
        type="widget"
        waitMs="0"
        waitType="debounce"
      />
    </Button>
  </Header>
  <Body>
    <Text
      id="text31"
      value="#### 핵심 개념 이해하기
리오더 시뮬레이션은 다음 세 가지 핵심 요소를 중심으로 진행됩니다:

- 현재 상태: 현재 재고와 판매 데이터
- 설정 값: 목표 판매율, 판매 기간, 리드타임 등
- 계산 결과: 리오더 수량 및 예상 결과

#### 주요 값 설명
1. 입력 데이터
    - 총 재고량: 현재 보유한 총 재고 수량 (매장 재고 + 창고 재고)
    - 업체 재고: 생산업체가 보유한 추가 재고
    - 일평균 판매량: 과거 판매 데이터 기반 일일 평균 판매량(180일 > 365일 > 30일 순 우선적용)

2. 설정 값
    - 확정 리드타임: 리오더 발주부터 입고까지 소요되는 일수
    - 예상 판매기간: 리오더 이후 상품 판매를 예상하는 기간(월)
    - 목표 판매율: 리오더한 상품의 판매 목표 비율(기본 80%)
    - 확정 MOQ: 최소 주문 가능 수량
    - 안전 재고: 최소한으로 유지해야 할 재고(일반적으로 매장 수 × 1)

3. 계산 값
    - 리드타임 예상 판매량: 리드타임 동안 예상되는 판매량
    - 전체 기간 예상 판매량: 설정한 판매 기간 동안 예상되는 총 판매량
    - 리오더 필요 수량: 계산된 리오더 필요 수량 (반올림 전).
      - (전체 기간 예상 판매량 + 안전 재고 - (총 재고량 + 업체 재고)) ÷ 목표 판매율
    - 최종 리오더 수량: 리오더 필요량을 10단위로 올리고 MOQ와 비교해 최종 결정
      - MAX(리오더 필요량 올림값, 확정 MOQ)
    - 예상 잔여 재고: 리오더 후 판매 기간이 지난 후 예상되는 남은 재고
      - (총 재고량 + 업체 재고 + 최종 리오더 수량) - 전체 기간 예상 판매량
    - 예상 최종 판매율: 리오더와 예상 판매를 포함한 최종 예상 판매율
      - (누계 판매량 + 전체 기간 예상 판매량) ÷ (총 입고량 + 최종 리오더 수량)"
      verticalAlign="center"
    />
  </Body>
</ModalFrame>
