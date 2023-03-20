<#import "../parts/common.ftl" as c>
<#import "../parts/nav-bar.ftl" as nav_bar>
<#import "../parts/car.ftl" as carParts>
<#include "../parts/security.ftl">

<link href="/static/css/Button.css" rel="stylesheet" />
<link href="/static/css/Contact_CSS.css" rel="stylesheet" />
<link href="/static/css/CarList.css" rel="stylesheet" />
<@c.page>

    <div class="container body-content" style="display: flex; flex-direction: column; min-height: 100%; width: 80%;">

        <#if isAdmin>
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
                    <a class="AllCar" href="/car/all?numberPage=0">Все авто</a>
                </div>
                <br>
                <@carParts.search></@carParts.search>

                <@carParts.classes></@carParts.classes>
                <br>
                <br>

                <!-- Gallery item  -->
                <div class="carsBlock">

                    <#list cars as car>
                        <div class="col-xl-3 col-lg-4 col-md-6 mb-4">
                            <div class="bg-info img-rounded shadow-sm">

                                <div style="padding: 15px; margin: 10px">
                                    <img src="/imageCar/${car.image}" width="100%" height="220px" />
                                    <p>
                                        <h4>
                                            <b>
                                                ${car.brand}
                                                ${car.model}
                                                ,
                                                ${car.year}
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
                                        <p class="auto-description">&gt;${car.mileage}</p>
                                        <p class="auto-description">${car.power} лс.</p>
                                        <p class="auto-description">${car.body}</p>
                                    </div>

                                    <div class="bg-info">
                                        <h4 class="carPrice"><b>от ${car.price}</b> / сутки</h4>
                                    </div>

                                    <#if isAdmin>
                                        <h4 class="text-success text-uppercase" style="text-align: center">
                                            <b style="color: green">${car.status}</b>
                                        </h4>
                                    </#if>

                                    <div style="width:100%; height:100%; text-align:center;">
                                        <a class="btn-details" href="/car/details?id=${car.id}">Подробнее</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <#else >
                        <h1 style="display: block; width: 100%; text-align: center">Таких авто нет(</h1>
                    </#list>

                </div>
            </div>

            <#if isAdmin>
                <div id="AddCar" class="tab-pane fade in">

                    <div style="margin-top: 5%">
                        <div class="container body-content" style="display: flex; flex-direction: column; min-height: 100%; width: 100%;">

                            <form action="/car" enctype="multipart/form-data" method="post">
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
            const urlParam = new URLSearchParams(window.location.search);

            console.log(urlParam);

            const numberPage = urlParam.get('numberPage');
            document.getElementById("page_" + numberPage).classList.add("active");
        </script>
        <!--Block-->

    </div>

</@c.page>

<script>
    const urlParams = new URLSearchParams(window.location.search);
    const carClass = urlParams.get('carClass');

    let Element = document.querySelector('#myParam');
    // обращение к интересующему свойству и присвоение нового цвета
    document.getElementById(carClass).style.color = '#00ff00';
    document.getElementById(carClass).style.fontWeight = 600;

</script>

<script>
    const urlParam = new URLSearchParams(window.location.search);

    console.log(urlParam);

    const PriceOT = urlParam.get('PriceOT');
    const PriceDO = urlParam.get('PriceDO');
    const ListBrand = urlParam.get('ListBrand');
    const ListTypeTransmition = urlParam.get('ListTypeTransmition');

    document.getElementById("PriceOT").value = PriceOT;
    document.getElementById("PriceDO").value = PriceDO;

    if (ListBrand === null) {
        document.getElementById("ListBrand").value = "";
    } else {
        document.getElementById("ListBrand").value = ListBrand;
    }

    if (ListTypeTransmition === null) {
        document.getElementById("ListTypeTransmition").value = "";
    } else {
        document.getElementById("ListTypeTransmition").value = ListTypeTransmition;
    }


</script>