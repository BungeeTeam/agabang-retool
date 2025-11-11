function joinArrays(arrayA, arrayB) {
    // 1. arrayB를 Map 형태로 변환하여 빠른 조회를 가능하게 합니다.
    // 키는 biz_cd, biz_nm, tp_cd를 조합한 문자열로 만듭니다.
    const bMap = new Map();
    arrayB.forEach(itemB => {
        const key = `${itemB.biz_cd}-${itemB.biz_nm}-${itemB.tp_cd}`;
        // 같은 키를 가진 항목이 여러 개 있을 경우를 대비하여 배열로 저장합니다.
        if (!bMap.has(key)) {
            bMap.set(key, []);
        }
        bMap.get(key).push(itemB);
    });

    const joinedResult = [];
    const matchedBKeys = new Set(); // A와 매칭된 B의 키를 추적합니다.

    // 2. arrayA를 순회하며 arrayB와 조인합니다 (LEFT JOIN 개념).
    arrayA.forEach(itemA => {
        const key = `${itemA.biz_cd}-${itemA.biz_nm}-${itemA.tp_cd}`;

        if (bMap.has(key)) {
            // 매칭되는 B 항목이 있는 경우
            bMap.get(key).forEach(itemB => {
                joinedResult.push({
                    id: itemA.id,
                    biz_cd: itemA.biz_cd,
                    biz_nm: itemA.biz_nm,
                    tp_cd: itemA.tp_cd, // A의 tp_cd 유지
                    tp_nm: itemA.tp_nm, // A의 tp_nm 유지
                    tp_group_nm: itemA.tp_group_nm,
                });
                matchedBKeys.add(key); // 이 키에 해당하는 B 항목이 매칭되었음을 기록
            });
        } else {
            // arrayA에만 있는 경우
            joinedResult.push({
                ...itemA // A 항목 그대로 포함
            });
        }
    });

    // 3. arrayB에만 있고 arrayA와 매칭되지 않은 항목들을 추가합니다.
    arrayB.forEach(itemB => {
        const key = `${itemB.biz_cd}-${itemB.biz_nm}-${itemB.tp_cd}`;
        if (!matchedBKeys.has(key)) {
            // A와 매칭되지 않은 B 항목
            joinedResult.push({
                id: null,             // A에 없으므로 null
                biz_cd: itemB.biz_cd,
                biz_nm: itemB.biz_nm,
                tp_cd: itemB.tp_cd,
                tp_nm: itemB.tp_nm,
                tp_group_nm: null       // A에 없으므로 null
            });
        }
    });

    return joinedResult;
}

const arrayA = {{ getChannelMappingList.data }}

const arrayB = {{ channelListQuery.data.filter(i=>i.biz_cd === bizSelect.value) }}


const result = joinArrays(arrayA, arrayB);

return result