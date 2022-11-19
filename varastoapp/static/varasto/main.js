$(document).ready(function() {
    // RENTAL EVENTS PAGE
    // Show / hide accordion list
    $('.list__collapse button').click(function(){
        var userid = $(this).attr('userid')
        // alert($(`.sublist_warp[userid='${userid}']`).attr('class'))
        $(`.sublist_warp[userid='${userid}']`).slideToggle('fast')
        $(this).find('.bi').toggleClass('bi-caret-down bi-caret-left', 5000);
    })

    // RENTAL EVENTS PAGE
    // Expand/collapse the entire list of goods
    $('#chk-05').click(function(){
        if ($("#chk-05").is(':checked')) {
            $(".sublist_warp").slideDown('fast')  // checked
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
        var $id_units = $("#id_units")

        if ($id_units.val()) {
            $id_pack.prop("disabled", false)
        } else {
            $id_pack.prop("disabled", true)
        }
        //let accessAllowed = (age > 18) ? true : false;
        if ($id_units.val() == 'unit') {
            unit_around = Math.round($id_pack.val())
            $id_pack.val(unit_around)
            $id_pack.attr('data-decimals', 0)
            $id_pack.attr('step', 1)           
        } else {
            let val = ($id_units.val()) ? null_is_empty($id_pack.val()) : ''
            $id_pack.val(val)

            $id_pack.attr('data-decimals', 4)
            $id_pack.attr('step', 0.001)
        }
        
    }
    function check_cat_name(){
        var $id_pack = $("#id_pack")
        var $id_units = $("#id_units")
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
    $('#id_units').change(function(){
        check_units()
    })

    // Disable MÄÄRÄ LAATIKOSSA kenttä (id_pack) when not selected kulutusmateriaalit in id_cat_name
    $('#id_cat_name').change(function(){       
        check_cat_name()
    })

    // Log
    // $('button').click(function(){
    //     console.log($('#id_pack').val())
    // })

    //----

    // ---NEW ITEM PAGE

    
    // NEW ITEM PAGE
    // After the picture is taken, the stream stops !!!!!!!!!!!!!!!!!
    // $('#take_picture').click(function(){
    //     var origin = window.location.origin
    //     var myModalEl = document.getElementById('cam')
    //     var modal = bootstrap.Modal.getInstance(myModalEl)
    //     // modal.hide()
    //     $.get('take_pacture', function (data, status) {
    //         console.log(origin)
    //         console.log(data)

    //         var preview = document.getElementById("preview_pic")
    //         preview.style.opacity = "1";
    //         preview.style.maxWidth = "250px";
    //         preview.style.height = "250px";
    //         preview.src = origin + data
    //         // $('#preview_pic').attr('src', origin + data)
    //         })
    // })

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

})