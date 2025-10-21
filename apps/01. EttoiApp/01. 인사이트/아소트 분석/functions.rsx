<GlobalFunctions>
  <Folder id="query">
    <SqlQuery
      id="query_get_each_item_info"
      errorTransformer="// The variable 'data' allows you to reference the request's data in the transformer. 
// example: return data.find(element => element.isError)
return data.error"
      query={include("./lib/query_get_each_item_info.sql", "string")}
      resourceDisplayName="clickhouse-dw"
      resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
      transformer="// Query results are available as the `data` variable
return data"
      warningCodes={[]}
      workflowActionType={null}
      workflowBlockUuid={null}
      workflowRunId={null}
    />
    <SqlQuery
      id="query_get_threshold"
      errorTransformer="// The variable 'data' allows you to reference the request's data in the transformer. 
// example: return data.find(element => element.isError)
return data.error"
      isMultiplayerEdited={false}
      query={include("./lib/query_get_threshold.sql", "string")}
      resourceDisplayName="clickhouse-dw"
      resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
      transformer="const _data = formatDataAsArray(data)

const _test = _data[0]

Object.keys(_test).forEach(item => {
  _test[item] = 1000
})

_data[_data.length] = _test

return _data"
      warningCodes={[]}
      workflowActionType={null}
      workflowBlockUuid={null}
      workflowRunId={null}
    />
    <SqlQuery
      id="query_get_season_code"
      enableTransformer={true}
      errorTransformer="// The variable 'data' allows you to reference the request's data in the transformer. 
// example: return data.find(element => element.isError)
return data.error"
      isMultiplayerEdited={false}
      query={include("./lib/query_get_season_code.sql", "string")}
      resourceDisplayName="clickhouse-dw"
      resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
      resourceTypeOverride=""
      transformer="return formatDataAsArray(data)"
      warningCodes={[]}
      workflowActionType={null}
      workflowBlockUuid={null}
      workflowRunId={null}
    />
    <SqlQuery
      id="query_parity_target_size_list"
      enableTransformer={true}
      errorTransformer="// The variable 'data' allows you to reference the request's data in the transformer. 
// example: return data.find(element => element.isError)
return data.error"
      isMultiplayerEdited={false}
      query={include("./lib/query_parity_target_size_list.sql", "string")}
      resourceDisplayName="clickhouse-dw"
      resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
      showFailureToaster={false}
      transformer="return formatDataAsArray(data)"
      warningCodes={[]}
      workflowActionType={null}
      workflowBlockUuid={null}
      workflowRunId={null}
    />
  </Folder>
  <Folder id="def">
    <State
      id="def_size_tp_raw"
      _persistedValueGetter={null}
      _persistedValueSetter={null}
      persistedValueKey=""
      persistValue={false}
      value={
        '{\n  "00": ["01", "02", "03", "04", "05", "06", "07"],\n  "10": ["60", "65", "70", "75", "80", "85", "90"],\n  "11": ["75", "80", "85", "90", "95", "100", "110"],\n  "13": ["9M", "12M", "18M", "24M", "2T", "3T", "4T"],\n  "14": ["3M", "6M", "12M", "18M", "2Y", "3Y", "4Y"],\n  "22": ["75", "80", "85", "90", "95", "100", "105"],\n  "23": ["75", "80", "85", "90", "95", "100", "105"],\n  "25": ["FREE", "XS", "S", "M", "L", "XL", ""],\n  "27": ["9M", "12M", "18M", "24M", "2T", "3T", "4T"],\n  "28": ["18M", "2Y", "4Y", "6Y", "8Y", "10Y", ""],\n  "29": ["3M", "6M", "12M", "18M", "2Y", "3Y", "4Y"],\n  "30": ["115", "125", "130", "140", "150", "", ""],\n  "40": ["130", "135", "140", "145", "150", "155", "160"],\n  "50": ["7-8", "9-10", "11-12", "13-14", "15-16", "17-18", "19-20"],\n  "60": ["42", "44", "46", "48", "50", "52", "54"],\n  "70": ["ES", "S", "M", "L", "XL", "XXL", ""],\n  "80": ["3M", "6M", "12M", "18M", "24M", "", ""],\n  "81": ["FREE", "90X105", "95X120", "100X130", "105X135", "108X140", "115X135"],\n  "82": ["FREE", "95X95", "95X105", "", "", "", ""],\n  "83": ["FREE", "미니처네", "7부처네", "장처네", "", "", ""],\n  "84": ["Free", "82X82", "83X83", "85X85", "", "", ""],\n  "85": ["100X120", "100X130", "", "", "", "", ""],\n  "86": ["FREE", "100X120", "100X130", "115X135", "", "", ""],\n  "88": ["일반", "신생아", "", "", "", "", ""],\n  "89": ["FREE", "90호", "95호", "100호", "110호", "", ""],\n  "90": ["일반", "망사", "", "", "", "", ""],\n  "99": ["Free", "", "", "", "", "", ""]\n}'
      }
    />
    <State
      id="def_size_tp_for_excel"
      _persistedValueGetter={null}
      _persistedValueSetter={null}
      persistedValueKey=""
      persistValue={false}
      value={
        '{\n  size_3m: ["3M", "70", "FREE", "100", "FREE"],\n  size_6m: ["6M", "75", "42", "115", "7-8"],\n  size_12m: ["12M", "80", "44", "125", "9-10"],\n  size_18m: ["18M", "90", "46", "130", "11-12"],\n  size_2y: ["2Y", "100", "48", "140", "13-14"],\n  size_3y: ["3Y", "110", "50", "150", "15-16"],\n  size_4y: ["4Y", "120", "52", "", ""]\n}'
      }
    />
    <Function
      id="var_data_excel_formatted"
      funcBody={include("./lib/var_data_excel_formatted.js", "string")}
    />
    <Function
      id="var_season_code"
      funcBody={include("./lib/var_season_code.js", "string")}
    />
    <Function
      id="var_check_parity_raw"
      funcBody={include("./lib/var_check_parity_raw.js", "string")}
    />
    <Function
      id="var_check_parity_list"
      funcBody={include("./lib/var_check_parity_list.js", "string")}
    />
    <Function
      id="var_check_parity_final"
      funcBody={include("./lib/var_check_parity_final.js", "string")}
    />
  </Folder>
  <JavascriptQuery
    id="download_excel_data"
    errorTransformer="// The variable 'data' allows you to reference the request's data in the transformer. 
// example: return data.find(element => element.isError)
return data.error"
    isMultiplayerEdited={false}
    notificationDuration={4.5}
    query={include("./lib/download_excel_data.js", "string")}
    resourceName="JavascriptQuery"
    showSuccessToaster={false}
    transformer="// Query results are available as the `data` variable
return data"
    workflowActionType={null}
    workflowBlockUuid={null}
    workflowRunId={null}
  />
</GlobalFunctions>
