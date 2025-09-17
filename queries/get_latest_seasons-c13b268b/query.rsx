<PlaygroundQuery
  id="get_latest_seasons"
  adhocResourceType={null}
  data={null}
  resourceType="jdbc"
>
  <SqlQuery
    _additionalScope={[]}
    allowedGroupIds={[]}
    allowedGroups={[]}
    dataArray={[]}
    enableTransformer={true}
    events={[]}
    importedQueryDefaults={{ variable1: "" }}
    importedQueryInputs={{ variable0: "", variable1: "" }}
    notificationDuration={4.5}
    privateParams={[]}
    query={include("./lib/get_latest_seasons.sql", "string")}
    retoolVersion="3.148.10"
    showSuccessToaster={false}
    transformer="const Data = formatDataAsArray(data)

const seasonArr = Data.map(item => item.year_season_cd);

return seasonArr"
    warningCodes={[]}
    watchedParams={[]}
  />
</PlaygroundQuery>
