<#import "nav-bar.ftl" as nav_bar>

<#macro page>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="icon" href="../../static/img/logo.png">

    <title>CarFY</title>

    <link href="/static/css/bootstrap.css" rel="stylesheet"/>
    <link href="/static/css/Site.css" rel="stylesheet"/>
    <link href="/static/css/Foother.css" rel="stylesheet" />
    <link href="/static/css/Button.css" rel="stylesheet" />
</head>
<body style="padding-bottom: 0px">
<@nav_bar.nav_bar></@nav_bar.nav_bar>
    <#nested>

<a href="#" class="back-to-top">
    <img src="/image/car.png" width="50px" height="50px" alt="carUp">
</a>
</body>
</html>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function(){
            $(window).scroll(function(){
                if ($(this).scrollTop() > 100) {
                    $('.back-to-top').fadeIn();
                } else {
                    $('.back-to-top').fadeOut();
                }
            });
            $('.back-to-top').click(function(){
                $("html, body").animate({ scrollTop: 0 }, 600);
                return false;
            });
        });
    </script>
    <script>
        // function NoneRental() {
        //   var p = document.getElementById('notFinish');
        //   p.innerHTML = 'Вы не можете арендовать новоем авто т.к. у вас уже есть активная аренда.';
        // };

        function getDateStart() {

            var returned = "";
            returned = returned + $('#dateStart').val();

            console.log(returned);

            return { returned };
        }

        function getDateEnd() {

            var returned = "";
            returned = returned +  $('#dateEnd').val();

            console.log(returned);

            return { returned };
        }

        function FalidDate() {
            var dateStart = $('#dateStart').val();
            var dateEnd = $('#dateEnd').val();

            var Start = Date.parse(dateStart);
            var End = Date.parse(dateEnd);

            var timeRental = (End - Start) / (1000 * 60 * 60 * 24);
            var price = $('#PricePerDay').val();

            document.getElementById("Price").setAttribute('value', roundNumber(timeRental * price, 2));

            document.getElementById("rentalTime").value = roundNumber(timeRental, 1) + '.суток';

            document.getElementById('Registrator').checked = false;
            document.getElementById('AutoBox').checked = false;
            document.getElementById('child').checked = false;
            /*        $('#Registrator').on('change', PlusPriceFORCheckBox);*/
            /*$('#Price').val = timeRental;*/
        }
        //
        //   ($('#RentalCar')).on("click", function () {
        //   var dateStart = "";
        //   var dateEnd = "";
        //   dateStart = dateStart + getDateStart().returned;
        //   dateEnd = dateEnd + getDateEnd().returned;
        //   console.log(dateStart);
        //   console.log(dateEnd);
        //   var url = "https://localhost:44347/Contracts/Create/" + "67001" + "?dateStart=" + dateStart + "&dateEnd=" + dateEnd;
        //   console.log(url)
        //   window.location = url;
        // })

        ($('#Date_End')).on("change keyup paste", function () {
            var dateStart = $('#Date_Start').val();
            var dateEnd = $('#Date_End').val();

            var Start = Date.parse(dateStart);
            var End = Date.parse(dateEnd);

            var timeRental = (End - Start) / (1000 * 60 * 60 * 24);
            var price = $('#PricePerDay').val();

            document.getElementById("Price").setAttribute('value', roundNumber(timeRental * price, 0));

            document.getElementById("rentalTime").value = roundNumber(timeRental, 1) + '.суток';

            document.getElementById('Registrator').checked = false;
            document.getElementById('AutoBox').checked = false;
            document.getElementById('child').value = 0;
            /*        $('#Registrator').on('change', PlusPriceFORCheckBox);*/
            /*$('#Price').val = timeRental;*/
        });

        ($('#Date_Start')).on("change keyup paste", function () {
            var dateStart = $('#Date_Start').val();
            var dateEnd = $('#Date_End').val();

            var Start = Date.parse(dateStart);
            var End = Date.parse(dateEnd);

            var timeRental = (End - Start) / (1000 * 60 * 60 * 24);
            var price = $('#PricePerDay').val();

            document.getElementById("Price").setAttribute('value', roundNumber(timeRental * price, 0));

            document.getElementById("rentalTime").value = roundNumber(timeRental, 1) + '.суток';

            document.getElementById('Registrator').checked = false;
            document.getElementById('AutoBox').checked = false;
            document.getElementById('child').value = 0;
        })

        function codeAddress() {
            var dateStart = $('#Date_Start').val();
            var dateEnd = $('#Date_End').val();

            var Start = Date.parse(dateStart);
            var End = Date.parse(dateEnd);

            var timeRental = (End - Start) / (1000 * 60 * 60 * 24);
            var price = $('#PricePerDay').val();

            document.getElementById("Price").setAttribute('value', roundNumber(timeRental * price, 0));
            document.getElementById("rentalTime").value = roundNumber(timeRental, 1) + '.суток';

            document.getElementById('Registrator').checked = false;
            document.getElementById('AutoBox').checked = false;
            document.getElementById('child').value = 0;
        }
        window.onload = codeAddress;

        function roundNumber(number, digits) {
            var multiple = Math.pow(10, digits);
            var rndedNum = Math.round(number * multiple) / multiple;
            return parseFloat(rndedNum);
        }

        function ValidDate() {

            var dateStart = $('#Date_Start').val();
            var dateEnd = $('#Date_End').val();
            var Notes = $('#Notes').val();

            var Start = Date.parse(dateStart);
            var End = Date.parse(dateEnd);

            var timeRental = (End - Start) / (1000 * 60 * 60 * 24);

            /*        var submit = document.getElementById('submit');*/
            //console.log("Notes: " + Notes);

            if (Start >= End || (timeRental < 1) || (timeRental >= 100) || dateEnd == "") {
                //console.log(Start >= End);
                //console.log("dateEnd " + dateEnd);
                document.getElementById('message').innerHTML = "Выберите корректную дату аренды (от 1 дня до 3-х месяцев) и остальные данные";
            } else {
                AddAdditionsOptions();
                document.getElementById('message').innerHTML = "";
                $('#submit').attr('type', 'submit');
            }
        }


        function PlusPriceFORCheckBox(nameInput) {

            var dateStart = $('#Date_Start').val();
            var dateEnd = $('#Date_End').val();

            var Start = Date.parse(dateStart);
            var End = Date.parse(dateEnd);

            var Input = document.getElementById(nameInput);
            console.log(Input)
            var name = this.getAttribute('data-name');


            var timeRental = (End - Start) / (1000 * 60 * 60 * 24);
            var price = $('#PricePerDay').val();
            console.log("Цена за день аренды: " + price);

            var priceDo = $('#Price').val();
            var priceDOInt = Number.parseInt(priceDo);
            console.log("Цена до услуги:" + priceDOInt);
            var priceUslugi = $('#' + name).val();
            console.log("Цена услуги: " + priceUslugi);
            var priceUslugiInt = Number.parseInt(priceUslugi);

            var priceRental = roundNumber(timeRental * price, 0);
            console.log("Время аренды: " + timeRental);
            console.log("Цена за всю аренду по времени: " + priceRental);


            if (document.getElementById(name).checked && dateEnd != "") {
                console.log("нажат");
                console.log(timeRental);

                console.log("priceUslugi:" + priceUslugiInt);

                document.getElementById("Price").setAttribute('value', roundNumber((priceDOInt + (timeRental * priceUslugiInt)), 0));

                console.log("Price dop. uslugi : " + (timeRental * priceUslugiInt));

                this.nextElementSibling.value = roundNumber(timeRental * priceUslugiInt, 0);
                document.getElementById('notDateEnd').innerHTML = "";

            } else if (dateEnd != "") {
                document.getElementById(name).checked = false;
                this.nextElementSibling.value = "";
                document.getElementById("Price").setAttribute('value', roundNumber((priceDOInt - (timeRental * priceUslugiInt)), 0));
            } else {
                console.log("not нажат");
                document.getElementById(name).checked = false;
                document.getElementById('notDateEnd').innerHTML = "Выберите дату завершения аренды!";
                document.getElementById("Price").setAttribute('value', roundNumber(priceDOInt - (timeRental * priceUslugiInt), 0));
                this.nextElementSibling.value = "";
            }
        }

        function PlusPriceFORChiledChes() {
            var dateStart = $('#Date_Start').val();
            var dateEnd = $('#Date_End').val();
            var Start = Date.parse(dateStart);
            var End = Date.parse(dateEnd);

            var timeRental = (End - Start) / (1000 * 60 * 60 * 24);

            var priceDo = $('#Price').val();
            var priceDOInt = getNowPrice();
            //var price = $('#PricePerDay').val();
            //var priceDOInt = Number.parseInt(price);

            //priceDOInt = roundNumber(priceDOInt * timeRental, 0);

            console.log("Функция расчёта цены аренды: " + getNowPrice());

            console.log(priceDOInt);
            var rng = document.getElementById('child');
            var rngValue = Number.parseInt(rng.value);
            console.log(rngValue);
            var priceUslugi = Number.parseInt(rngValue * 100);
            if (rngValue != 0 && dateEnd != "") {
                console.log("нажат");
                console.log("priceUslugi:" + (rngValue * 100));
                document.getElementById("Price").setAttribute('value', priceUslugi + priceDOInt);
                console.log("Price dop. uslugi : " + (rngValue * 100));
            } else if (dateEnd == "") {
                console.log("not нажат");
                document.getElementById('notDateEnd').innerHTML = "Выберите дату завершения аренды!";
                document.getElementById('child').value = 0;
                this.nextElementSibling.value = this.value;
            } else if (dateEnd != "") {
                document.getElementById("Price").setAttribute('value', priceDOInt - priceUslugi);
            }
        }

        function getNowPrice() {
            var dateStart = $('#Date_Start').val();
            var dateEnd = $('#Date_End').val();

            var Start = Date.parse(dateStart);
            var End = Date.parse(dateEnd);

            var timeRental = (End - Start) / (1000 * 60 * 60 * 24);
            var price = $('#PricePerDay').val();

            var priceUslugi1 = $('#Registrator').val();
            var priceUslugi2 = $('#AutoBox').val();

            priceUslugi1Int = 0;
            priceUslugi2Int = 0;

            if (document.getElementById("Registrator").checked) {
                priceUslugi1Int = roundNumber(timeRental * Number.parseInt(priceUslugi1), 0);
            }

            if (document.getElementById("AutoBox").checked) {
                priceUslugi2Int = roundNumber(timeRental * Number.parseInt(priceUslugi2), 0);
            }


            priceNow = roundNumber(timeRental * price, 0);
            priceNow = priceNow + priceUslugi1Int + priceUslugi2Int;
            return priceNow;
        }

        $('#Registrator').on('change', PlusPriceFORCheckBox);
        $('#AutoBox').on('change', PlusPriceFORCheckBox);
        $('#child').on('change', PlusPriceFORChiledChes);

        function AddAdditionsOptions() {
            var checkBox1 = document.getElementById("Registrator").checked;
            var checkBox2 = document.getElementById("AutoBox").checked;
            var child = document.getElementById("child").value;

            var additionnalOptions = document.getElementById("Additional_Options").value;
            var input = document.getElementById("Additional_Options");

            if (checkBox1) {
                input.setAttribute('value', additionnalOptions + "Видеорегистратор;");
                additionnalOptions = document.getElementById("Additional_Options").value;
                /* console.log(additionnalOptions);*/
            }
            if (checkBox2) {

                input.setAttribute('value', additionnalOptions + "\ Автобокс;");
                additionnalOptions = document.getElementById("Additional_Options").value;
                /*            console.log(additionnalOptions);*/
            }
            if (child != 0) {
                input.setAttribute('value', additionnalOptions + "\ Детское-кресло;" + child);
                additionnalOptions = document.getElementById("Additional_Options").value;
                /*            console.log(additionnalOptions);*/
            }

        }

    </script>
    <script src="../../static/js/bootstrap.js"></script>

</#macro>