select pr.name as PRODUCT, cat.name as CATEGORY
  from PRODUCTS pr
  left join PRODS_AND_CATS pac
		 on pac.product = pr.id
  left join CATEGORIES cat
		 on pac.category = cat.id