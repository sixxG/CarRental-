<#import "../parts/common.ftl" as c>
<#import "../parts/nav-bar.ftl" as nav_bar>
<#import "../parts/car.ftl" as carParts>
<#include "../parts/security.ftl">

<link href="/static/css/Button.css" rel="stylesheet" />
<link href="/static/css/Contact_CSS.css" rel="stylesheet" />
<link href="/static/css/CarList.css" rel="stylesheet" />
<link href="/static/css/Details.css" rel="stylesheet" />
<@c.page>

    <div class="container body-content" style="display: flex; flex-direction: column; min-height: 100%; width: 80%;">

        <#if isAdmin || isManager>
            <!--new nav-->
            <ul class="nav nav-tabs" style="margin-top: 6%;">
                <li class="active">
                    <a data-toggle="tab" href="#listCar"><h4>Парк автомобилей</h4></a>
                </li>
                <li>
                    <a data-toggle="tab" href="#AddCar"><h4>Добавить авто</h4></a>
                </li>
            </ul>
            <!--new nav-->
            <#else>
                <p style="margin-top: 6%"></p>
        </#if>

        <div class="tab-content" style="width: 100%; margin-top: 1%;">
            <div id="listCar" class="tab-pane fade in active" style="width: 100%;">
                <div style="width: 100%; text-align: center;">
                    <a class="carHeader" href="/car/all?numberPage=0">Все авто</a>
                </div>
                <br>
                <@carParts.search></@carParts.search>

                <@carParts.classes></@carParts.classes>
                <br>
                <select id="sort-select">
                    <option value="asc">Сортировать по возрастанию цены</option>
                    <option value="desc">Сортировать по убыванию цены</option>
                </select>
                <br>
                <!-- Gallery item  -->
                <div>

                    <#list cars?sort_by("price") as car>
                        <div class="col-xl-3 col-lg-4 col-md-6 mb-4">
                            <div class="bg-info img-rounded shadow-sm" style="height: 560px; margin-bottom: 5px">

                                <div style="padding: 15px; margin: 10px">
                                    <img src="/imageCar/${car.image}" width="100%" height="220px" />
                                    <p>
                                        <h4>
                                            <b>
                                                ${car.brand}
                                                ${car.model}
                                                ,
                                                ${car.year?c}
                                                ${car.level}
                                            </b>
                                        </h4>
                                    <hr />

                                    <div class="auto-description-start">
                                        <p class="auto-description flat">Коробка</p>
                                        <p class="auto-description flat">Привод</p>
                                        <p class="auto-description flat">Пробег</p>
                                        <p class="auto-description flat">Мощность</p>
                                        <p class="auto-description flat">Тип кузова</p>
                                    </div>

                                    <div class="auto-description-edn">
                                        <p class="auto-description">${car.transmission}</p>
                                        <p class="auto-description">${car.drive}</p>
                                        <p class="auto-description">&gt;${car.mileage?c}</p>
                                        <p class="auto-description">${car.power?c} лс.</p>
                                        <p class="auto-description">${car.body}</p>
                                    </div>

                                    <div class="bg-info">
                                        <h4 class="carPrice"><b>от ${car.price?c}</b> / сутки</h4>
                                    </div>

                                    <#if isAdmin>
                                        <h4 class="text-success text-uppercase" style="text-align: center">
                                            <#if car.status == "Забронирована">
                                                <b style="color: red">${car.status}</b>
                                                <#else >
                                                    <b style="color: green">${car.status}</b>
                                            </#if>
                                        </h4>
                                    </#if>

                                    <div style="width:100%; text-align:center;">
                                        <a class="btn-details" href="/car/details?id=${car.id}">Подробнее</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <#else >
                        <h1 style="display: block; width: 100%; text-align: center">Таких авто нет(</h1>
                    </#list>

                    <script>
                        const sortSelect = document.getElementById('sort-select');
                        sortSelect.addEventListener('change', function() {
                            const sortDirection = sortSelect.value === 'asc' ? '' : '?reverse';
                            console.log(sortDirection);
                        });
                    </script>
                </div>
            </div>

            <#if isAdmin || isManager>
                <div id="AddCar" class="tab-pane fade in">

                    <div style="margin-top: 5%">
                        <div class="container body-content" style="display: flex; flex-direction: column; min-height: 100%; width: 100%;">

                            <form action="/car" enctype="multipart/form-data" method="post">
                                <input type="hidden" name="_csrf" value="${_csrf.token}">
                                <@carParts.createForm></@carParts.createForm>
                            </form>

                            <br />

                        </div>
                    </div>

                </div>
            </#if>
        </div>

        <#if countPage!=0>
            <div style="width: 100%; align-items: center;">

                <ul class="pagination" style="position: absolute; left: 45%">
                    <li id="page_0">
                        <a href="/car/all?numberPage=0">Start</a>
                    </li>
                        <#list 1..countPage as page>
                            <li  id="page_${page}">
                                <a href="/car/all?numberPage=${page}">${page}</a>
                            </li>
                        </#list>
                </ul>

                <br />
                <br />
                <br />
            </div>
        </#if>

        <script>
            //активная страница с отзывами
            const urlParamListCar = new URLSearchParams(window.location.search);

            const numberPage = urlParamListCar.get('numberPage');
            document.getElementById("page_" + numberPage).classList.add("active");
        </script>
        <!--Block-->

    </div>

</@c.page>