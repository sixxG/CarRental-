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

                <a type="button" class="btn btn-info" href="/car/all?status=Свободна">Свободные</a>
                <a type="button" class="btn btn-info" href="/car/all?status=Забронирована">Забронированные</a>
                <br>
                <!-- Gallery item  -->
                <div>

                    <#list cars?sort_by("price") as car>
                        <@carParts.carCard car=car></@carParts.carCard>
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
                                <input type="hidden" name="_csrf" value="<#if _csrf?has_content>${_csrf.token}</#if>">
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
                    <li>
                        <a href="/car/all?numberPage=0">Start</a>
                    </li>
                        <#list 1..countPage as page>
                            <li  id="page_${page-1}">
                                <a href="/car/all?numberPage=${page-1}">${page}</a>
                            </li>
                        </#list>
                    <li>
                        <a href="/car/all?numberPage=${countPage-1}">End</a>
                    </li>
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