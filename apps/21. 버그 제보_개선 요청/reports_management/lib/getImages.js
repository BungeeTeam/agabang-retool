console.log( varSelectedRow.value.screenshot_1)


const base64Images = varSelectedRow.value.screenshot_1

const processedFiles = base64Images.map((dataUrl, index) => {
  const [metadata, base64Data] = dataUrl.split(',');
  const mimeTypeMatch = metadata.match(/data:(image\/[a-zA-Z]+);base64/);
  const mimeType = mimeTypeMatch ? mimeTypeMatch[1] : 'image/png';

  // base64 길이 기반으로 대략적인 byte 수 계산
  const sizeBytes = Math.round((base64Data.length * 3) / 4);

  return {
    name: `image_${index + 1}.${mimeType.split('/')[1]}`,
    type: mimeType,
    sizeBytes,
    base64Data
  };
});


return processedFiles;