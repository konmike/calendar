$(function() {
    $("form[name='registration']").validate({
        rules: {
            username: {
                required: true,
                minlength: 6
            },
            email: {
                required: true,
                // Specify that email should be validated
                // by the built-in "email" rule
                email: true
            },
            password: {
                required: true,
                minlength: 8,
                pwcheck: true,
            },
            passwordConfirm: {
                required: true,
                equalTo: "#password",
            }
        },
        messages: {
            username: {
                required: "Vyplňte uživatelské jméno",
                minlength: "Minimální délka uživatelského jména je 6 znaků"
            },
            password: {
                required: "Vyplňte heslo",
                minlength: "Minimální délka hesla je 8 znaků",
                pwcheck: "Heslo musí obsahovat minimálně jednu číslici a jedno velké písmeno."
            },
            passwordConfirm: {
                required: "Vyplňte heslo",
                equalTo: "Hesla se neshodují"
            },
            email: "Vaše e-mailová adresa je neplatná"
        },

        errorPlacement: function(error, element) {
            error.insertAfter( $("form[name='registration'] .input--submit") );
        },

        submitHandler: function(form) {
            form.submit();
        }
    });

    $("form[name='updateUser']").validate({
        rules: {
            newPassword: {
                required: true,
                minlength: 8,
                pwcheck: true,
            },
            passwordConfirm: {
                required: true,
                equalTo: "#newPassword",
            }
        },
        messages: {
            newPassword: {
                required: "Vyplňte heslo",
                minlength: "Minimální délka hesla je 8 znaků",
                pwcheck: "Heslo musí obsahovat minimálně jednu číslici a jedno velké písmeno."
            },
            passwordConfirm: {
                required: "Vyplňte heslo",
                equalTo: "Hesla se neshodují"
            },
        },

        errorPlacement: function(error, element) {
            error.insertAfter( $("form[name='updateUser'] .input--submit") );
        },

        submitHandler: function(form) {
            form.submit();
        }
    });

    $("form[name='createCalendar']").validate({
        rules: {
            name: {
                required: true,
                minlength: 6,
            },
            year: {
                required: true,
            }
        },
        messages: {
            name: {
                required: "Vyplňte název kalendáře",
                minlength: "Minimální délka názvu je 6 znaků",
            },
            year: {
                required: "Vyplňte rok kalendáře",
            },
        },

        errorPlacement: function(error, element) {
            error.insertAfter( $("form[name='createCalendar'] .input--submit") );
        },

        submitHandler: function(form) {
            form.submit();
        }
    });

    $.validator.addMethod("pwcheck", function(value) {
        return  /[A-Z]/.test(value) // has a lowercase letter
            && /\d/.test(value) // has a digit
    });
});