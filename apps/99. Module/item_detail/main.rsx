<App>
  <Include src="./functions.rsx" />
  <GlobalWidgetProp
    id="sel_sty"
    description="선택된 상품 정보 받아오기  "
    value={
      '{\n  "sty_cd": "79S427501",\n  "sty_nm": "푸우베이지점프수트",\n  "col_cd": "21",\n  "col_nm": "BEIGE",\n  "fabric": "우븐",\n  "item_md_category_id": 57,\n  "tot_sale_qty": 452,\n  "tot_in_qty": 1018,\n  "sale_per": 0.44,\n  "sale_amt_per": 0.44,\n  "year_sesn_nm_eng": "25SM"\n}'
    }
  />
  <GlobalWidgetProp id="brand_code" value={'"79"'} />
  <Include src="./src/modalFrame1.rsx" />
  <Include src="./src/shop_sales.rsx" />
  <Frame
    id="$main"
    enableFullBleed={false}
    isHiddenOnDesktop={false}
    isHiddenOnMobile={false}
    padding="8px 12px"
    sticky={null}
    type="main"
  >
    <ModuleContainerWidget
      id="moduleContainer"
      backgroundColor="white"
      br_cd="01"
      brand_code={'"79"'}
      isGlobalWidgetContainer={true}
      margin="0"
      sel_sty={
        '{\n  "sty_cd": "79S427501",\n  "sty_nm": "푸우베이지점프수트",\n  "col_cd": "21",\n  "col_nm": "BEIGE",\n  "fabric": "우븐",\n  "item_md_category_id": 57,\n  "tot_sale_qty": 452,\n  "tot_in_qty": 1018,\n  "sale_per": 0.44,\n  "sale_amt_per": 0.44,\n  "year_sesn_nm_eng": "25SM"\n}'
      }
    >
      <Include src="./src/container4.rsx" />
    </ModuleContainerWidget>
  </Frame>
</App>
