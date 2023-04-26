<#import "../parts/common.ftl" as c>
<#import "../parts/nav-bar.ftl" as nav_bar>
<#include "../parts/security.ftl">

<@c.page>

    <link href="/static/css/CreatContract.css" rel="stylesheet" />
    <link href="/static/css/Details.css" rel="stylesheet" />
    <link href="/static/css/Contact_CSS.css" rel="stylesheet" />

    <div class="container body-content" style="display: flex; flex-direction: column; min-height: 100%; width: 80%;">

        <ul class="nav nav-tabs" style="margin-top: 5%;">
            <li class="active">
                <a data-toggle="tab" href="#contract"><h4>Аренда</h4></a>
            </li>
            <li>
                <a data-toggle="tab" href="#CarDetails"><h4>Авто</h4></a>
            </li>
        </ul>

        <br />

        <div class="tab-content">

            <div id="contract" class="tab-pane fade in active">
                <form action="/contract/save" method="post" id="rental-form">
                    <input type="hidden" name="_csrf" value="${_csrf.token}">
                    <p id="message" style="color: red;">${errorDate!''}</p>
                    <p id="message" style="color: red;">${priceRental!''}</p>
                    <div class="tab-conten form-horizontal">

                        <div class="tab-pane fade in active">
                            <p id="error-message" style="display: none; color: red;"></p>
                            <div style="display: flex;">
                                <!--Time rent-->
                                <div style="width: 70%; display: block">
                                    <h3 class="timeRentalHeader">Получение</h3>

                                    <!--DateTake-->
                                    <div class="dateStart">
                                        <div style="width: 40%">
                                            <label class="control-label" for="Date_Start">Дата получения</label>
                                        </div>
                                        <div>
                                            <input style="width: 100%;" Value="${dateStart}" class="form-control datepicker text-box single-line" id="Date_Start" name="Date_Start" type="datetime-local" onchange="checkDate()"/>
                                        </div>
                                    </div>
                                    <!--DateTake-->

                                    <!--PlaceTake-->
                                    <div class="dateStart">
                                        <div style="width: 40%">
                                            <label class="control-label" for="Date_Start">Место получения</label>
                                        </div>
                                        <div>
                                            <select class="form-control text-box single-line" style="width: 100%;" name="placeReceipt" onchange="toggleInputFieldReceipt()">
                                                <option selected>Офис</option>
                                                <option>Автовокзал</option>
                                                <option>Свой вариант</option>
                                            </select>

                                            <div id="inputFieldReceipt" style="display: none;">
                                                <input class="form-control text-box single-line" style="width: 100%;" name="placeReceiptYourselfOption" id="placeReceiptYourselfOption" placeholder="Введите свой вариант" onchange="changePlaceReceipt()">
                                            </div>

                                        </div>
                                    </div>
                                    <p id="priceForTake" style="color: blue; font-weight: 600" value="0"></p>
                                    <!--PlaceTake-->

                                    <h3 class="timeRentalHeader">Возврат</h3>

                                    <!--DateReturn-->
                                    <div class="dateStart">
                                        <div style="width: 40%">
                                            <label class="control-label" for="Date_Start">Дата возврата</label>
                                        </div>
                                        <div>
                                            <input style="width: 100%;" Value="${dateEnd}" class="form-control datepicker text-box single-line" id="Date_End" min="Date.now" name="Date_End" type="datetime-local" onchange="checkDate()"/>
                                            <p id="notDateEnd" style="color: red;"></p>
                                        </div>
                                    </div>
                                    <!--DateReturn-->

                                    <!--PlaceReturn-->
                                    <div class="dateStart">
                                        <div style="width: 40%">
                                            <label class="control-label" for="Date_Start">Место возврата</label>
                                        </div>
                                        <div>
                                            <select class="form-control text-box single-line" style="width: 100%;" name="placeReturn" onchange="toggleInputFieldReturn()">
                                                <option>Автовокзал</option>
                                                <option selected>Офис</option>
                                                <option>Свой вариант</option>
                                            </select>

                                            <div id="inputFieldReturn" style="display: none;">
                                                <input type="text" class="form-control text-box single-line" style="width: 100%;" name="placeReturnYourselfOption" id="placeReturnYourselfOption" placeholder="Введите свой вариант" onchange="changePlaceReturn()">
                                            </div>

                                        </div>
                                    </div>
                                    <p id="priceForReturn" style="color: blue; font-weight: 600" value="0"></p>
                                    <!--PlaceReturn-->

                                    <a href="https://yandex.ru/maps/?rtext=56.141136,40.372616~&rtt=mt" id="mapForDeliveryCar" target="_blank" style="display: none; color: #00ff00; font-weight: 500; text-decoration: none">Построить маршрут в Яндекс.Карты</a>

                                    <h3 class="timeRentalHeader">Стоимость</h3>
                                    <!--PriceRent-->

                                    <!--AdditionOptions-->
                                    <div class="dateStart">

                                        <div style="width: 40%">
                                            <label class="control-label" for="Date_Start">Доп. опции</label>
                                        </div>

                                        <div style="width: 100%; display: block">
                                            <div style="display: flex;">
                                                <div style="padding: 0; display: inline-block; width: 60%">
                                                    <label for="Registrator" class="labelForCheckBox">Видеорегистратор 150р/сутки</label>
                                                    <label for="AutoBox" class="labelForCheckBox">Автобокс 250р/сутки</label>
                                                    <label for="child" class="labelForCheckBox">Детское кресло 100р/сутки</label>
                                                </div>

                                                <div style="padding: 0; display: inline-block; text-align: center; width: 22%;">
                                                    <div style="display:flex;">
                                                        <input type="checkbox" id="Registrator" data-name="Registrator" name="Registrator" value="150" class="bloc-input-checkBox" />
                                                        <output style="display: compact; margin-left: 15px; font-size: 16px; color: black; text-align: center; "></output>
                                                    </div>
                                                    <div style="display:flex;">
                                                        <input type="checkbox" id="AutoBox" data-name="AutoBox" name="AutoBox" value="250" class="bloc-input-checkBox" />
                                                        <output style="display: compact; margin-left: 15px; font-size: 16px; color: black; text-align: center; "></output>
                                                    </div>
                                                    <div style="display:flex;">
                                                        <input type="range" min="0" max="3" value="0" id="child" data-name="child" name="interest" class="inputChaildChest" oninput="this.nextElementSibling.value = this.value" />
                                                        <output style="display: compact; margin-left: 15px; font-size: 16px; color: black; text-align: center; "></output>
                                                    </div>
                                                </div>
                                            </div>

                                        </div>

                                    </div>
                                    <!--AdditionOptions-->

                                    <!--Price-->
                                    <div class="dateStart">
                                        <div style="width: 40%">
                                            <label class="control-label" for="Date_Start">Стоимость доставки</label>
                                        </div>
                                        <div>
                                            <input value="0" class="form-control price text-box single-line" id="DeliveryPrice" name="DeliveryPrice" readonly="readonly" style="width: 100%;" type="number"/>
                                        </div>
                                    </div>

                                    <div class="dateStart" id="price-block">
                                        <div style="width: 40%">
                                            <label class="control-label" for="Date_Start">Цена</label>
                                        </div>
                                        <div>
                                            <input value="${car.getPrice()?c}" class="form-control price text-box single-line" id="Price" name="Price" readonly="readonly" style="width: 100%;" type="number"/>
                                        </div>
                                    </div>
                                    <!--Price-->

                                    <!--Time Rental-->
                                    <div class="dateStart">
                                        <div style="width: 40%">
                                            <label class="control-label" for="Date_Start">Продолжительность аренды</label>
                                        </div>
                                        <div>
                                            <output id="rentalTime" style="display: block; margin-left: 15px; font-size: 16px; color: black;"></output>
                                        </div>
                                    </div>
                                    <!--Time Rental-->

                                    <!--Note-->
                                    <div class="dateStart">
                                        <div style="width: 40%">
                                            <label class="control-label" for="Date_Start">Примечания</label>
                                        </div>
                                        <div>
                                            <input class="form-control text-box single-line" id="Notes" name="Notes" style="width: 150%;" type="text" value="" />
                                        </div>
                                    </div>
                                    <!--Note-->

                                    <!--PriceRent-->
                                </div>
                                <!--Time rent-->

                                <!--OtherData-->
                                <div style="width: 50%; display: block">

                                    <h3 class="timeRentalHeader">Ваши данные</h3>

                                    <!--ФИО-->
                                    <div class="dateStart">
                                        <div style="width: 40%">
                                            <label class="control-label" for="Date_Start">ФИО Клиента</label>
                                        </div>

                                        <input type="hidden" value="${client.getUsername()!""}" name="userName" id="userName">
                                        <div>
                                            <input Value="${client.fio!""}" class="form-control text-box single-line" id="FIO_Customer" name="FIO_Customer" style="width: 100%;" type="text" required/>
                                        </div>
                                    </div>
                                    <!--ФИО-->

                                    <!--Email-->
                                    <div class="dateStart">
                                        <div style="width: 40%">
                                            <label class="control-label" for="Date_Start">Email</label>
                                        </div>

                                        <div>
                                            <input Value="${client.email!""}" name="email" class="form-control text-box single-line" data-val="true" style="width: 100%;" type="text" required/>
                                        </div>
                                    </div>
                                    <!--Email-->

                                    <!--Phone-->
                                    <div class="dateStart">
                                        <div style="width: 40%">
                                            <label class="control-label" for="Date_Start">Телефон</label>
                                        </div>

                                        <div>
                                            <input Value="${client.phone!""}" name="phone" class="form-control text-box single-line" data-val="true" style="width: 100%;" type="text" required/>
                                        </div>
                                    </div>
                                    <!--Phone-->

                                    <!--DriverLicense-->
                                    <div class="dateStart">
                                        <div style="width: 40%">
                                            <label class="control-label" for="Date_Start">Номер ВУ</label>
                                        </div>

                                        <div>
                                            <input placeholder="1234 5678" value="${client.driverLicense!""}" name="driverLicense" class="form-control text-box single-line" style="width: 100%;" type="text" required/>
                                        </div>
                                    </div>
                                    <!--DriverLicense-->

                                    <!--Address-->
                                    <div class="dateStart">
                                        <div style="width: 40%">
                                            <label class="control-label" for="Date_Start">Адрес проживания</label>
                                        </div>

                                        <div>
                                            <input Value="${client.address!""}" name="address" class="form-control text-box single-line" data-val="true" style="width: 120%;" type="text" required/>
                                        </div>
                                    </div>
                                    <!--Address-->

                                    <h3 class="timeRentalHeader">Авто</h3>

                                    <!--Brand-->
                                    <div class="dateStart">
                                        <div style="width: 40%">
                                            <label class="control-label" for="Date_Start">Марка авто</label>
                                        </div>

                                        <div>
                                            <input Value="${car.brand}" class="form-control text-box single-line" readonly="readonly" style="width: 100%;" type="text"/>
                                        </div>
                                    </div>
                                    <!--Brand-->

                                    <!--Model-->
                                    <div class="dateStart">
                                        <div style="width: 40%">
                                            <label class="control-label" for="Date_Start">Модель авто</label>
                                        </div>

                                        <div>
                                            <input Value="${car.model}" class="form-control text-box single-line" readonly="readonly" style="width: 100%;" type="text"/>
                                        </div>
                                    </div>
                                    <!--Model-->

                                    <!--WIN-->
                                    <div class="dateStart">
                                        <div style="width: 40%">
                                            <label class="control-label" for="Date_Start">WIN номер</label>
                                        </div>

                                        <div>
                                            <input Value="${car.getWIN_Number()}" class="form-control text-box single-line" readonly="readonly" style="width: 100%;" type="text"/>
                                        </div>
                                    </div>
                                    <!--WIN-->

                                    <!--Rent Button-->
                                    <div class="dateStart">
                                        <div style="width: 100%;">
                                            <button type="submit" class="btn-details" onclick="calculateResultPrice()">Арендовать</button>
                                        </div>
                                    </div>
                                    <!--Rent Button-->
                                </div>
                                <!--OtherData-->
                            </div>

                        </div>
                        <div style="display: none;">
                            <input type="number" value="${car.getPrice()?c}" id="PricePerDay" readonly="readonly" />
                        </div>
                    </div>
                    <input type="hidden" value="${car.id}" name="car_id" id="car_id">
                </form>
            </div>
            <div id="CarDetails" class="tab-pane fade in" style="width: 100%;">


                <div class="container body-content" style="display: flex; flex-direction: column; min-height: 100%; width: 100%;">

                    <a href="/car" class="carHeader">Список авто</a>
                    <!---->
                    <div class="container-fluid bloc" style="width: 100%">
                        <div class="col-lg-2 bloc-inside bloc-image">
                            <img src="/imageCar/${car.image}" width="100%" height="100%" style="border-radius: 15px;" />
                        </div>
                        <div class="col-lg-2 bloc-inside bloc-info">
                            <h3>Период аренды</h3>
                                <div style="display: flex">
                                    <div class="col-lg-2 col-lg-label" style="padding-top: 30px;">
                                        <label>Начало: </label>
                                        <br /><br />
                                        <label>Завершение: </label>
                                    </div>
                                    <div class="col-lg-2 col-lg-text">
                                        <input class="form-control datepicker text-box single-line" id="dateStart" style="width: 100%;" type="datetime-local" value="${dateStart}" />

                                        <br />
                                        <input class="form-control datepicker text-box single-line" id="dateEnd" style="width: 100%;" type="datetime-local" value="${dateEnd}" />

                                    </div>
                                </div>
                                <br />
                            <hr />

                            <span class="period">
            <b>${car.price}&nbsp;₽</b>
            <span style="font-size: 20px">/ сутки</span>
        </span>
                            <p>
                                Вы пока ни за что не платите. Оформив аренду, можно лично обговорить детали бронирования с менеджером.
                            </p>
                        </div>
                    </div>
                    <!---->

                    <div class="col-lg-2 bloc-inside bloc-image" style="height: 100%;">
                    <span class="period">
                        <b>
                            ${car.brand}
                            ${car.model}
                        </b>
                    </span>

                        <hr style="color: #5394FD; margin: 5px; padding: 0.5px; background: #5394FD;" />

                        <div>
                            <p>
                                <a class="description" data-toggle="collapse" href="#description">
                                    Описание
                                </a>
                            </p>
                            <div class="collapse requestBody" id="description">
                                <div class="card card-body">
                                    <p style="font-size: 16px">
                                        ${car.description}
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-2 bloc-inside bloc-image" style="height: 100%;">
                    <span class="period">
                        <b>
                            Характеристики
                        </b>
                    </span>
                        <br />

                        <div class="character">
                            <div style="display: flex; width: 100%;">
                                <div class="col-lg-2 character-label">
                                    <label>Привод</label>
                                </div>

                                <div class="col-lg-2 character-data">
                                    <label>${car.drive}</label>
                                </div>
                            </div>
                            <div style="display: flex; width: 100%;">
                                <div class="col-lg-2 character-label">
                                    <label>Кузов</label>
                                </div>
                                <div class="col-lg-2 character-data">
                                    <label>${car.body}</label>
                                </div>
                            </div>
                            <div style="display: flex; width: 100%;">
                                <div class="col-lg-2 character-label">
                                    <label>КП</label>
                                </div>
                                <div class="col-lg-2 character-data">
                                    <label>${car.transmission}</label>
                                </div>
                            </div>
                            <div style="display: flex; width: 100%;">
                                <div class="col-lg-2 character-label">
                                    <label>Мощность</label>
                                </div>
                                <div class="col-lg-2 character-data">
                                    <label>${car.power}</label>
                                </div>
                            </div>
                            <div style="display: flex; width: 100%;">
                                <div class="col-lg-2 character-label">
                                    <label>Класс</label>
                                </div>
                                <div class="col-lg-2 character-data">
                                    <label>${car.level}</label>
                                </div>
                            </div>

                            <div style="display: flex; width: 100%;">
                                <div class="col-lg-2 character-label">
                                    <label>Цвет</label>
                                </div>
                                <div class="col-lg-2 character-data">
                                    <label>${car.color}</label>
                                </div>
                            </div>
                            <div style="display: flex; width: 100%;">
                                <div class="col-lg-2 character-label">
                                    <label>Год выпуска</label>
                                </div>
                                <div class="col-lg-2 character-data">
                                    <label>${car.year}</label>
                                </div>
                            </div>
                            <div style="display: flex; width: 100%;">
                                <div class="col-lg-2 character-label">
                                    <label>Пробег</label>
                                </div>
                                <div class="col-lg-2 character-data">
                                    <label>${car.mileage}</label>
                                </div>
                            </div>
                        </div>

                    </div>

                    <br />

                </div>

            </div>

        </div>

        <br />

    </div>

    <script src="https://code.jquery.com/jquery-3.6.3.js"></script>
    <script src="../../static/js/bootstrap.js"></script>

    <script>
        const rentalForm = document.getElementById('rental-form');
        const errorMessage = document.getElementById('error-message');

        rentalForm.addEventListener('submit', function(event) {
            event.preventDefault();
            const dateStart = new Date(document.getElementById('Date_Start').value) || "";
            const dateEnd = new Date(document.getElementById('Date_End').value) || "";
            const diffInDays = Math.round((dateEnd - dateStart) / (1000 * 60 * 60 * 24)) || null;
            if (diffInDays < 1 || diffInDays === null) {
                errorMessage.style.display = 'block';
                errorMessage.textContent = 'Дата окончания аренды должна быть не менее чем на 1 день больше даты начала аренды.';
            } else {
                rentalForm.submit();
            }
        });
    </script>

    <script>
        function changePlaceReturn() {
            document.getElementById('mapForDeliveryCar').setAttribute("href",
                'https://yandex.ru/maps/?rtext=56.141136,40.372616~' + document.getElementById('placeReturnYourselfOption').value);
        }

        function changePlaceReceipt() {
            document.getElementById('mapForDeliveryCar').setAttribute("href",
                'https://yandex.ru/maps/?rtext=56.141136,40.372616~' + document.getElementById('placeReceiptYourselfOption').value);
        }

        function calculateResultPrice() {
            const deliveryPrice = document.getElementById('DeliveryPrice');
            const rentalPrice = document.getElementById('Price');

            const total = (parseInt(deliveryPrice.value) || 0) + (parseInt(rentalPrice.value) || 0);
            rentalPrice.setAttribute('value', isNaN(total) ? 0 : total);
        }

        function calculateDeliveryPrice() {
            const priceForTake = document.getElementById('priceForTake');
            const priceForReturn = document.getElementById('priceForReturn');

            const deliveryPrice = document.getElementById('DeliveryPrice');

            const total = (parseInt(priceForReturn.value) || 0) + (parseInt(priceForTake.value) || 0);
            deliveryPrice.setAttribute('value', isNaN(total) ? 0 : total);
        }

        function toggleInputFieldReceipt() {
            const selectReceipt = document.querySelector('[name="placeReceipt"]');
            const inputFieldReceipt = document.getElementById('inputFieldReceipt');
            const priceForTake = document.getElementById('priceForTake');
            const selectedOption = selectReceipt.options[selectReceipt.selectedIndex].value;

            inputFieldReceipt.style.display = 'none';
            document.getElementById('mapForDeliveryCar').style.display = 'none';

            if (selectedOption === 'Свой вариант') {
                inputFieldReceipt.style.display = 'block';
                priceForTake.value = 0;
                priceForTake.textContent = "Стоимость доставки/возврата авто по вашему адресу будет рассчитана при получении автомобиля по следующей схеме: " +
                    "минимальная стоимость 300руб. или 20руб. за 1км";
                document.getElementById('mapForDeliveryCar').style.display = 'block';
            } else if (selectedOption === 'Автовокзал') {
                priceForTake.textContent  = "Стоимость возврата авто на Автовокзал: 500руб.";
                priceForTake.value = 500;
                priceForTake.style.display = 'block';
            }
            else {
                priceForTake.value = 0;
                priceForTake.textContent = "";
            }
            calculateDeliveryPrice();
        }

        function toggleInputFieldReturn() {
            const selectReturn = document.querySelector('[name="placeReturn"]');
            const inputFieldReturn = document.getElementById('inputFieldReturn');
            const priceForReturn = document.getElementById('priceForReturn');
            const selectedOption = selectReturn.options[selectReturn.selectedIndex].value;

            inputFieldReturn.style.display = 'none';
            document.getElementById('mapForDeliveryCar').style.display = 'none';

            if (selectedOption === 'Свой вариант') {
                inputFieldReturn.style.display = 'block';
                priceForReturn.value = 0;
                priceForReturn.textContent = "Стоимость доставки/возврата авто по вашему адресу будет рассчитана при получении автомобиля по следующей схеме: " +
                    "минимальная стоимость 300руб. или 20руб. за 1км";
                document.getElementById('mapForDeliveryCar').style.display = 'block';
            } else if (selectedOption === 'Автовокзал') {
                priceForReturn.textContent  = "Стоимость возврата авто на Автовокзал: 500руб.";
                priceForReturn.value = 500;
                priceForReturn.style.display = 'block';
            }
            else {
                priceForReturn.value = 0;
                priceForReturn.textContent = "";
            }
            calculateDeliveryPrice();
        }
    </script>

    <script>
        ($('#Date_End')).on("change keyup paste", function () {
            var dateStart = $('#Date_Start').val();
            var dateEnd = $('#Date_End').val();

            var Start = Date.parse(dateStart);
            var End = Date.parse(dateEnd);

            var timeRental = (End - Start) / (1000 * 60 * 60 * 24);
            var price = $('#PricePerDay').val();

            document.getElementById("Price").setAttribute('value', timeRental * price, 0);

            document.getElementById("rentalTime").value = roundNumber(timeRental, 1) + '.суток';

            document.getElementById('Registrator').checked = false;
            document.getElementById('AutoBox').checked = false;
            document.getElementById('child').value = 0;
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

            var priceDo = $('#Price').val();
            var priceDOInt = Number.parseInt(priceDo);
            var priceUslugi = $('#' + name).val();
            var priceUslugiInt = Number.parseInt(priceUslugi);

            var priceRental = roundNumber(timeRental * price, 0);

            if (document.getElementById(name).checked && dateEnd != "") {
                document.getElementById("Price").setAttribute('value', roundNumber((priceDOInt + (timeRental * priceUslugiInt)), 0));

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

            console.log("Функция расчёта цены аренды: " + getNowPrice());

            console.log(priceDOInt);
            var rng = document.getElementById('child');
            var rngValue = Number.parseInt(rng.value);
            console.log(rngValue);
            var priceUslugi = Number.parseInt(rngValue * 100 * timeRental);
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
                // additionnalOptions = document.getElementById("Additional_Options").value;
            }

        }

    </script>

</@c.page>