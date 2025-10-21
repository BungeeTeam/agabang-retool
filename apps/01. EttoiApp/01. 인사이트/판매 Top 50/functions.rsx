<GlobalFunctions>
  <Function
    id="var_best_50_query"
    funcBody={include("./lib/var_best_50_query.js", "string")}
  />
  <Function
    id="var_best_50_result"
    funcBody={include("./lib/var_best_50_result.js", "string")}
  />
  <State
    id="def_year_code"
    _persistedValueGetter={null}
    _persistedValueSetter={null}
    persistedValueKey=""
    persistValue={false}
    value="{{get_season_code_list.data.filter(item => item.sesn_cd == '1').reduce((acc, cur) => 
  {acc.push({year: cur.year_nm, code: cur.year_cd}); return acc}, [])}}"
  />
  <State
    id="def_maternity_code_list"
    _persistedValueGetter={null}
    _persistedValueSetter={null}
    persistedValueKey=""
    persistValue={false}
    value="['출산용품', '방수류', '침구류', '완구류', '목욕위생류', '발육류']"
  />
  <SqlQuery
    id="get_best_50"
    enableTransformer={true}
    errorTransformer="// The variable 'data' allows you to reference the request's data in the transformer. 
// example: return data.find(element => element.isError)
return data.error"
    isMultiplayerEdited={false}
    query={include("./lib/get_best_50.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    resourceTypeOverride=""
    transformer={
      '// Query results are available as the `data` variable\nfunction transform(data) {\n  const _year_code = {{def_year_code.value}};\n  \n  let _base_link = "https://agabang-image.s3.ap-northeast-2.amazonaws.com/item_final";\n  \n  let _ret_val = data.map(item => {\n    let new_item = item\n    \n    // year_num 계산\n    const yearMatch = _year_code.find(i => i.code == item.year_cd);\n    new_item.year_num = yearMatch ? yearMatch.year : "2024";\n  \n    //  // col_list 처리\n    //  new_item.col_list = item.col_list ? item.col_list.split(\',\') : [];\n  \n    // image_link 생성\n    new_item.image_link = `${_base_link}/${item.sty_cd}.jpg`;\n  \n    // 판매율 계산\n    const salesTotal = Number(item.sales_total) || 0;\n    const inTotal = Number(item.in_total) || 1;  // 0으로 나누는 것을 방지하기 위해 기본값 1 사용\n    new_item.sales_rate_total = salesTotal / inTotal;\n  \n    const sales = Number(item.sales) || 0;\n    new_item.sales_rate = sales / inTotal;\n  \n    // 판매 차이 계산\n    const previousSales = Number(item.previous_sales) || 0;\n    new_item.sales_diff = sales - previousSales;\n  \n    // 판매 성장률 계산\n    if (previousSales > 0) {\n      new_item.sales_growth_rate = item.sales_diff / previousSales;\n    } else {\n      new_item.sales_growth_rate = "";\n    }\n    \n    // 순위 차이 계산\n    if (item.previous_rank !== undefined && item.current_rank !== undefined) {\n      new_item.rank_diff = item.previous_rank - item.current_rank;\n    } else {\n      new_item.rank_diff = null;\n    }\n\n    return new_item\n    \n  });\n\n  return _ret_val;\n}\n\nreturn transform(formatDataAsArray(data));'
    }
    warningCodes={[]}
    workflowActionType={null}
    workflowBlockUuid={null}
    workflowRunId={null}
  >
    <Event
      event="success"
      method="showNotification"
      params={{
        ordered: [
          {
            options: {
              ordered: [
                { notificationType: "success" },
                { title: "Best 20" },
                { description: "조회가 완료되었습니다." },
                { duration: "0.5" },
              ],
            },
          },
        ],
      }}
      pluginId=""
      type="util"
      waitMs="0"
      waitType="debounce"
    />
  </SqlQuery>
  <SqlQuery
    id="get_season_code_list"
    enableTransformer={true}
    errorTransformer="// The variable 'data' allows you to reference the request's data in the transformer. 
// example: return data.find(element => element.isError)
return data.error"
    query={include("./lib/get_season_code_list.sql", "string")}
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
    id="get_category_list"
    enableTransformer={true}
    errorTransformer="// The variable 'data' allows you to reference the request's data in the transformer. 
// example: return data.find(element => element.isError)
return data.error"
    query={include("./lib/get_category_list.sql", "string")}
    resourceDisplayName="clickhouse-dw"
    resourceName="46922e5d-5645-4057-8fc8-3cc8cb9fbfe4"
    resourceTypeOverride=""
    transformer="const _list = ['전체']
data.cat_nm.forEach(item => _list.push(item))
return _list"
    warningCodes={[]}
    workflowActionType={null}
    workflowBlockUuid={null}
    workflowRunId={null}
  />
  <SqlQueryUnified
    id="get_color_hex_list"
    enableTransformer={true}
    errorTransformer="// The variable 'data' allows you to reference the request's data in the transformer. 
// example: return data.find(element => element.isError)
return data.error"
    query={include("./lib/get_color_hex_list.sql", "string")}
    resourceDisplayName="retool_db"
    resourceName="33c51bac-e1f2-4560-8260-3be760a1fd8f"
    transformer="return formatDataAsArray(data)"
    warningCodes={[]}
    workflowActionType={null}
    workflowBlockUuid={null}
    workflowRunId={null}
  />
  <State id="var_sty_data" />
  <State id="var_brand_code" value="07" />
</GlobalFunctions>
