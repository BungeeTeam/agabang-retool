// transformer: processAttachments
const attachments = varSelectedRow.value.file_attachments  || [];

const processedFiles = attachments.map((file, index) => {
  const isImage = file.type?.startsWith('image/');
  
  return {
    id: index,
    name: file.name,
    type: file.type,
    sizeBytes: file.sizeBytes,
    isImage: isImage,
    // 이미지는 data URL로 변환
    displayUrl: isImage 
      ? `data:${file.type};base64,${file.base64Data}`
      : null,
    // 다운로드용 원본 데이터
    base64Data: file.base64Data,
    // 파일 크기 포맷팅
    sizeFormatted: formatFileSize(file.sizeBytes)
  };
});

function formatFileSize(bytes) {
  if (bytes < 1024) return bytes + ' B';
  if (bytes < 1024 * 1024) return (bytes / 1024).toFixed(1) + ' KB';
  return (bytes / (1024 * 1024)).toFixed(1) + ' MB';
}

return {
  all: processedFiles,
  images: processedFiles.filter(f => f.isImage),
  files: processedFiles.filter(f => !f.isImage),
  hasImages: processedFiles.some(f => f.isImage),
  hasFiles: processedFiles.some(f => !f.isImage)
};