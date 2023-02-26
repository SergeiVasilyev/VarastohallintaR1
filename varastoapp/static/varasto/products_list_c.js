function list_el_f(item, static_url, CATEGORY_CONSUMABLES_ID){
    const d = new Date(item.is_possible_to_rent_field)
    let date = d.getDate()
    let month = d.getMonth()
    let fullYear = d.getFullYear()
    if (d.getDate() < 10) date = '0' + d.getDate()
    if (d.getMonth() < 10) month = '0' + d.getMonth()

const list_el = `
<div class="new_event_wrap">
    <div class="list__item_photo">
        <div><a href="/product/${item.id}" class="nodecor"><img src="${static_url}${item.picture}" alt="${static_url}${item.picture}"></a></div>
    </div>
    <div class="row02">
        <div class="item_name">
            <a href="/product/${item.id}" class="nodecor">
                <span class="header" for="chekbox${item.id}">${item.item_name} ${item.brand ? item.brand : ''}</span>
                <span class="paragraph" for="chekbox{{item.id}}">${item.model ? item.model : ''} ${item.item_type ? item.item_type : ''} ${item.parameters ? item.parameters : ''} ${item.size ? item.size : ''}</span>
            </a>
        </div>
    </div>
    <div class="row01">
        <div class="">
            <a href="/product/${item.id}" class="nodecor"><span class="code_number">${item.id}</span></a>
        </div>
    </div>
    <div class="row01">
        <div class="d-flex flex-column">
            <a href="/product/${item.id}" class="nodecor"><span class="code_number">${item.storage__name ? item.storage__name : ''}</span></a>
            <a href="/product/${item.id}" class="nodecor"><span class="code_number">${item.storage_place ? item.storage_place : ''}</span></a>
        </div>
    </div>
    <div class="row01">
        <div class="">
            <a href="/product/${item.id}" class="nodecor"><span class="EAN_number">${item.ean ? item.ean : ''}</span></a>
        </div>
    </div>
    <div class="row01">
        <div class="item_status">

            ${item.is_possible_to_rent_field ? '<span class="status_red">Ei saatavilla</span>' : item.cat_name==CATEGORY_CONSUMABLES_ID ? '<span class="status_orange">Saatavilla</span>' : '<span class="status_green">Saatavilla</span>'}

        </div>
    </div>
    <div class="row01">
        <div class="">

            ${item.cat_name==CATEGORY_CONSUMABLES_ID ? 
                '<span class="est_date">'+(item.amount ? item.amount : 0)+' pakkausta,</span>'+
                '<span class="est_date">'+(item.amount_x_contents ? item.amount : 0) + (item.unit__unit_name ? item.unit__unit_name : '')+' yhteensä</span>' : 
                '<span class="est_date">'+(item.is_possible_to_rent_field ? (date+'.'+month+'.'+fullYear) : '')+'</span>'}
            
        </div>
    </div>
    <div class="row01">
    </div>
</div>
`
return list_el
}