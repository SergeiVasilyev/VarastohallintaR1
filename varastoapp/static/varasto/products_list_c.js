function list_el_f(item, static_url, CATEGORY_CONSUMABLES_ID){
    const d = new Date(item.is_possible_to_rent_field)
    let date = d.getDate()
    let month = d.getMonth()
    let fullYear = d.getFullYear()
    if (d.getDate() < 10) date = '0' + d.getDate()
    if (d.getMonth() < 10) month = '0' + d.getMonth()
    if (item.picture) {
        picture = `<img src="${static_url}${item.picture}" alt="${static_url}${item.picture}"></img>`
    } else {
        picture = `<div>
            <svg xmlns="http://www.w3.org/2000/svg" fill="currentColor" class="bi bi-wrench" viewBox="0 0 16 16">
                <path d="M.102 2.223A3.004 3.004 0 0 0 3.78 5.897l6.341 6.252A3.003 3.003 0 0 0 13 16a3 3 0 1 0-.851-5.878L5.897 3.781A3.004 3.004 0 0 0 2.223.1l2.141 2.142L4 4l-1.757.364L.102 2.223zm13.37 9.019.528.026.287.445.445.287.026.529L15 13l-.242.471-.026.529-.445.287-.287.445-.529.026L13 15l-.471-.242-.529-.026-.287-.445-.445-.287-.026-.529L11 13l.242-.471.026-.529.445-.287.287-.445.529-.026L13 11l.471.242z"/>
            </svg>
        </div>`
    }

const list_el = `
<div class="new_event_wrap">
    <div class="list__item_photo">
        <div>
            <a href="/product/${item.id}" class="nodecor">
                ${picture}
            </a>
        </div>
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
                '<span class="est_date">'+(item.amount_x_contents ? parseFloat(item.amount_x_contents) : 0) + ' ' + (item.unit__unit_name ? item.unit__unit_name : '')+' yhteensä</span>' : 
                '<span class="est_date">'+(item.is_possible_to_rent_field ? (date+'.'+month+'.'+fullYear) : '')+'</span>'}
            
        </div>
    </div>
    <div class="row01">
    </div>
</div>
`
return list_el
}