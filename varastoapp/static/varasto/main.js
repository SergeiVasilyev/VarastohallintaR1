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
    
    // NEW ITEM PAGE
    // After the picture is taken, the stream stops !!!!!!!!!!!!!!!!!
    $('#take_picture').click(function(){
        var origin = window.location.origin
        var myModalEl = document.getElementById('cam')
        var modal = bootstrap.Modal.getInstance(myModalEl)
        // modal.hide()
        $.get('take_pacture', function (data, status) {
            console.log(origin)
            console.log(data)

            var preview = document.getElementById("preview_pic")
            preview.style.opacity = "1";
            preview.style.maxWidth = "250px";
            preview.style.height = "250px";
            preview.src = origin + data
            // $('#preview_pic').attr('src', origin + data)
            })
    })

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