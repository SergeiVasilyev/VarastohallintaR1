function list_el_f(item, static_url, CATEGORY_CONSUMABLES_ID){
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
            ${item.is_possible_to_rent_field}
            ${item.is_possible_to_rent_field ? item.cat_name==CATEGORY_CONSUMABLES_ID ? '<span class="status_orange">Saatavilla</span>' : '<span class="status_green">Saatavilla</span>' : '<span class="status_red">Ei saatavilla</span>'}

        </div>
    </div>
    <div class="row01">
        <div class="">
            {% if item.cat_name_id != CATEGORY_CONSUMABLES_ID %}
                <span class="est_date">${item.rentable_at}</span>
            {% else %}
                <span class="est_date">${item.amount ? item.amount : 0} pakkausta,</span>
                <span class="est_date">${item.amount_x_contents ? item.amount : 0} ${item.unit__unit_name ? item.unit__unit_name : ''} yhteensä</span>
            {% endif %} 
        </div>
    </div>
    <div class="row01">
    </div>
</div>
`
return list_el
}