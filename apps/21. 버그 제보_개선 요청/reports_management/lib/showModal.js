const _id = Number(url.hashParams?.id);
console.log(`id: ${_id}`)

const data = getReportsQuery.data.find(i => i.id === _id);

console.log(`data: ${data}`)

if (_id > 0){
varSelectedRow.setValue(data);
modalFrameReportsDetailUser.show();
getReplies.trigger();
} else {
  console.log('id없음')
}