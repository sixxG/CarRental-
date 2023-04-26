<#import "../parts/common.ftl" as c>
<#import "../parts/nav-bar.ftl" as nav_bar>
<#include "../parts/security.ftl">

<@c.page>

    <link href="/static/css/ContractDetails.css" rel="stylesheet" />

    <div class="container body-content" style="display: flex; flex-direction: column; min-height: 100%; width: 80%;">


        <div style="text-align: center; width: 100%; margin-top: 6%;">
            <#if isUser>
                <a class="AllCar" href="/contract?page=1">к списку</a>
                <#else >
                    <a class="AllCar" href="/contract/list/all?page=1">к списку</a>
            </#if>
        </div>

        <!---->
        <div class="container-fluid bloc" style="background: rgba(40,40,40, 0.15);width: 100%; height: 100%; border-radius: 15px">
            <div class="col-lg-2" style="background: #ffffff; border-radius: 15px; margin: 15px; width: 40%; height: 100%; align-content:center;">

                <div>
                    <p style="font-size: 24px; color: black; width: 100%; text-align:center; margin: 0;">Получение</p>
                    <hr style="color: #5394FD; margin: 5px" />

                    <div style="width: 100%;">
                        <input class="input" type="text" value="${contract.getDateStart()}" readonly>
                    </div>

                    <p style="font-size: 16px; color: black; width: 100%; text-align:left; margin: 0;">Место получения</p>
                    <div style="width: 100%;">
                        <input class="input" type="text" value="${contract.typeReceipt}" readonly>
                    </div>
                    <#if contract.typeReceipt = "Офис">
                        <a href="https://yandex.ru/maps/?text=Владимир, Проспект Строителей 7Б, стр. 14" target="_blank" class="toMapLink">Показать на карте</a>
                    <#elseif contract.typeReceipt = "Автовокзал">
                        <a href="https://yandex.ru/maps/?text=Владимирский автовокзал" target="_blank" class="toMapLink">Показать на карте</a>
                    <#else>
                        <a href="https://yandex.ru/maps/?text=Владимир, ${contract.typeReceipt}" target="_blank" class="toMapLink">Показать на карте</a>
                    </#if>
                    <hr style="color: #5394FD; margin: 5px" />
                </div>

                <div>
                    <p style="font-size: 24px; color: black; width: 100%; text-align:center; margin: 0;">Возврат</p>

                    <div>
                        <input class="input" type="text" value="${contract.getDateEnd()}" readonly>
                    </div>

                    <p style="font-size: 16px; color: black; width: 100%; text-align:left; margin: 0;">Место возврата</p>
                    <div style="width: 100%;">
                        <input class="input" type="text" value="${contract.typeReturn}" readonly>
                    </div>
                    <#if contract.typeReturn = "Офис">
                        <a href="https://yandex.ru/maps/?text=Владимир, Проспект Строителей 7Б, стр. 14" target="_blank" class="toMapLink">Показать на карте</a>
                        <#elseif contract.typeReturn = "Автовокзал">
                            <a href="https://yandex.ru/maps/?text=Владимирский автовокзал" target="_blank" class="toMapLink">Показать на карте</a>
                        <#else>
                        <a href="https://yandex.ru/maps/?text=Владимир, ${contract.typeReturn}" target="_blank" class="toMapLink">Показать на карте</a>
                    </#if>
                    <hr style="color: #5394FD; margin: 5px" />
                </div>

                <p style="font-size: 24px; color: black; width: 100%; text-align:center; margin: 0;">Данные клиента</p>
                <hr style="color: #5394FD; margin: 5px" />
                <!---->
                <div style="display: flex;">
                    <div style="padding: 0; display: inline-block; width: 35%; height: 100%">
                        <label style="display:block; margin-bottom: 22px; margin-top: 5px;">ФИО</label>
                        <label style="display: block; margin-bottom: 22px">Дата рождения</label>
                        <label style="display: block; margin-bottom: 22px">Email</label>
                        <label style="display: block; margin-bottom: 22px">Номер ВУ</label>
                        <label style="display: block; margin-bottom: 22px">Адрес</label>
                        <label style="display: block; margin-bottom: 22px">Телефон</label>
                    </div>

                    <div style="padding: 0; display: inline-block; text-align: center; width: 75%;">
                        <div>
                            <input class="input" type="text" value="${contract.getUser().getFio()}" readonly>
                        </div>
                        <div>
                            <input class="input" type="text" value="${contract.getUser().getBirthDate()!""}" readonly>
                        </div>
                        <div>
                            <input class="input" type="text" value="${contract.getUser().getEmail()}" readonly>
                        </div>
                        <div>
                            <input class="input" type="text" value="${contract.getUser().getDriverLicense()}" readonly>
                        </div>
                        <div>
                            <textarea class="input" style="text-align: left;resize: vertical;" readonly>
                                ${contract.getUser().getAddress()}
                            </textarea>
                        </div>
                        <div>
                            <input class="input" type="text" value="${contract.getUser().getPhone()}" readonly>
                        </div>
                    </div>
                </div>
                <!---->

                <p style="font-size: 24px; color: black; width: 100%; text-align:center; margin: 0;">Дополнительные опции</p>
                <hr style="color: #5394FD; margin: 5px" />


                <div style="display: flex;">
                    <div style="padding: 0; display: inline-block; width: 50%">
                        <p style="color: rgba(40,40,40, 0.5); margin: 0;">Детское кресло </p>
                        <p style="color: rgba(40,40,40, 0.5); margin: 0; ">Видеорегистратор </p>
                        <p style="color: rgba(40,40,40, 0.5); margin: 0; ">Авто бокс </p>
                    </div>

                    <div style="padding: 0; display: inline-block; text-align: center; width: 50%;">
                        <p style="color: rgba(40,40,40, 0.5); margin: 0; ">${countKidChes}</p>
                        <p style="color: rgba(40,40,40, 0.5); margin: 0;">${countVideoReg}</p>
                        <p style="color: rgba(40,40,40, 0.5); margin: 0; ">${countCarBox}</p>
                    </div>
                </div>

                <div>
                    <textarea class="input" style="margin-top: 10px; height: 80px; font-size: 15px; text-align:inherit; resize: vertical;" readonly>
                        ${contract.getNote()}
                    </textarea>
                </div>

            </div>

            <div class="col-lg-2" style="background: #ffffff; border-radius: 15px; margin: 15px; width: 54%; height: 100%; align-content:center;">

                <img src="/imageCar/${contract.getCar().getImage()}" style="width: 100%; height:350px; border-radius: 15px" />
                <a class="AllCar" href="/car/details?id=${contract.getCar().getId()}">Автомобиль</a>
                <p style="font-size: 24px; color: black; width: 100%; text-align:left; margin: 0;">${contract.getCar().getBrand()} ${contract.getCar().getModel()}, ${contract.getCar().getYear()}</p>

                <hr style="color: #5394FD; margin: 5px" />

                <p style="font-size: 24px; color: black; width: 100%; text-align:left; margin: 0;">WIN</p>
                <p style="font-size: 16px; color: black; width: 100%; text-align:left; margin: 0;">${contract.getCar().getWIN_Number()}</p>

                <p style="font-size: 24px; color: black; width: 100%; text-align:center; margin: 0;">Данные менеджера</p>

                <div style="width: 100%;">
                    <input class="input" type="text" value="${contract.getFioManager()!""}" readonly>
                </div>

                <p style="font-size: 24px; color: black; width: 100%; text-align:center; margin: 0;">Стоимость</p>
                <hr style="color: #5394FD; margin: 5px" />


                <div style="display: flex;">
                    <div style="padding: 0; display: inline-block; width: 50%">
                        <p style="font-size: 16px; color: black; margin: 0; text-align:left;">Аренда на ${timeRent} дней</p>
                        <p style="color: rgba(40,40,40, 0.5); margin: 0; ">${dayStart} - ${dayEnd}</p>
                    </div>

                    <div style="padding: 0; display: inline-block; text-align: center; width: 50%;">
                        <p style="color: rgba(40,40,40, 0.5); margin: 0; font-size: 22px">${contract.getPrice()?c} <b style="color: black">₽</b></p>

                    </div>
                </div>

                <hr style="color: #5394FD; margin: 5px" />

                <#if isUser>
                    <#if contract.getStatus() = "Не подтверждён">
                        <form action="cancel" method="post">
                            <input type="hidden" name="_csrf" value="${_csrf.token}">
                            <input type="hidden" name="id" value="${contract.getId()}">
                            <input type="submit" value="Отменить" class="btn-canceled button" style="width: 100%" />
                        </form>
                    </#if>

                    <#if contract.getStatus() = "Действует">
                        <form action="finish" method="post">
                            <button style="font-size: 25px; background: #46F046; margin-bottom: 10px; width: 100%; display: block" class="btn-canceled button" onclick="NotFinish()">
                                <input type="hidden" name="_csrf" value="${_csrf.token}">
                                <input type="hidden" name="id" value="${contract.getId()}">
                                Завершить
                            </button>
                        </form>
                    </#if>
                </#if>

                <#if isAdmin || isManager>
                    <#if contract.getStatus() = "Не подтверждён">
                        <form action="confirm" method="post">
                            <input type="hidden" name="_csrf" value="${_csrf.token}">
                            <input type="hidden" name="id" value="${contract.getId()}">
                            <input type="submit" value="Подтвердить" class="btn-confirm button" style="width: 100%" />
                        </form>
                    </#if>

                    <#if contract.getStatus() = "Подтверждён">
                        <form action="start" method="post">
                            <input type="hidden" name="_csrf" value="${_csrf.token}">
                            <input type="hidden" name="id" value="${contract.getId()}">
                            <button style="font-size: 25px; background: #46F046; margin-bottom: 10px; width: 100%; display: block" class="btn-canceled button" onclick="NotFinish()">
                                Начать
                            </button>
                        </form>
                    </#if>

                    <#if contract.getStatus() = "Действует" || contract.getStatus() = "Ожидает оплаты штрафа">
                        <form action="finish" method="post">
                            <button style="font-size: 25px; background: #46F046; margin-bottom: 10px; width: 100%; display: block" class="btn-canceled button" onclick="NotFinish()">
                                <input type="hidden" name="_csrf" value="${_csrf.token}">
                                <input type="hidden" name="id" value="${contract.getId()}">
                                Завершить
                            </button>
                        </form>
                    </#if>

                    <#if contract.getStatus() = "Действует" || contract.getStatus() = "Завершён">
                        <form action="fine" method="post">
                            <button style="width: 100%;" class="btn-canceled button" onclick="NotFinish()">
                                <input type="hidden" name="_csrf" value="${_csrf.token}">
                                <input type="hidden" name="id" value="${contract.getId()}">
                                Назначить штраф
                            </button>
                        </form>
                    </#if>

                    <#if contract.getStatus() != "Завершён" && contract.getStatus() != "Отменён"
                            && contract.getStatus() != "Ожидает оплаты штрафа" && contract.getStatus() != "Действует">
                        <form action="cancel" method="post">
                            <input type="hidden" name="_csrf" value="${_csrf.token}">
                            <input type="hidden" name="id" value="${contract.getId()}">
                            <input type="submit" value="Отменить" class="btn-canceled button" style="width: 100%" />
                        </form>
                    </#if>
                </#if>

            </div>
        </div>
        <!---->

        <br />

    </div>

</@c.page>