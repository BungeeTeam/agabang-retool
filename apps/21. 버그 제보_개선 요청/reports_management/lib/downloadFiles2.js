const files = formatFiles2.data.files

for (let i = 0; i < files.length; i++) {
  console.log(`${i + 1}번째 파일: ${files[i].name}`);
  utils.downloadFile({data: files[i].base64Data,
    fileName: files[i].name,
    type: files[i].type})
}