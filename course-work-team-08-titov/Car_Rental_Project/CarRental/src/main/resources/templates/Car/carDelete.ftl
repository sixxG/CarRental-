<#import "../parts/common.ftl" as c>
<#import "../parts/nav-bar.ftl" as nav_bar>
<#include "../parts/security.ftl">

<@c.page>

    <div style="margin-top: 5%; width: 100%; justify-content: center; display: flex">

        <div class="card" style="width: 30%;">
            <img class="card-img-top" src="/imageCar/${car.image}" alt="Card image cap" width="60%"; height="235px" style="display: flex; margin: 0 auto;">

            <div class="card-body">
                <h3 class="card-title">${car.brand} ${car.model}, ${car.year?c}г</h3>
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

            <ul class="list-group list-group-flush">
                <li class="list-group-item" style="padding: 5px">
                    <div style="display: flex; width: 100%;">
                        <div class="col-lg-6 character-label">
                            <label>Привод</label>
                        </div>
                        <div class="col-lg-6 character-data">
                            <label>${car.drive}</label>
                        </div>
                    </div>
                </li>
                <li class="list-group-item" style="padding: 5px">
                    <div style="display: flex; width: 100%;">
                        <div class="col-lg-6 character-label">
                            <label>Кузов</label>
                        </div>
                        <div class="col-lg-6 character-data">
                        <label>${car.body}</label>
                    </div>
                    </div>
                </li>
                <li class="list-group-item" style="padding: 5px">
                    <div style="display: flex; width: 100%;">
                        <div class="col-lg-6 character-label">
                            <label>КП</label>
                        </div>
                        <div class="col-lg-6 character-data">
                            <label>${car.transmission}</label>
                        </div>
                    </div>
                </li>
                <li class="list-group-item" style="padding: 5px">
                    <div style="display: flex; width: 100%;">
                        <div class="col-lg-6 character-label">
                            <label>Мощность</label>
                        </div>
                        <div class="col-lg-6 character-data">
                            <label>${car.power?c}</label>
                        </div>
                    </div>
                </li>
                <li class="list-group-item" style="padding: 5px">
                    <div style="display: flex; width: 100%;">
                        <div class="col-lg-6 character-label">
                            <label>Класс</label>
                        </div>
                        <div class="col-lg-6 character-data">
                            <label>${car.level}</label>
                        </div>
                    </div>
                </li>
                <li class="list-group-item" style="padding: 5px">
                    <div style="display: flex; width: 100%;">
                        <div class="col-lg-6 character-label">
                            <label>Цвет</label>
                        </div>
                        <div class="col-lg-6 character-data">
                            <label>${car.color}</label>
                        </div>
                    </div>
                </li>
                <li class="list-group-item" style="padding: 5px">
                    <div style="display: flex; width: 100%;">
                        <div class="col-lg-6 character-label">
                            <label>Год выпуска</label>
                        </div>
                        <div class="col-lg-6 character-data">
                            <label>${car.year?c}</label>
                        </div>
                    </div>
                </li>
                <li class="list-group-item" style="padding: 5px">
                    <div style="display: flex; width: 100%;">
                        <div class="col-lg-6 character-label">
                            <label>Пробег</label>
                        </div>
                        <div class="col-lg-6 character-data">
                            <label>${car.mileage?c}</label>
                        </div>
                    </div>
                </li>
            </ul>

            <div class="card-body">
                <a href="/car/details?id=${car.id?c}" class="card-link">Назад</a>
                <#if !isHasActiveContract>
                    <form action="/car/delete?id=${car.id?c}" method="post">

                        <input type="hidden" name="_csrf" value="<#if _csrf?has_content>${_csrf.token}</#if>">
                        <button type="submit" class="card-link">Удалить</button>

                    </form>
                </#if>
            </div>
        </div>
        <#if isHasActiveContract>
            <h3>
                Данный автомобиль находится в активной
                <a href="/contract/details?id=${contractId?c}">аренде</a>!
                <br>
                Завершите аренду и сможете удалить автомобиль!
            </h3>
        </#if>

    </div>

</@c.page>