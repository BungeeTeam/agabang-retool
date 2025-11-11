<Container
  id="container4"
  _flexWrap={true}
  _gap="0px"
  _justify="space-between"
  _type="stack"
  footerPadding="4px 12px"
  headerPadding="4px 12px"
  margin="0"
  padding="0 0 10px 0"
  showBody={true}
  showBorder={false}
>
  <View id="fe38f" viewKey="View 1">
    <Container
      id="stack14"
      _direction="vertical"
      _flexWrap={true}
      _gap="0px"
      _type="stack"
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      margin="0"
      padding="0"
      showBody={true}
      showBorder={false}
    >
      <View id="76573" viewKey="View 1">
        <Text
          id="text41"
          style={{
            ordered: [
              { fontSize: "h5Font" },
              { fontWeight: "h5Font" },
              { fontFamily: "h5Font" },
            ],
          }}
          value="#### 1. 생산"
          verticalAlign="center"
        />
        <KeyValue
          id="keyValueProductInfo"
          data="{{ item.production_info }}"
          editIcon="bold/interface-edit-pencil"
          enableSaveActions={true}
          groupLayout="singleColumn"
          labelWrap={true}
        >
          <Property
            id="생산업체"
            editable="false"
            editableOptions={{}}
            format="string"
            formatOptions={{}}
            hidden="false"
            label="생산업체"
          />
          <Property
            id="TAG가"
            editable="false"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            hidden="false"
            label="Tag가"
          />
          <Property
            id="원가"
            editable="false"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            hidden="false"
            label="원가"
          />
          <Property
            id="배수"
            editable="false"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            hidden="false"
            label="배수"
          />
          <Property
            id="리오더 TAG가"
            editable="true"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            hidden="false"
            label="리오더 Tag가"
          />
          <Property
            id="리오더 원가"
            editable="true"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            hidden="false"
            label="리오더 원가"
          />
          <Property
            id="리오더 배수"
            editable="false"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            hidden="false"
            label="리오더 배수"
          />
          <Property
            id="입고 수량"
            editable="false"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            hidden="false"
            label="입고 수량"
          />
          <Property
            id="출고 수량"
            editable="false"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            hidden="false"
            label="출고 수량"
          />
          <Property
            id="매장재고"
            editable="false"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            hidden="true"
            label="매장재고"
          />
          <Property
            id="창고재고"
            editable="false"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            hidden="true"
            label="창고재고"
          />
          <Property
            id="출고일"
            editable="false"
            editableOptions={{}}
            format="date"
            formatOptions={{ dateFormat: "yyyy-MM-dd" }}
            hidden="false"
            label="출고일"
          />
          <Property
            id="출고율"
            editable="false"
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            hidden="false"
            label="출고율"
          />
          <Property
            id="groupId"
            editable="false"
            editableOptions={{}}
            format="string"
            formatOptions={{}}
            hidden="true"
            label="Group ID"
          />
          <Property
            id="note"
            editable="false"
            editableOptions={{}}
            format="multilineString"
            formatOptions={{}}
            hidden="false"
            label="생산팀 메모"
          />
          <Property
            id="생산팀 메모"
            editable="false"
            editableOptions={{}}
            format="string"
            formatOptions={{}}
            hidden="true"
            label="생산팀 메모"
          />
          <Event
            event="save"
            method="trigger"
            params={{ ordered: [] }}
            pluginId="saveColorEdits"
            type="datasource"
            waitMs="0"
            waitType="debounce"
          />
        </KeyValue>
      </View>
    </Container>
    <Container
      id="stack17"
      _direction="vertical"
      _flexWrap={true}
      _gap="0px"
      _type="stack"
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      margin="0"
      padding="0"
      showBody={true}
      showBorder={false}
    >
      <View id="76573" viewKey="View 1">
        <Text
          id="text44"
          style={{
            ordered: [
              { fontSize: "h5Font" },
              { fontWeight: "h5Font" },
              { fontFamily: "h5Font" },
            ],
          }}
          value="#### 4. 시뮬레이션"
          verticalAlign="center"
        />
        <Chart
          id="reorderSimulationChart"
          chartType="plotlyJson"
          margin="0"
          plotlyDataJson={
            "{{\n    (() => {\n      if (!reorderSimulation?.data?.length) {\n        return [{ x: [], y: [], type: 'scatter', mode: 'lines+markers', name: 'Loading...' }];\n      }\n  \n      const data = reorderSimulation.data;\n      const lastPoint = data[data.length - 1];\n  \n      const currentSelectedItem = item || selectedReorderItems.value.find(\n          d => d.reorder_info.groupId === reorderSimulation.data[0].groupId\n      );\n  \n      if (!currentSelectedItem) {\n        console.warn(\"Matching item not found in selectedReorderItems for chart data.\");\n        return [{ x: [], y: [], type: 'scatter', mode: 'lines+markers', name: '데이터 없음' }];\n      }\n  \n      const baseQty = parseFloat(lastPoint.sale_cumsum) || 0; // 마지막 실제 누적 판매량 (202)\n  \n      // selectedReorderItems에서 필요한 정보 가져오기\n      // '기준일~마감일 예상 판매량'은 기준일 이후의 총 예상 판매량을 의미\n      const expectedSalesUntilEndDate = parseFloat(currentSelectedItem.reorder_info['기준일~마감일 예상 판매량']) || 0;\n      \n      // 이전에 사용하던 itemDailySales와 growthFactor는 이제 forecastDailySales를 직접 계산하므로 필요 없음\n      // const itemDailySales = parseFloat(currentSelectedItem.sales_performance['일 판매량']) || 0;\n      // const growthRatePercent = parseFloat(currentSelectedItem.reorder_info['성장률(%)']) || 100;\n      // const growthFactor = growthRatePercent / 100;\n  \n      const totalInQty = parseFloat(lastPoint.tot_in_qty) || 653;\n      const reorderQty = currentSelectedItem.reorder_info['리오더 필요 수량'] || 938;\n      const leadTime = currentSelectedItem.reorder_info['리드타임(일)'] || 60;\n      const baseDate = new Date(lastPoint.sale_dt); // 마지막 실제 판매일 (기준일)\n      const salesEndDate = new Date(currentSelectedItem.reorder_info['판매 마감일']); // 판매 마감일\n  \n      const forecastData = [];\n      let cumulativeSales = baseQty; // 예측 시작점은 실제 판매의 마지막 누적 판매량 (202)\n  \n      const daysToForecast = Math.ceil((salesEndDate.getTime() - baseDate.getTime()) / (1000 * 60 * 60 * 24));\n  \n      // 예측 일일 판매량 계산\n      // '기준일~마감일 예상 판매량'을 남은 일수로 나누어 일일 평균 판매량을 구합니다.\n      // 이는 이 기간 동안 판매량이 선형적으로 증가한다고 가정합니다.\n      const averageDailyForecastedSales = daysToForecast > 0 ? expectedSalesUntilEndDate / daysToForecast : 0;\n  \n      for (let i = 1; i <= daysToForecast; i++) {\n        const futureDate = new Date(baseDate);\n        futureDate.setDate(futureDate.getDate() + i);\n  \n        // 누적 판매량에 일일 평균 예측 판매량을 더함\n        cumulativeSales += averageDailyForecastedSales;\n  \n        forecastData.push({\n          date: futureDate.toISOString().split('T')[0],\n          cumSales: cumulativeSales,\n          daysFromNow: i\n        });\n      }\n  \n      const traces = [];\n  \n      // 1. 실제 누적 판매\n      traces.push({\n        x: data.map(d => d.sale_dt),\n        y: data.map(d => parseFloat(d.sale_cumsum)),\n        type: 'scatter', mode: 'lines+markers', name: '실제 판매',\n        line: { color: '#E74C3C', width: 3 },\n        marker: { size: 6 },\n        hovertemplate: '<b>실제 판매</b><br>%{x}<br>누적: %{y:,.0f}개<extra></extra>'\n      });\n  \n      // 2. 예측 누적 판매\n      traces.push({\n        x: forecastData.map(d => d.date),\n        y: forecastData.map(d => Math.round(d.cumSales)), // 반올림하여 정수로 표시\n        type: 'scatter', mode: 'lines', name: '예측 판매',\n        line: { color: '#E74C3C', width: 2, dash: 'dash' }, opacity: 0.5,\n        hovertemplate: '<b>예측 판매</b><br>%{x}<br>누적: %{y:,.0f}개<extra></extra>'\n      });\n  \n      // 3. 입고량 (리오더 X)\n      const allDatesForInventory = [...data.map(d => d.sale_dt), ...forecastData.map(d => d.date)];\n      const uniqueSortedDates = Array.from(new Set(allDatesForInventory)).sort();\n  \n      traces.push({\n        x: uniqueSortedDates,\n        y: uniqueSortedDates.map(() => totalInQty),\n        type: 'scatter', mode: 'lines', name: '입고량 (리오더 X)',\n        line: { color: '#7F8C8D', width: 3 }, opacity: 0.9,\n        hovertemplate: '<b>입고량 (리오더 X)</b><br>수량: %{y:,.0f}개<extra></extra>'\n      });\n  \n      // 4. 입고량 (리오더 O)\n      const reorderDate = new Date(baseDate);\n      reorderDate.setDate(reorderDate.getDate() + leadTime);\n      const reorderDateStr = reorderDate.toISOString().split('T')[0];\n  \n      const reorderIndex = forecastData.findIndex(d => d.date === reorderDateStr);\n      \n      traces.push({\n        x: forecastData.map(d => d.date),\n        y: forecastData.map((_, i) => {\n            if (reorderIndex === -1 || i < reorderIndex) {\n                return totalInQty;\n            }\n            return totalInQty + reorderQty;\n        }),\n        type: 'scatter', mode: 'lines', name: '입고량 (리오더 O)',\n        line: { color: '#27AE60', width: 3 },\n        hovertemplate: '<b>입고량 (리오더 O)</b><br>수량: %{y:,.0f}개<extra></extra>'\n      });\n  \n      return traces;\n    })()\n  }}"
          }
          plotlyLayoutJson={
            "{{ (() => {\n  // reorderSimulation.data가 로드되지 않았거나 비어있을 경우를 대비한 초기 반환\n  if (!reorderSimulation || !reorderSimulation.data || !Array.isArray(reorderSimulation.data) || reorderSimulation.data.length === 0) {\n    // 데이터가 없을 때, 기본 레이아웃을 반환하되 x축 범위를 유효하게 설정\n    // item 변수가 없을 수도 있으므로 selectedReorderItems의 첫 번째 항목을 사용하거나 기본값 설정\n    const defaultSalesEndDate = new Date();\n    defaultSalesEndDate.setMonth(defaultSalesEndDate.getMonth() + 6); // 현재 날짜로부터 6개월 후\n    const salesEndDateStr = (item?.reorder_info?.['판매 마감일'] || selectedReorderItems.value?.[0]?.reorder_info?.['판매 마감일'] || defaultSalesEndDate.toISOString().split('T')[0]);\n\n    const startChartDate = new Date().toISOString().split('T')[0];\n    const endChartDate = new Date(salesEndDateStr);\n    endChartDate.setDate(endChartDate.getDate() + 1); // 판매 마감일 다음 날까지 확장\n\n    return {\n      margin: {l: 20, r: 20, b: 20, t: 20, pad: 4},\n      xaxis: {\n        title: '', // Changed to empty string\n        automargin: true,\n        tickformat: '%Y-%m-%d',\n        range: [startChartDate, endChartDate.toISOString().split('T')[0]]\n      },\n      yaxis: {\n        title: '', // Changed to empty string\n        automargin: true\n      },\n      showlegend: true,\n      legend: {\n        orientation: 'h', // 가로 방향\n        x: 0.5,           // 차트 하단 중앙으로 이동\n        y: -0.2,          // 차트 아래에 위치\n        xanchor: 'center',// 중앙 정렬\n        yanchor: 'top'    // 상단에 정렬 (y: -0.2와 함께 사용 시 하단)\n      },\n      hovermode: 'x unified'\n    };\n  }\n\n  const data = reorderSimulation.data;\n  const lastPoint = data[data.length - 1];\n\n  // selectedReorderItems에서 현재 선택된 아이템 정보 가져오기\n  // item 변수가 Retool에서 선택된 행의 데이터를 자동으로 주입한다고 가정합니다.\n  // 만약 item이 유효하지 않다면, selectedReorderItems 배열에서 groupId를 통해 찾습니다.\n  const currentSelectedItem = item || selectedReorderItems.value.find(\n      d => d.reorder_info.groupId === lastPoint.groupId // reorderSimulation data의 groupId와 일치하는 아이템 찾기\n  );\n\n  // currentSelectedItem이 유효한지 다시 한번 확인\n  if (!currentSelectedItem || !currentSelectedItem.reorder_info || !currentSelectedItem.sales_performance) {\n    console.warn(\"currentSelectedItem is not valid, cannot set chart layout ranges.\");\n    // 유효하지 않을 경우, 기본값을 포함한 레이아웃 반환\n    const defaultSalesEndDate = new Date();\n    defaultSalesEndDate.setMonth(defaultSalesEndDate.getMonth() + 6);\n    const salesEndDateStr = defaultSalesEndDate.toISOString().split('T')[0];\n\n    const startChartDate = new Date().toISOString().split('T')[0];\n    const endChartDate = new Date(salesEndDateStr);\n    endChartDate.setDate(endChartDate.getDate() + 1);\n\n    return {\n      margin: {l: 20, r: 20, b: 20, t: 20, pad: 4},\n      xaxis: {\n        title: '', // Changed to empty string\n        automargin: true,\n        tickformat: '%Y-%m-%d',\n        range: [startChartDate, endChartDate.toISOString().split('T')[0]]\n      },\n      yaxis: {\n        title: '', // Changed to empty string\n        automargin: true\n      },\n      showlegend: true,\n      legend: {\n        orientation: 'h', // 가로 방향\n        x: 0.5,           // 차트 하단 중앙으로 이동\n        y: -0.2,          // 차트 아래에 위치\n        xanchor: 'center',// 중앙 정렬\n        yanchor: 'top'    // 상단에 정렬 (y: -0.2와 함께 사용 시 하단)\n      },\n      hovermode: 'x unified'\n    };\n  }\n\n  // 차트의 시작 날짜를 실제 데이터의 첫 날짜로 설정\n  const chartStartDate = data[0].sale_dt;\n  \n  // 판매 마감일을 Date 객체로 파싱\n  const salesEndDate = new Date(currentSelectedItem.reorder_info['판매 마감일']);\n\n  // 판매 마감일 다음 날을 계산하여 x축의 끝 범위로 사용\n  const salesEndDatePlusOne = new Date(salesEndDate);\n  salesEndDatePlusOne.setDate(salesEndDatePlusOne.getDate() + 1); // 하루 추가\n  const salesEndDatePlusOneStr = salesEndDatePlusOne.toISOString().split('T')[0];\n\n  return {\n    margin: {\n      l: 20, // left margin\n      r: 20, // right margin\n      b: 20, // bottom margin\n      t: 20, // top margin\n      pad: 4 // padding between the plot area and the axis labels\n    },\n    xaxis: {\n      title: '', // Changed to empty string\n      automargin: true,\n      tickformat: '%Y-%m-%d', // 날짜 형식YYYY-MM-DD\n      range: [chartStartDate, salesEndDatePlusOneStr] // x축 범위 설정 (판매 마감일 다음 날까지)\n    },\n    yaxis: {\n      title: '', // Changed to empty string\n      automargin: true\n    },\n    showlegend: true,\n    legend: {\n      orientation: 'h', // 가로 방향\n      x: 0.5,           // 차트 하단 중앙으로 이동\n      y: -0.2,          // 차트 아래에 위치\n      xanchor: 'center',// 중앙 정렬\n      yanchor: 'top'    // 상단에 정렬 (y: -0.2와 함께 사용 시 하단)\n    },\n    hovermode: 'x unified' // x축을 따라 hover 정보 표시\n  };\n})() }}"
          }
          selectedPoints="[]"
        />
      </View>
    </Container>
    <Container
      id="stack16"
      _direction="vertical"
      _flexWrap={true}
      _gap="0px"
      _type="stack"
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      margin="0"
      padding="0"
      showBody={true}
      showBorder={false}
    >
      <View id="76573" viewKey="View 1">
        <Text
          id="text43"
          style={{
            ordered: [
              { fontSize: "h5Font" },
              { fontWeight: "h5Font" },
              { fontFamily: "h5Font" },
            ],
          }}
          value="#### 3.  리오더 수량 결정"
          verticalAlign="center"
        />
        <KeyValue
          id="keyValueReorderInfo"
          data="{{ item.reorder_info }}"
          editIcon="bold/interface-edit-pencil"
          enableSaveActions={true}
          groupLayout="singleColumn"
          labelWrap={true}
          style={{}}
        >
          <Property
            id="리드타임(일)"
            editable={true}
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            hidden="false"
            label="리드타임(일)"
          />
          <Property
            id="리오더 납기일"
            editable="false"
            editableOptions={{}}
            format="date"
            formatOptions={{ dateFormat: "yyyy-MM-dd" }}
            hidden="false"
            label="리오더 납기일"
          />
          <Property
            id="판매 마감일"
            editable="true"
            editableOptions={{}}
            format="date"
            formatOptions={{ dateFormat: "yyyy-MM-dd" }}
            hidden="false"
            label="판매 마감일"
          />
          <Property
            id="리오더 납기일~판매 마감일"
            editable="false"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            hidden="false"
            label="리오더 납기일~판매 마감일"
          />
          <Property
            id="성장률(%)"
            editable="true"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            hidden="false"
            label="성장률(%)"
          />
          <Property
            id="기준일~판매 마감일"
            editable="false"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            hidden="false"
            label="기준일~판매 마감일"
          />
          <Property
            id="기준일~마감일 예상 판매량"
            editable="false"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "",
            }}
            hidden="false"
            label="기준일~마감일 예상 판매량"
            valueOverride="{{ item.toFixed(0) }}"
          />
          <Property
            id="현재 총재고"
            editable="false"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            hidden="false"
            label="현재 총재고"
          />
          <Property
            id="부족 수량"
            editable="false"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            hidden="false"
            label="부족 수량"
          />
          <Property
            id="목표 판매율(%)"
            editable="true"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            hidden="false"
            label="목표 판매율(%)"
          />
          <Property
            id="리오더 필요 수량"
            editable="false"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "0",
            }}
            hidden="false"
            label="리오더 필요 수량"
          />
          <Property
            id="MD 메모"
            editable="true"
            editableOptions={{}}
            format="string"
            formatOptions={{}}
            hidden="false"
            label="MD 메모"
            placeholder="추후 리오더 이력 확인 시 참고할만한 특이사항이 있으면 메모로 남겨주세요."
          />
          <Property
            id="groupId"
            editable="false"
            editableOptions={{}}
            format="string"
            formatOptions={{}}
            hidden="true"
            label="Group ID"
          />
          <Event
            event="save"
            method="trigger"
            params={{ ordered: [] }}
            pluginId="saveColorEdits"
            type="datasource"
            waitMs="0"
            waitType="debounce"
          />
        </KeyValue>
      </View>
    </Container>
    <Container
      id="stack15"
      _direction="vertical"
      _flexWrap={true}
      _gap="0px"
      _type="stack"
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      margin="0"
      padding="0"
      showBody={true}
      showBorder={false}
    >
      <View id="76573" viewKey="View 1">
        <Text
          id="text42"
          style={{
            ordered: [
              { fontSize: "h5Font" },
              { fontWeight: "h5Font" },
              { fontFamily: "h5Font" },
            ],
          }}
          value="#### 2. 판매실적"
          verticalAlign="center"
        />
        <KeyValue
          id="keyValueSalesPerformance"
          data="{{ item.sales_performance }}"
          editIcon="bold/interface-edit-pencil"
          enableSaveActions={true}
          groupLayout="singleColumn"
          labelWrap={true}
        >
          <Property
            id="기준일"
            editable="false"
            editableOptions={{
              minDate: "",
              maxDate:
                "{{new Date(new Date().setDate(new Date().getDate() - 1))}}",
            }}
            format="date"
            formatOptions={{ dateFormat: "yyyy-MM-dd" }}
            hidden="false"
            label="기준일"
          />
          <Property
            id="누적 판매량"
            editable="false"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            hidden="false"
            label="누적 판매량"
          />
          <Property
            id="누적 판매율(입고 기준)"
            editable="false"
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            hidden="false"
            label="누적 판매율(입고 기준)"
          />
          <Property
            id="출고~기준일 판매일수"
            editable="false"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            hidden="false"
            label="출고~기준일 판매일수"
          />
          <Property
            id="판매일수"
            editable="false"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            hidden="false"
            label="판매일수"
          />
          <Property
            id="일 판매량"
            editable="false"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            hidden="false"
            label="일 판매량"
          />
          <Property
            id="매장수"
            editable="false"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            hidden="false"
            label="매장수"
          />
          <Property
            id="최근 7일 판매량"
            editable="false"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            hidden="false"
            label="최근 7일 판매량"
            valueOverride="{{ item.toFixed(0) }}"
          />
          <Property
            id="최근 7일 판매율(출고 기준)"
            editable="false"
            editableOptions={{ showStepper: true }}
            format="percent"
            formatOptions={{
              showSeparators: true,
              notation: "standard",
              decimalPlaces: "",
            }}
            hidden="false"
            label="최근 7일 판매율(출고 기준)"
          />
          <Property
            id="매장당 일 판매량"
            editable="false"
            editableOptions={{ showStepper: true }}
            format="decimal"
            formatOptions={{ showSeparators: true, notation: "standard" }}
            hidden="false"
            label="매장당 일 판매량"
            valueOverride="{{ item.toFixed(2) }}"
          />
          <Property
            id="groupId"
            editable="false"
            editableOptions={{}}
            format="string"
            formatOptions={{}}
            hidden="true"
            label="Group ID"
          />
          <Event
            event="save"
            method="trigger"
            params={{ ordered: [] }}
            pluginId="saveColorEdits"
            type="datasource"
            waitMs="0"
            waitType="debounce"
          />
        </KeyValue>
      </View>
    </Container>
    <Container
      id="stack10"
      _align="center"
      _direction="vertical"
      _flexWrap={true}
      _gap="0px"
      _type="stack"
      footerPadding="4px 12px"
      headerPadding="4px 12px"
      padding="0"
      showBody={true}
      showBorder={false}
    >
      <View id="01eb7" viewKey="View 1">
        <TagsWidget2
          id="tags1"
          allowWrap={true}
          colorByIndex={
            '{{ \n  self.value[0] === "생산팀 입력 완료" ? theme.automatic[2] : theme.automatic[0] \n}}'
          }
          data={
            '[{{ \n  item.reference_info?.has_sheet_data === true ? "생산팀 입력 완료" : "생산팀 미입력" \n}}]'
          }
          hidden=""
          hiddenByIndex=""
          labels=""
          style={{ ordered: [] }}
          value=""
          values=""
        />
        <Image
          id="image3"
          horizontalAlign="center"
          src="{{ 
 `https://agabang-image.s3.ap-northeast-2.amazonaws.com/item_final/${item.reference_info.sty_cd}${item.reference_info.col_cd}.jpg`
}}"
          style={{ ordered: [{ borderColor: "rgba(237, 237, 237, 1)" }] }}
        />
      </View>
    </Container>
  </View>
</Container>
