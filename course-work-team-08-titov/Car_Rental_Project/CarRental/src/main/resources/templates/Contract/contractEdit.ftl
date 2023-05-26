<#import "../parts/common.ftl" as c>
<#import "../parts/nav-bar.ftl" as nav_bar>
<#include "../parts/security.ftl">

<@c.page>

    <link href="/static/css/ContractDetails.css" rel="stylesheet" />
    <!---->
    <div class="container body-content" style="display: flex; flex-direction: column; min-height: 100%; width: 80%; margin-top: 5%;">

        <div class="container-fluid bloc" style="background: rgba(40,40,40, 0.15);width: 100%; height: 100%; border-radius: 15px">
            <form action="/contract/edit" method="post">
                <input type="hidden" name="_csrf" value="<#if _csrf?has_content>${_csrf.token}</#if>">
                <input type="hidden" name="id" value="${contract.getId()}">

                <div class="col-lg-2" style="background: #ffffff; border-radius: 15px; margin: 15px; width: 40%; height: 100%; align-content:center;">

                    <p style="font-size: 24px; color: black; width: 100%; text-align:center; margin: 0;">Получение</p>
                    <hr style="color: #5394FD; margin: 5px" />

                    <div style="width: 100%;">
                        <input class="input" type="text" value="${contract.getDateStart()}" readonly>
                    </div>

                    <p style="font-size: 24px; color: black; width: 100%; text-align:center; margin: 0;">Возврат</p>

                    <div>
                        <input class="input" type="text" value="${contract.getDateEnd()}" readonly>
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
                                <input class="input" type="text" value="${contract.getUser().getFio()}">
                            </div>
                            <div>
                                <input class="input" type="text" value="${contract.getUser().getBirthDate()!""}">
                            </div>
                            <div>
                                <input class="input" type="text" value="${contract.getUser().getEmail()}">
                            </div>
                            <div>
                                <input class="input" type="text" value="${contract.getUser().getDriverLicense()}">
                            </div>
                            <div>
                                <textarea class="input" style="text-align: left;resize: vertical;">
                                    ${contract.getUser().getAddress()}
                                </textarea>
                            </div>
                            <div>
                                <input class="input" type="text" value="${contract.getUser().getPhone()}">
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
                            <p style="color: rgba(40,40,40, 0.5); margin: 0; ">Автобокс </p>
                        </div>

                        <div style="padding: 0; display: inline-block; text-align: center; width: 50%;">
                            <p style="color: rgba(40,40,40, 0.5); margin: 0; ">нет</p>
                            <p style="color: rgba(40,40,40, 0.5); margin: 0;">1</p>
                            <p style="color: rgba(40,40,40, 0.5); margin: 0; ">1</p>
                        </div>
                    </div>

                    <div>
                        <textarea class="input" name="note" style="margin-top: 10px; height: 80px; font-size: 15px; resize: vertical;" required>
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
                        <input class="input" name="fioManager" type="text" value="${contract.getFioManager()!""}">
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

                </div>

                <button type="submit">Save</button>
            </form>
        </div>

    </div>

</@c.page>