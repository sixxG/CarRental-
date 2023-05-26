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
                <br>

                <!-- Gallery item -->

                <!-- Эконом -->
                <a href="/carbyclass?carClass=Эконом&numberPage=0" class="carClassHeader">Эконом</a>
                <div class="carsBlock">
                    <#list EconomyCar as car>
                        <@carParts.carCard car=car></@carParts.carCard>
                    <#else >
                        <h1 style="display: block; width: 100%; text-align: center">Таких авто нет(</h1>
                    </#list>
                </div>
                <!-- Эконом -->

                <!-- Комфорт -->
                <a href="/carbyclass?carClass=Комфорт&numberPage=0" class="carClassHeader">Комфорт</a>
                <div class="carsBlock">
                    <#list ComfortCar as car>
                        <@carParts.carCard car=car></@carParts.carCard>
                    <#else >
                        <h1 style="display: block; width: 100%; text-align: center">Таких авто нет(</h1>
                    </#list>
                </div>
                <!-- Комфорт -->

                <!-- Бизнес -->
                <a href="/carbyclass?carClass=Бизнес&numberPage=0" class="carClassHeader">Бизнес</a>
                <div class="carsBlock">
                    <#list BusinessCar as car>
                        <@carParts.carCard car=car></@carParts.carCard>
                    <#else >
                        <h1 style="display: block; width: 100%; text-align: center">Таких авто нет(</h1>
                    </#list>
                </div>
                <!-- Бизнес -->

                <!-- Premium -->
                <a href="/carbyclass?carClass=Premium&numberPage=0" class="carClassHeader">Premium</a>
                <div class="carsBlock">
                    <#list PremiumCar as car>
                        <@carParts.carCard car=car></@carParts.carCard>
                    <#else >
                        <h1 style="display: block; width: 100%; text-align: center">Таких авто нет(</h1>
                    </#list>
                </div>
                <!-- Premium -->

                <!-- Внедорожники -->
                <a href="/carbyclass?carClass=Внедорожники&numberPage=0" class="carClassHeader">Внедорожники</a>
                <div class="carsBlock">
                    <#list SuvCar as car>
                        <@carParts.carCard car=car></@carParts.carCard>
                    <#else >
                        <h1 style="display: block; width: 100%; text-align: center">Таких авто нет(</h1>
                    </#list>
                </div>
                <!-- Внедорожники -->

                <!-- Минивэны -->
                <a href="/carbyclass?carClass=Минивэны&numberPage=0" class="carClassHeader">Минивэны</a>
                <div class="carsBlock">
                    <#list BusCar as car>
                        <@carParts.carCard car=car></@carParts.carCard>
                    <#else >
                        <h1 style="display: block; width: 100%; text-align: center">Таких авто нет(</h1>
                    </#list>
                </div>
                <!-- Минивэны -->

                <!-- Уникальные авто -->
                <a href="/carbyclass?carClass=Уникальные авто&numberPage=0" class="carClassHeader">Уникальные авто</a>
                <div class="carsBlock">
                    <#list UniqueCar as car>
                        <@carParts.carCard car=car></@carParts.carCard>
                    <#else >
                        <h1 style="display: block; width: 100%; text-align: center">Таких авто нет(</h1>
                    </#list>
                </div>
                <!-- Уникальные авто -->

                <!-- Gallery item -->

            </div>

            <#if isManager>
                <div id="AddCar" class="tab-pane fade in">

                    <div style="margin-top: 5%">
                        <div class="container body-content" style="display: flex; flex-direction: column; min-height: 100%; width: 100%;">

                            <form action="/car" enctype="multipart/form-data" method="post">
                                <input type="hidden" name="_csrf" value="<#if _csrf?has_content>${_csrf.token}</#if>">
                                <@carParts.createForm></@carParts.createForm>
                            </form>

                            <br />

                        </div>
                    </div>

                </div>
            </#if>
        </div>


    </div>

</@c.page>