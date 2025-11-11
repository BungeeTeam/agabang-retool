async function go() {
  for (let i = 0; i < upload_file_dropzone.value.length; i++) {
    await s3_upload.trigger({
      additionalScope: {
        i: i,
      },
    });
    // 0.5초 대기
    await new Promise(resolve => setTimeout(resolve, 500));
  }
  await trigger_airflow_manual_dag.trigger()
}

return go();