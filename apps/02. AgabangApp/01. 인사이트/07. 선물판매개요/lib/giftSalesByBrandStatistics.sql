select
    br_cd, 
    br_nm, 
    gift_yn, 
    sum(sales_rev) as sales_rev
from (
    select
        A.comp_cd,
        A.shop_cd,
        date_format(DATE(A.sale_dt), '%Y-%m') as sale_dt,
        A.pos_no,
        A.recp_no,
        A.seq_no,
        A.sty_cd,
        A.sales_rev,
        B.br_cd,
        B.br_nm,
        coalesce(gift_yn, 'n/a') as gift_yn,
        case
            when A.sty_cd in (select sty_cd from agabang_dw.retooldb_disney_style)
            then '79'
            else B.br_cd
        end as br_cd,
        case
            when A.sty_cd in (select sty_cd from agabang_dw.retooldb_disney_style)
            then '디즈니베이비'
            else B.br_nm
        end as br_nm
    from (
        select
            comp_cd, shop_cd, sale_dt, pos_no, recp_no, seq_no, sty_cd, sale_qty * sale_prce as sales_rev
        from agabang.slpd as A
        where sale_dt >= '20240901'
    ) as A
    left join (
        select distinct sty_cd, br_cd, br_nm
        from agabang_dw.dim_style
    ) as B
    on A.sty_cd = B.sty_cd
    left join (
        select comp_cd, shop_cd, sale_dt, pos_no, recp_no, gift_yn from agabang.slph
    ) as C
    on A.comp_cd = C.comp_cd and A.shop_cd = C.shop_cd and A.sale_dt = C.sale_dt and A.pos_no = C.pos_no and A.recp_no = C.recp_no
)
group by br_cd, br_nm, gift_yn
order by br_cd