<#import "../parts/common.ftl" as c>
<#import "../parts/nav-bar.ftl" as nav_bar>
<#include "../parts/security.ftl">

<@c.page>

<div class="container body-content" style="display: flex; flex-direction: column; min-height: 100%; width: 80%;">

    <link href="/static/css/ContractDetails.css" rel="stylesheet" />
    <br />

    <h2 style="margin-top: 5%;">Активная</h2>

    <hr style="color: #5394FD; margin: 5px; background: #5394FD; border: 0.5px solid #5394FD " />

    <#if activeContract??>
        <div class="container body-content" style="display: flex; flex-direction: column; min-height: 100%; width: 100%;">

        <div style="display: flex; background: rgba(40,40,40,0.15); width: 100%; height: 100%; border-radius: 15px; padding: 10px; margin-bottom: 10px;">
            <div style="padding: 0; display: inline-block; width: 50%" id="Renta">
                <a href="/car/details?id=${activeContract.getCar().id?c}" style="font-size: 32px; color: black; text-align: center;">Автомобиль</a>
                <img src="/imageCar/${activeContract.getCar().image}" width="260" height="160" style="border-radius: 15px;">
                <p style="font-size: 24px; color: black; font-weight: 600; text-align: center; margin-top: 5px;">${activeContract.getCar().brand} ${activeContract.getCar().model}</p>
            </div>

            <div style="padding: 0; display: inline-block; width: 50%; margin-left: 15px;">
                <p style="font-size: 32px; color: black;">Дата получения</p>
                <p style="font-size: 26px; color: #404040;">${(activeContract.dateStart).format('yyyy-MM-dd HH:mm:ss')}</p>
                <p style="font-size: 32px; color: black;">Доп. опции</p>
                <p style="font-size: 20px; color: #404040;">Видеорегистратор;<br> Автобокс; <br> Детское-кресло;3</p>
            </div>

            <div style="padding: 0; display: inline-block; width: 50%; margin-left: 15px;">
                <p style="font-size: 32px; color: black;">Дата возврата</p>
                <p style="font-size: 26px; color: #404040;" id="dateEnd">${(activeContract.dateEnd).format('yyyy-MM-dd HH:mm:ss')}</p>
                <p style="font-size: 32px; color: black;">Примечания</p>
                <p style="font-size: 20px; color: #404040;">${activeContract.note!"some error"}</p>
            </div>

            <div style="padding: 0; display: inline-block; text-align: center; width: 50%;">
                <p style="font-size: 32px; color: black;">Осталось</p>
                <p style="font-size: 32px; color: red;">${rentalHours!"some error"} часов</p>
                <p style="font-size: 32px; color: black;">Состояние</p>
                <p style="font-size: 20px; color: #404040;">${activeContract.status!"some error"}</p>

                <div id="Finished" style="display: flex;">
                    <#if activeContract.getStatus() = "Действует">
                        <form action="/contract/finish" method="post" style="width: 100%;">
                            <button style="font-size: 25px; background: #46F046; margin-bottom: 10px; width: 100%; display: block" class="btn-canceled button" onclick="NotFinish()">
                                <input type="hidden" name="_csrf" value="<#if _csrf?has_content>${_csrf.token}</#if>">
                                <input type="hidden" name="id" value="${activeContract.getId()?c}">
                                Завершить
                            </button>
                        </form>
                    </#if>

                    <#if activeContract.getStatus() = "Не подтверждён">
                        <div id="Canceled" style="width: 90%; display: block;">
                            <form action="contract/cancel" method="post">
                                <input type="hidden" name="_csrf" value="<#if _csrf?has_content>${_csrf.token}</#if>">
                                <input type="hidden" name="id" value="${activeContract.getId()?c}">
                                <input type="submit" value="Отменить" class="btn-canceled button" style="width: 100%" />
                            </form>
                        </div>
                    </#if>
                </div>
            </div>

        </div>
            <div style="display: block; width: 100%;">
                <button style="font-size: 25px; padding: 0px; width: 100%;">
                    <a href="/contract/details?id=${activeContract.getId()?c}" style="width: 100%; display: block">Подробнее</a>
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
            <a data-toggle="tab" href="#CanceledContract" style="padding: 10px 5px 5px 5px;"><h4>Отменённые</h4></a>
        </li>
        <li>
            <a data-toggle="tab" href="#FinishedC" style="padding: 10px 5px 5px 5px;"><h4>Завершённые</h4></a>
        </li>
        <li>
            <a data-toggle="tab" href="#Fined" style="padding: 10px 5px 5px 5px;"><h4>Ожидают оплаты штрафа</h4></a>
        </li>

    </ul>

    <#if countPage != 0>
        <nav aria-label="...">
            <ul class="pagination">
                <li class="page-item">
                    <a class="page-link" href="/contract?page=1">Start</a>
                </li>
                <#list 1..countPage as page>
                    <li class="page-item" id="page_item_${page?c}">
                        <a class="page-link" id="button_${page?c}" href="/contract?page=${page?c}">${page?c}</a>
                    </li>
                </#list>
                <li class="page-item">
                    <a class="page-link" href="/contract?page=${countPage?c}">End</a>
                </li>
            </ul>
        </nav>
    </#if>

    <div class="tab-content" style="margin-bottom: 5%;">
        <div id="ALL" class="tab-pane fade in active">
            <br />

            <#if contracts?has_content>
                <#list contracts?sort_by("dateStart")?reverse as contract>
                    <div class="container body-content" style="display: flex; flex-direction: column; min-height: 100%; width: 100%;">

                        <div style="display: flex; background: rgba(40,40,40,0.15); width: 100%; height: 100%; border-radius: 15px; padding: 10px; margin-bottom: 10px;">
                            <div style="padding: 0; display: inline-block; width: 50%" id="Renta">
                                <a href="/car/details?id=${contract.car.id?c}" style="font-size: 32px; color: black; text-align: center;">Автомобиль</a>
                                <img src="/imageCar/${contract.car.image}" width="260" height="160" style="border-radius: 15px;">
                                <p style="font-size: 24px; color: black; font-weight: 600; text-align: center; margin-top: 5px;">${contract.car.brand} ${contract.car.model}</p>
                            </div>

                            <div style="padding: 0; display: inline-block; width: 50%; margin-left: 15px;">
                                <p style="font-size: 32px; color: black;">Дата получения</p>
                                <p style="font-size: 26px; color: #404040;">${(contract.dateStart).format('yyyy-MM-dd HH:mm:ss')}</p>
                                <p style="font-size: 32px; color: black;">Доп. опции</p>
                                <p style="font-size: 20px; color: #404040;">Видеорегистратор;<br> Автобокс; <br> Детское-кресло;3</p>
                            </div>

                            <div style="padding: 0; display: inline-block; width: 50%; margin-left: 15px;">
                                <p style="font-size: 32px; color: black;">Дата возврата</p>
                                <p style="font-size: 26px; color: #404040;">${(contract.dateEnd).format('yyyy-MM-dd HH:mm:ss')}</p>
                                <p style="font-size: 32px; color: black;">Примечания</p>
                                <p style="font-size: 20px; color: #404040;">Хочу автомобиль</p>
                                <p style="font-size: 32px; color: black;">Статус</p>
                                <p style="font-size: 26px; color: #404040;">${contract.status!"some error"}</p>
                            </div>

                            <div style="padding: 0; display: inline-block; text-align: center; width: 50%;">
                                <p style="font-size: 32px; color: black;">Цена</p>
                                <p style="font-size: 32px; color: red;">${contract.price!"some error"}</p>
                                <a href="/contract/details?id=${contract.getId()?c}" style="font-size: 25px; padding: 0px; width: 100%;">Подробнее</a>
                            </div>
                        </div>
                        <br />

                    </div>
                <#else >
                    <h1 style="text-align:center;">У вас ещё не было аренд!</h1>
                    <br />
                </#list>
            </#if>

        </div>

        <div id="CanceledContract" class="tab-pane fade in">
            <br />
            <#if canceledContracts?has_content>
                <#list canceledContracts?sort_by("dateStart")?reverse as contractCanceled>
                    <div class="container body-content" style="display: flex; flex-direction: column; min-height: 100%; width: 80%;">
                        <div style="display: flex; background: rgba(40,40,40,0.15); width: 100%; height: 100%; border-radius: 15px; padding: 10px; margin-bottom: 10px;">
                            <div style="padding: 0; display: inline-block; width: 50%" id="Renta">
                                <a class="AllCar" href="/car/details?id=${contractCanceled.getCar().getId()?c}">Автомобиль</a>
                                <p style="font-size: 24px; color: black;">${contractCanceled.getCar().getBrand()} ${contractCanceled.getCar().getModel()!""}</p>
                                <a href="/contract/details?id=${contractCanceled.getId()?c}" style="font-size: 25px; padding: 0; width: 100%;">Подробнее</a>
                            </div>

                            <div style="padding: 0; display: inline-block; text-align: center; width: 50%;">
                                <p style="font-size: 32px; color: black;">Дата получения</p>
                                <p style="font-size: 32px; color: #404040;">${(contractCanceled.dateStart).format('yyyy-MM-dd HH:mm:ss')}</p>
                            </div>

                            <div style="padding: 0; display: inline-block; text-align: center; width: 50%;">
                                <p style="font-size: 32px; color: black;">Дата возврата</p>
                                <p style="font-size: 32px; color: #404040;">${(contractCanceled.dateEnd).format('yyyy-MM-dd HH:mm:ss')}</p>
                            </div>

                            <div style="display: block; width: 50%;">
                                <p style="font-size: 32px; color: black;">Доп. опции</p>
                                <p style="font-size: 20px; color: #404040;">${contractCanceled.getAdditionalOptions()}</p>
                                <p style="font-size: 32px; color: black;">Примечания</p>
                                <p style="font-size: 20px; color: #404040;">${contractCanceled.getNote()}</p>
                            </div>

                            <div style="padding: 0; display: inline-block; text-align: center; width: 50%;">
                                <p style="font-size: 32px; color: black;">Цена</p>
                                <p style="font-size: 32px; color: red;">${contractCanceled.getPrice()?c}</p>
                                <p style="font-size: 32px; color: black;">Состояние</p>
                                <p style="font-size: 20px; color: #404040;">${contractCanceled.getStatus()}</p>
                            </div>
                        </div>
                        <br />

                    </div><!-- /End Section Container -->
                <#else >
                    <h1 style="text-align:center;">У вас ещё не было аренд!</h1>
                    <br />
                </#list>
            </#if>

        </div>

        <div id="FinishedC" class="tab-pane fade in">
            <br />
            <#if finishedContracts?has_content>
                <#list finishedContracts?sort_by("dateStart")?reverse as finishedContract>
                    <div class="container body-content" style="display: flex; flex-direction: column; min-height: 100%; width: 80%;">

                        <div style="display: flex; background: rgba(40,40,40,0.15); width: 100%; height: 100%; border-radius: 15px; padding: 10px; margin-bottom: 10px;">
                            <div style="padding: 0; display: inline-block; width: 50%" id="Renta">
                                <a class="AllCar" href="/car/details?id=${finishedContract.getCar().getId()?c}">Автомобиль</a>
                                <p style="font-size: 24px; color: black;">${finishedContract.getCar().getBrand()} ${finishedContract.getCar().getModel()!""}</p>
                                <a href="/contract/details?id=${finishedContract.getId()?c}" style="font-size: 25px; padding: 0px; width: 100%;">Подробнее</a>
                            </div>

                            <div style="padding: 0; display: inline-block; text-align: center; width: 50%;">
                                <p style="font-size: 32px; color: black;">Дата получения</p>
                                <p style="font-size: 32px; color: #404040;">${(finishedContract.dateStart).format('yyyy-MM-dd HH:mm:ss')}</p>
                            </div>

                            <div style="padding: 0; display: inline-block; text-align: center; width: 50%;">
                                <p style="font-size: 32px; color: black;">Дата возврата</p>
                                <p style="font-size: 32px; color: #404040;">${(finishedContract.dateStart).format('yyyy-MM-dd HH:mm:ss')}</p>
                            </div>

                            <div style="display: block; width: 50%;">
                                <p style="font-size: 32px; color: black;">Доп. опции</p>
                                <p style="font-size: 20px; color: #404040;">${finishedContract.getAdditionalOptions()}</p>
                                <p style="font-size: 32px; color: black;">Примечания</p>
                                <p style="font-size: 20px; color: #404040;">${finishedContract.getNote()}</p>
                            </div>

                            <div style="padding: 0; display: inline-block; text-align: center; width: 50%;">
                                <p style="font-size: 32px; color: black;">Цена</p>
                                <p style="font-size: 32px; color: red;">${finishedContract.getPrice()?c}</p>
                                <p style="font-size: 32px; color: black;">Состояние</p>
                                <p style="font-size: 20px; color: #404040;">${finishedContract.getStatus()}</p>
                            </div>
                        </div>
                        <br />

                    </div><!-- /End Section Container -->
                <#else >
                    <h1 style="text-align:center;">У вас ещё не было аренд!</h1>
                    <br />
                </#list>
            </#if>

        </div>

        <div id="Fined" class="tab-pane fade in">
            <br />
            <#if finedContracts?has_content>
                <#list finedContracts?sort_by("dateStart")?reverse as contractFinished>
                    <div class="container body-content" style="display: flex; flex-direction: column; min-height: 100%; width: 80%;">

                        <div style="display: flex; background: rgba(40,40,40,0.15); width: 100%; height: 100%; border-radius: 15px; padding: 10px; margin-bottom: 10px;">
                            <div style="padding: 0; display: inline-block; width: 50%" id="Renta">
                                <a class="AllCar" href="/car/details?id=${contractFinished.getCar().getId()?c}">Автомобиль</a>
                                <p style="font-size: 24px; color: black;">${contractFinished.getCar().getBrand()} ${contractFinished.getCar().getModel()!""}</p>
                                <a href="/contract/details?id=${contractFinished.getId()?c}" style="font-size: 25px; padding: 0px; width: 100%;">Подробнее</a>
                            </div>

                            <div style="padding: 0; display: inline-block; text-align: center; width: 50%;">
                                <p style="font-size: 32px; color: black;">Дата получения</p>
                                <p style="font-size: 32px; color: #404040;">${(contractFinished.dateStart).format('yyyy-MM-dd HH:mm:ss')}</p>
                            </div>

                            <div style="padding: 0; display: inline-block; text-align: center; width: 50%;">
                                <p style="font-size: 32px; color: black;">Дата возврата</p>
                                <p style="font-size: 32px; color: #404040;">${(contractFinished.dateStart).format('yyyy-MM-dd HH:mm:ss')}</p>
                            </div>

                            <div style="display: block; width: 50%;">
                                <p style="font-size: 32px; color: black;">Доп. опции</p>
                                <p style="font-size: 20px; color: #404040;">${contractFinished.getAdditionalOptions()}</p>
                                <p style="font-size: 32px; color: black;">Примечания</p>
                                <p style="font-size: 20px; color: #404040;">${contractFinished.getNote()}</p>
                            </div>

                            <div style="padding: 0; display: inline-block; text-align: center; width: 50%;">
                                <p style="font-size: 32px; color: black;">Цена</p>
                                <p style="font-size: 32px; color: red;">${contractFinished.getPrice()?c}</p>
                                <p style="font-size: 32px; color: black;">Состояние</p>
                                <p style="font-size: 20px; color: #404040;">${contractFinished.getStatus()}</p>
                            </div>
                        </div>
                        <br />

                    </div><!-- /End Section Container -->
                <#else >
                    <h1 style="text-align:center;">У вас ещё не было аренд!</h1>
                    <br />
                </#list>
            </#if>

        </div>
    </div>

    <script>
        // Получаем значение параметра "page" из URL
        const urlParamsContractsForClient = new URLSearchParams(window.location.search);
        const pageContractsForClient = urlParamsContractsForClient.get('page');

        // Находим кнопку с id, соответствующим значению page
        const button = document.getElementById('page_item_'+pageContractsForClient);

        // Если такая кнопка найдена, то эмулируем ее нажатие
        if (button) {
            button.classList.add("active");
        }
    </script>


    <br />

</div><!-- /End Section Container -->

</@c.page>