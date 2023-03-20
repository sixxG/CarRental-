<#import "../parts/common.ftl" as c>
<#import "../parts/nav-bar.ftl" as nav_bar>
<#include "../parts/security.ftl">

<@c.page>

<div class="container body-content" style="display: flex; flex-direction: column; min-height: 100%; width: 80%;">

    <link href="/static/css/ContractDetails.css" rel="stylesheet" />
    <br />

    <h2 style="margin-top: 5%;">Активная</h2>

    <hr style="color: #5394FD; margin: 5px; background: #5394FD; border: 0.5px solid #5394FD " />

    <#if activeContract?has_content>
        <div class="container body-content" style="display: flex; flex-direction: column; min-height: 100%; width: 100%;">

        <div style="display: flex; background: rgba(40,40,40,0.15); width: 100%; height: 100%; border-radius: 15px; padding: 10px; margin-bottom: 10px;">
            <div style="padding: 0; display: inline-block; width: 50%" id="Renta">
                <a href="/car/details?id=${car.id}" style="font-size: 32px; color: black; text-align: center;">Автомобиль</a>
                <img src="/imageCar/${car.image}" width="260" height="160" style="border-radius: 15px;">
                <p style="font-size: 24px; color: black; font-weight: 600; text-align: center; margin-top: 5px;">${car.brand} ${car.model}</p>
            </div>

            <div style="padding: 0; display: inline-block; width: 50%; margin-left: 15px;">
                <p style="font-size: 32px; color: black;">Дата получения</p>
                <p style="font-size: 26px; color: #404040;" id="dateStart">${activeContract.dateStart!"some error"}</p>
                <p style="font-size: 32px; color: black;">Доп. опции</p>
                <p style="font-size: 20px; color: #404040;">Видеорегистратор;<br> Автобокс; <br> Детское-кресло;3</p>
            </div>

            <div style="padding: 0; display: inline-block; width: 50%; margin-left: 15px;">
                <p style="font-size: 32px; color: black;">Дата возврата</p>
                <p style="font-size: 26px; color: #404040;" id="dateEnd">${activeContract.dateEnd!"some error"}</p>
                <p style="font-size: 32px; color: black;">Примечания</p>
                <p style="font-size: 20px; color: #404040;">Хочу автомобиль</p>
            </div>

            <div style="padding: 0; display: inline-block; text-align: center; width: 50%;">
                <p style="font-size: 32px; color: black;">Осталось</p>
                <p style="font-size: 32px; color: red;">${rentalHours!"some error"} часов</p>
                <p style="font-size: 32px; color: black;">Состояние</p>
                <p style="font-size: 20px; color: #404040;">${activeContract.status!"some error"}</p>

                <div id="Finished" style="display: flex;">
                    <#if activeContract.getStatus() = "Действует">
                        <button style="font-size: 25px; background: #46F046; margin-bottom: 10px; width: 100%; display: block" class="btn-canceled butto" onclick="NotFinish()">
                            Завершить
                        </button>
                    </#if>

                    <#if activeContract.getStatus() = "Не подтверждён">
                        <div id="Canceled" style="width: 90%; display: block;">
                            <input type="submit" value="Отменить" class="btn-canceled butto" style="width: 100%;margin-left: 15px; display: block" />
                        </div>
                    </#if>
                </div>
            </div>

        </div>
            <div style="display: block; width: 100%;">
                <button style="font-size: 25px; padding: 0px; width: 100%;">
                    <a href="/contract/details?id=${activeContract.getId()}" style="width: 100%; display: block">Подробнее</a>
                </button>
            </div>


    </div>
        <#else >
            <h1 style="text-align:center;">Активных аренд нет(</h1>
            <br />
    </#if>

    <hr style="color: #5394FD; margin: 5px; background: #5394FD; border: 0.5px solid #5394FD " />

    <h2 style="width: 100%; text-align:center">История аренд</h2>

    <ul class="nav nav-tabs">
        <li class="active">
            <a data-toggle="tab" href="#ALL" style="font-size: 36px; color: black; padding: 10px 5px 5px 5px;"><h4>Все</h4></a>
        </li>
        <li>
            <a data-toggle="tab" href="#Canceled" style="padding: 10px 5px 5px 5px;"><h4>Отменённые</h4></a>
        </li>
        <li>
            <a data-toggle="tab" href="#Finishedd" style="padding: 10px 5px 5px 5px;"><h4>Завершённые</h4></a>
        </li>

    </ul>

    <div class="tab-content" style="margin-bottom: 5%;">
        <div id="ALL" class="tab-pane fade in active">
            <br />

            <#list contracts as contract>
                <div class="container body-content" style="display: flex; flex-direction: column; min-height: 100%; width: 100%;">

                    <div style="display: flex; background: rgba(40,40,40,0.15); width: 100%; height: 100%; border-radius: 15px; padding: 10px; margin-bottom: 10px;">
                        <div style="padding: 0; display: inline-block; width: 50%" id="Renta">
                            <a href="/car/details?id=${contract.car.id}" style="font-size: 32px; color: black; text-align: center;">Автомобиль</a>
                            <img src="/imageCar/${contract.car.image}" width="260" height="160" style="border-radius: 15px;">
                            <p style="font-size: 24px; color: black; font-weight: 600; text-align: center; margin-top: 5px;">${contract.car.brand} ${contract.car.model}</p>
                        </div>

                        <div style="padding: 0; display: inline-block; width: 50%; margin-left: 15px;">
                            <p style="font-size: 32px; color: black;">Дата получения</p>
                            <p style="font-size: 26px; color: #404040;" id="dateStart">${contract.dateStart!"some error"}</p>
                            <p style="font-size: 32px; color: black;">Доп. опции</p>
                            <p style="font-size: 20px; color: #404040;">Видеорегистратор;<br> Автобокс; <br> Детское-кресло;3</p>
                        </div>

                        <div style="padding: 0; display: inline-block; width: 50%; margin-left: 15px;">
                            <p style="font-size: 32px; color: black;">Дата возврата</p>
                            <p style="font-size: 26px; color: #404040;" id="dateEnd">${contract.dateEnd!"some error"}</p>
                            <p style="font-size: 32px; color: black;">Примечания</p>
                            <p style="font-size: 20px; color: #404040;">Хочу автомобиль</p>
                        </div>

                        <div style="padding: 0; display: inline-block; text-align: center; width: 50%;">
                            <p style="font-size: 32px; color: black;">Цена</p>
                            <p style="font-size: 32px; color: red;">${contract.price!"some error"}</p>
                        </div>


                    </div>
                    <br />

                    <br />

                </div>
                <#else >
                    <h1 style="text-align:center;">У вас ещё не было аренд!</h1>
                    <br />
            </#list>

        </div>
<#--        <div id="Canceled" class="tab-pane fade in">-->
<#--            <br />-->

<#--            <div class="container body-content" style="display: flex; flex-direction: column; min-height: 100%; width: 80%;">-->

<#--                <div style="display: flex; background: rgba(40,40,40,0.15); width: 100%; height: 100%; border-radius: 15px; padding: 10px; margin-bottom: 10px;">-->
<#--                    <div style="padding: 0; display: inline-block; width: 50%" id="Renta">-->
<#--                        <p style="font-size: 32px; color: black;">Автомобиль</p>-->
<#--                        <p style="font-size: 24px; color: black;">BMW X1</p>-->
<#--                        <a class="btnDetails_Contract" href="/Contracts/Details/1050">Подробнее</a>-->
<#--                    </div>-->

<#--                    <div style="padding: 0; display: inline-block; text-align: center; width: 50%;">-->
<#--                        <p style="font-size: 32px; color: black;">Дата получения</p>-->
<#--                        <p style="font-size: 32px; color: #404040;">29.12.2022 21:08:00</p>-->
<#--                    </div>-->

<#--                    <div style="padding: 0; display: inline-block; text-align: center; width: 50%;">-->
<#--                        <p style="font-size: 32px; color: black;">Дата возврата</p>-->
<#--                        <p style="font-size: 32px; color: #404040;">05.01.2023 12:00:00</p>-->
<#--                    </div>-->

<#--                    <div style="display: block; width: 50%;">-->
<#--                        <p style="font-size: 32px; color: black;">Доп. опции</p>-->
<#--                        <p style="font-size: 20px; color: #404040;">Видеорегистратор; Автобокс; Детское-кресло;3</p>-->
<#--                        <p style="font-size: 32px; color: black;">Примечания</p>-->
<#--                        <p style="font-size: 20px; color: #404040;">Хочу автомобиль</p>-->
<#--                    </div>-->

<#--                    <div style="padding: 0; display: inline-block; text-align: center; width: 50%;">-->
<#--                        <p style="font-size: 32px; color: black;">Цена</p>-->
<#--                        <p style="font-size: 32px; color: red;">22800</p>-->
<#--                        <p style="font-size: 32px; color: black;">Состояние</p>-->
<#--                        <p style="font-size: 20px; color: #404040;">Отменён</p>-->
<#--                    </div>-->


<#--                </div>-->
<#--                <br />-->



<#--                <br />-->

<#--            </div><!-- /End Section Container &ndash;&gt;-->

<#--        </div>-->
<#--        <div id="Finishedd" class="tab-pane fade in">-->
<#--            <br />-->

<#--            <div class="container body-content" style="display: flex; flex-direction: column; min-height: 100%; width: 80%;">-->

<#--                <h1 style="text-align:center; margin-bottom: 100px;">Аренд нет(</h1>-->

<#--                <br />-->

<#--            </div><!-- /End Section Container &ndash;&gt;-->

<#--        </div>-->
    </div>

    <script>
        function NotFinish() {
            var p = document.getElementById('notFinish');
            p.innerHTML = 'Вы не можете завершить аренду т.к. она ещё не активна.';
        }

        //форматирования сроков аренды
        const pTagStart = document.querySelector("#dateStart");
        // Исходная дата в формате "yyyy-MM-ddTHH:mm"
        const dateString = pTagStart.textContent;
        // Создаем новый объект даты на основе исходной строки
        const date = new Date(dateString);
        // Форматируем дату и время в нужный формат "dd-MM-yyyy hh:mm"
        const formattedDate = date.getDate().toString().padStart(2, '0')
            + "-" + (date.getMonth() + 1).toString().padStart(2, '0')
            + "-" + date.getFullYear() + " " + date.getHours().toString().padStart(2, '0')
            + ":" + date.getMinutes().toString().padStart(2, '0');
        pTagStart.textContent = formattedDate;

        const pTagEnd = document.querySelector("#dateEnd");
        const dateStringEnd = pTagEnd.textContent;
        const dateEnd = new Date(dateStringEnd);
        const formattedDateEnd = dateEnd.getDate().toString().padStart(2, '0')
            + "-" + (dateEnd.getMonth() + 1).toString().padStart(2, '0')
            + "-" + dateEnd.getFullYear() + " " + dateEnd.getHours().toString().padStart(2, '0')
            + ":" + dateEnd.getMinutes().toString().padStart(2, '0');
        pTagEnd.textContent = formattedDateEnd;

    </script>


    <br />

</div><!-- /End Section Container -->

</@c.page>