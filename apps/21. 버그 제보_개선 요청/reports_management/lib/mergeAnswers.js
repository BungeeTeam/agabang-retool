const q_1 = {{ questions.value[select4.value].q_1.question }}
const answer_1 = {{ richTextEditor11.value  }}

const q_2 = {{ questions.value[select4.value].q_2.question }}
const answer_2 = {{ richTextEditor12.value  }}

const q_3 = {{ questions.value[select4.value].q_3.question }}
const answer_3 = {{ richTextEditor13.value  }}

const q_4 = {{ questions.value[select4.value].q_4.question }}
const answer_4 = {{ richTextEditor14.value  }}

const combinedAnswer = [
  q_1,
  answer_1,
  q_2,
  answer_2,
  q_3,
  answer_3,
  q_4,
  answer_4,
].join('');

return combinedAnswer