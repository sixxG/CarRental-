<#import "../parts/common.ftl" as c>
<#import "../parts/nav-bar.ftl" as nav_bar>
<#include "../parts/security.ftl">


<@c.page>

    <link href="/static/css/Details.css" rel="stylesheet" />
    <link href="/static/css/Button.css" rel="stylesheet" />
    <link href="/static/css/Contact_CSS.css" rel="stylesheet" />

    <link rel="stylesheet" href="/static/css/Appeal.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css">

    <div class="container body-content" style="display: flex; flex-direction: column; min-height: 100%; width: 80%; margin-top: 5%">

        <a href="/car" class="carHeader">Список авто</a>

        <#if isAdmin || isManager>
            <div style="display: flex; width: 100%; margin: 0 auto; justify-content: center">
                <form action="/car/delete" method="get" style="margin-right: 10px">

                    <input type="hidden" name="id" value="${car.getId()?c}">

                    <button type="submit" style="border: 0px; align-items: center; padding: 0px; height: 40px">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi bi-trash" viewBox="0 0 16 16">
                            <path d="M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0V6z"/>
                            <path fill-rule="evenodd" d="M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1v1zM4.118 4 4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4H4.118zM2.5 3V2h11v1h-11z"/>
                        </svg>
                    </button>

                </form>

                <form action="/car/edit" method="get">

                    <input type="hidden" name="id" value="${car.getId()?c}"/>

                    <button type="submit" data-toggle="modal" data-target="#exampleModalCenter" style="border: 0px; align-items: center; padding: 5px; height: 40px" class="bi-edit">
                        <i class="fas fa-edit" style="font-size: 24px"></i>
                    </button>

                </form>
            </div>
        </#if>
        <!---->
        <div class="container-fluid bloc" style="width: 100%">
            <div class="col-lg-2 bloc-inside bloc-image">
<#--                <img src="/imageCar/<#if car.image??>-->
<#--                    ${car.image}-->
<#--                    <#else>-->
<#--                    car.png-->
<#--                </#if>" width="100%" height="100%" style="border-radius: 15px;" />-->

                <img src="/imageCar/${car.image}" width="100%" height="100%" style="border-radius: 15px;" />
            </div>
            <div class="col-lg-2 bloc-inside bloc-info">
                <h3>Период аренды</h3>
                <form action="/contract/create" method="post">
                    <div style="display: flex">
                        <div class="col-lg-2 col-lg-label" style="padding-top: 30px;">
                            <label>Начало: </label>
                            <br /><br />
                            <label>Завершение: </label>
                        </div>
                        <div class="col-lg-2 col-lg-text">
                            <input class="form-control datepicker text-box single-line" id="dateStart" min="02/14/2023 13:01:18" name="dateStart" style="width: 100%;" type="datetime-local" value="" />

                            <br />
                            <input class="form-control datepicker text-box single-line" id="dateEnd" min="02/15/2023 13:01:18" name="dateEnd" style="width: 100%;" type="datetime-local" value="" />

                            <input type="hidden" value="${car.id?c}" id="car_id" name="car_id">
                            <input type="hidden" name="_csrf" value="<#if _csrf?has_content>${_csrf.token}</#if>">
                        </div>
                    </div>
                    <br />
                    <div style="width:100%; height:100%; text-align:center;">
                        <#if user?? && !isHasActiveContract && !activeContract??>
<#--                            <a href="/contract/create?car=${car.id}" id="RentalCar" class = "btn-details">Арендовать</a>-->
                            <button type="submit" id="RentalCar" class = "btn-details">Арендовать</button>
                            <#else >
                                <a href="#" id="RentalCar" class = "btn-details" onclick="rentalNotClient()">Арендовать</a>
                                <span id="rentalNotClient" style="display: none;">
                                    <p style="color: red; font-weight: 600;">
                                        Арендовать автомобиль может только авторизованный пользователь,
                                        и пользователь, не имеющий активной аренды!
                                    </p>
                                </span>
                        </#if>

                        <#if activeContract??>
                            <p style="color: black; font-weight: 600;">
                                Данный автомобиль находится в аренде до ${dateEnd}
                            </p>
                        </#if>

                        <script>
                            function rentalNotClient() {
                                document.getElementById('rentalNotClient').setAttribute("style", "display: block");
                            }
                        </script>

                    </div>

                </form>
                <hr />

                <span class="period">
            <b>${car.price?c}&nbsp;₽</b>
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
                        <label>${car.power?c}</label>
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
                        <label>${car.year?c}</label>
                    </div>
                </div>
                <div style="display: flex; width: 100%;">
                    <div class="col-lg-2 character-label">
                        <label>Пробег</label>
                    </div>
                    <div class="col-lg-2 character-data">
                        <label>${car.mileage?c}</label>
                    </div>
                </div>
            </div>

        </div>


        <script>

            function NoneRental() {
                var p = document.getElementById('notFinish');
                p.innerHTML = 'Вы не можете арендовать новое авто т.к. у вас уже есть активная аренда.';
            };

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

            ($('#RentalCar')).on("click", function () {
                var dateStart = "";
                var dateEnd = "";
                dateStart = dateStart + getDateStart().returned;
                dateEnd = dateEnd + getDateEnd().returned;
                console.log(dateStart);
                console.log(dateEnd);
                var url = "https://localhost:44347/Contracts/Create/" + "67001" + "?dateStart=" + dateStart + "&dateEnd=" + dateEnd;
                console.log(url)
                window.location = url;
            })

        </script>

        <br />

    </div>
</@c.page>
