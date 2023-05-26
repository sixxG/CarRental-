<#import "../parts/common.ftl" as c>
<#import "../parts/nav-bar.ftl" as nav_bar>
<#include "../parts/security.ftl">

<@c.page>

    <script src="https://unpkg.com/axios/dist/axios.min.js"></script>

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

        <!-- Вставьте спиннер здесь -->
        <div id="loader">
            <div class="spinner"></div>
        </div>

        <br />

        <div class="tab-content">

            <div id="contract" class="tab-pane fade in active">
                <form action="/contract/save" method="post" id="rental-form">
                    <input type="hidden" name="_csrf" value="<#if _csrf?has_content>${_csrf.token}</#if>">
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
                                            <input style="width: 100%;" Value="${dateStart!''}" class="form-control datepicker text-box single-line" id="Date_Start" name="Date_Start" type="datetime-local" onchange="checkDate()"/>
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
                                                <input class="form-control text-box single-line" style="width: 100%;" name="placeReceiptYourselfOption" id="placeReceiptYourselfOption" placeholder="Введите свой вариант" value="" onchange="changePlaceReceipt()"/>
                                            </div>

                                        </div>
                                    </div>
                                    <p id="priceForTake" style="color: blue; font-weight: 600" value="0"></p>

                                    <p id="priceForDeliveryTake" style="color: blue; font-weight: 600"></p>
                                    <a href="https://yandex.ru/maps/?rtext=56.141136,40.372616~&rtt=mt" id="mapForDeliveryCarReceipt" target="_blank" style="display: none; color: #00ff00; font-weight: 600; font-size: 16px; text-decoration: none">Построить маршрут в Яндекс.Карты</a>
                                    <!--PlaceTake-->

                                    <h3 class="timeRentalHeader">Возврат</h3>

                                    <!--DateReturn-->
                                    <div class="dateStart">
                                        <div style="width: 40%">
                                            <label class="control-label" for="Date_Start">Дата возврата</label>
                                        </div>
                                        <div>
                                            <input style="width: 100%;" Value="${dateEnd!''}" class="form-control datepicker text-box single-line" id="Date_End" min="Date.now" name="Date_End" type="datetime-local" onchange="checkDate()"/>
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
                                                <input type="text" class="form-control text-box single-line" style="width: 100%;" name="placeReturnYourselfOption" id="placeReturnYourselfOption" placeholder="Введите свой вариант" value="" onchange="changePlaceReturn()"/>
                                            </div>

                                        </div>
                                    </div>
                                    <p id="priceForReturn" style="color: blue; font-weight: 600" value="0"></p>
                                    <!--PlaceReturn-->

                                    <p id="priceForDelivery" style="color: blue; font-weight: 600"></p>
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

                                    <div class="dateStart">
                                        <div style="width: 40%">
                                            <a type="button" class="btn btn-success control-label" onclick="calculateResultPrice()">Итого</a>
                                        </div>
                                        <div>
                                            <p class="form-control price text-box single-line" id="ResultPrice" style="width: 100%;"></p>
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
                                            <button type="submit" class="btn-details" onclick="calculateResultPriceToPriceRent()">Арендовать</button>
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
                                        <input class="form-control datepicker text-box single-line" id="dateStart" style="width: 100%;" type="datetime-local" value="${dateStart!""}" />

                                        <br />
                                        <input class="form-control datepicker text-box single-line" id="dateEnd" style="width: 100%;" type="datetime-local" value="${dateEnd!''}" />

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

    <script src="../../static/js/contractCreate.js"></script>

</@c.page>