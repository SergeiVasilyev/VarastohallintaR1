$(document).ready(function() {
    // RENTAL EVENTS PAGE
    // Show / hide accordion list
    $('.list__collapse button').click(function(){
        var userid = $(this).attr('userid')
        // alert($(`.sublist_warp[userid='${userid}']`).attr('class'))
        $(`.sublist_warp[userid='${userid}']`).slideToggle('fast')
        $(this).find('.bi').toggleClass('bi-caret-down bi-caret-left', 5000);
    })

    $('#chk-05').click(function(){
        $(`.sublist_warp`).slideToggle('fast')
        $('.list__collapse').find('.bi').toggleClass('bi-caret-down bi-caret-left', 5000);
    })


    // NUMBER SPINNER
    // https://shaack.com/projekte/bootstrap-input-spinner/
    $("input[type='number']").inputSpinner()

    // NEW ITEM PAGE
    // Alerts
    $('#id_cat_name').change(function(){
        $('.alert').show('fast')
    })
    

    
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

    
    

    console.log(window.location.pathname)
    var location = window.location.search.replace('?','')
    console.log(location)
    if (window.location.pathname=='/new_event/') {
        let textUserQuestion = document.getElementById('barcode')
        textUserQuestion.focus()
        // $("#barcode").val('saasa')
        // проверить если ни один инпут не выделен, 

        // if ($("#add_user").is(":focus")) {
        //     alert('123')
        // }
        $('input').on("focus", function(){
            // console.log($('input').value())
        });
        
        $("#barcode").focus(function() {
            console.log($("#barcode").val())
        })

        var params = window
        .location
        .search
        .replace('?','')
        .split('&')
        .reduce(
            function(p,e){
                var a = e.split('=');
                p[ decodeURIComponent(a[0])] = decodeURIComponent(a[1]);
                return p;
            },
            {}
        );
        console.log(params['add_user']);

    }











    // data {csrfmiddlewaretoken: csrf}....

    // $('#take_picture').click(function(){
    //     alert('1111')
    //     $.ajax({
    //         type: 'POST',
    //         url: "take_pacture",
    //         mimeType:"multipart/form-data",
    //         success: (data) => {
    //             console.log(data);
    //         },
    //     })
    // })





    // $('#add_product').click(function(){
    //     $.ajax({
    //         type: 'GET',
    //         url: "/new_event_goods",
    //         dataType: "json",
    //         success: (data) => {
    //             console.log(data);
    //         },
    //     })
    // })


    // SCROLLBAR
    // (function($) {
    //     $.fn.hasScrollBar = function() {
    //         console.log(this.get(0).scrollHeight-16)
    //         console.log(this.height())
    //         return this.get(0).scrollHeight-16 > this.height();
    //     }
    // })(jQuery);
    

    // $('.list__collapse button').click(function(){
        
    //     if ($('#wb').hasScrollBar()) {
    //         console.log('content 1: ' + $('#wb').hasScrollBar());
    //         $('#wb').attr('margin-left', '50px')
    //     }
    // })

    // $.fn.hasScrollBar = function() {
    //     console.log(this.get(0).scrollHeight)
    //     console.log(this.height())
    //     return this.get(0).scrollHeight > this.height();
    // }

    // console.log($('main .white_background').hasScrollBar())
    // if ($('main .white_background').hasScrollBar()) {
    //     alert($('main .white_background').hasScrollBar())
    // }

    //MODAL
    // $("#b1").click(function () {
    //     $('#d3').modal('toggle');
    //     // var text = $("#textarea").val();
    //     // $("#modal_body").html(text);
    // });
    // $("#b2").click(function () {
    //     $('#d4').modal('toggle');
    //     // var text = $("#textarea").val();
    //     // $("#modal_body").html(text);
    // });
})