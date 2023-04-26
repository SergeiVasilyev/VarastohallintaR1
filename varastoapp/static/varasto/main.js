$(document).ready(function() {
    // RENTAL EVENTS PAGE
    // Show / hide accordion list
    $('.list__collapse button').click(function(){
        var userid = $(this).attr('userid')
        // alert($(`.sublist_warp[userid='${userid}']`).attr('class'))
        $(`.sublist_warp[userid='${userid}']`).slideToggle('fast')
        $(this).find('.bi').toggleClass('bi-caret-down bi-caret-left', 5000);
    })

    // =========================================
    // RENTAL EVENTS PAGE
    // Expand/collapse the entire list of goods on rental_events.html
    $('#chk-05').click(function(){
        if ($("#chk-05").is(':checked')) {
            if ($('#chk-04').is(':checked')) {
                $(".sublist_warp[is_overdue='1']").slideDown('fast')
            } else {
                $(".sublist_warp").slideDown('fast')  // checked
            }
            $('.list__collapse').find('.bi').addClass('bi-caret-down')
            $('.list__collapse').find('.bi').removeClass('bi-caret-left')
        }
        else {
            $(".sublist_warp").slideUp('fast')  // unchecked
            $('.list__collapse').find('.bi').addClass('bi-caret-left')
            $('.list__collapse').find('.bi').removeClass('bi-caret-down')
        }
        // $(`.sublist_warp`).slideToggle('fast')
        // $('.list__collapse').find('.bi').toggleClass('bi-caret-down bi-caret-left', 5000);
    })

    // Erääntynyt checkbox on rental_events.html
    $('#chk-04').click(function(){
        if ($('#chk-04').is(':checked')) {
            $(".list__item[is_overdue='0']").hide()
            $(".sublist_warp[is_overdue='0']").hide()
        } else {
            $(".list__item[is_overdue='0']").show()
            if ($("#chk-05").is(':checked')) {
                $(".sublist_warp[is_overdue='0']").show()
            }
        }
    })

    // Erääntynyt checkbox on rental_events_goods.html
    $('#chk-04-1').click(function(){
        $(".list__item[is_overdue='0']").toggle()
    })

    // / RENTAL EVENTS PAGE
    // =========================================


    // NUMBER SPINNER
    // https://shaack.com/projekte/bootstrap-input-spinner/
    $("input[type='number']").inputSpinner()


    // NEW ITEM PAGE
    // Alerts
    $('#id_cat_name').change(function(){
        $('.alert').show('fast')
    })

    // Disable id_pack and id_units fields, if id_cat_name not Kulutusmateriaali
    // Disable id_pack if id_units not selected

    function null_is_empty(val){
        return val ? val : 0
    }

    function check_units(){
        var $id_pack = $("#id_contents")
        var $id_units = $("#id_unit")

        if ($id_units.val()) {
            $id_pack.prop("disabled", false)
        } else {
            $id_pack.prop("disabled", true)
        }

        if ($id_units.val() == '1') { // need to assign a variable for '1' as kpl
            unit_around = Math.round($id_pack.val())
            //unit_around = !unit_around ? 1 : unit_around
            $id_pack.val(unit_around)
            $id_pack.attr('data-decimals', 0)
            $id_pack.attr('step', 1)           
        } else {
            let val = ($id_units.val()) ? null_is_empty($id_pack.val()) : ''
            //val = !val ? 0.0001 : val
            $id_pack.val(val)
            $id_pack.attr('data-decimals', 4)
            $id_pack.attr('step', 0.001)
        }
        
    }
    function check_cat_name(){
        var $id_pack = $("#id_pack")
        var $id_units = $("#id_unit")
        if ($('#id_cat_name').val() != '1'){
            $id_pack.val('')
            $id_pack.attr('placeholder', '')
            $id_pack.prop("disabled", true)
            $id_units.val('')
            $id_units.prop("disabled", true)
        } else {
            check_units()
            $id_units.prop("disabled", false)
        }
    }

    check_cat_name()
    check_units()
    
    // Change data-decimals and step in "MÄÄRÄ LAATIKOSSA" and round input value when YKSIKKÖ is kpl
    $('#id_unit').change(function(){
        check_units()
    })

    // Disable MÄÄRÄ LAATIKOSSA kenttä (id_pack) when not selected kulutusmateriaalit in id_cat_name
    $('#id_cat_name').change(function(){       
        check_cat_name()
    })

    // / NEW ITEM PAGE


    // NEW EVENT PAGE
    // Click button when Date is changed
    $('#estimated_date').change(function(){
        document.querySelector("button[name=_add_user]").click()
    })

    $('#rental_start').change(function(){
        document.querySelector("#date_submit").click()
    })

    $('#rental_end').change(function(){
        document.querySelector("#date_submit").click()
    })
    // / NEW EVENT PAGE


})