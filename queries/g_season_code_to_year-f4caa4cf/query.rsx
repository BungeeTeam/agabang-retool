<PlaygroundQuery
  id="g_season_code_to_year"
  adhocResourceType={null}
  data={null}
  resourceType="jdbc"
>
  <SqlQuery
    _additionalScope={[]}
    allowedGroupIds={[]}
    allowedGroups={[]}
    dataArray={[]}
    events={[]}
    importedQueryDefaults={{ p_code: "S" }}
    importedQueryInputs={{ p_code: "S" }}
    privateParams={[]}
    query={include("./lib/g_season_code_to_year.sql", "string")}
    queryTimeout="100000"
    retoolVersion="3.114.3"
    warningCodes={[]}
    watchedParams={[]}
  />
</PlaygroundQuery>
