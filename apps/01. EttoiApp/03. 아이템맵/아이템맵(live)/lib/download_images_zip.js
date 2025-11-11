const imageUrls = formatDataAsObject(get_image_list.data).url
const imageTitles = formatDataAsObject(get_image_list.data).title
const sty_cd = var_sel_sty_info.value.sty_cd

const zip = new JSZip()

for(let i=0; i<imageUrls.length; i++) {
  const url = imageUrls[i]
  const title = imageTitles[i]
  const result = await get_image.trigger({
    additionalScope: {url: url}
  })

  const fileName = result.name
  const fileType = result.type.split('/')[1]
  const fileFullName = `${title}_${fileName}.${fileType}`

  zip.folder(sty_cd).file(fileFullName, result.base64Data, { base64: true })
}

zip.generateAsync({ type: "base64" }).then(function (base64) {
  utils.downloadFile({
    base64Binary: base64,
    fileName: sty_cd,
    fileType: "zip",
  })
})