<#import "../parts/common.ftl" as c>
<#import "../parts/nav-bar.ftl" as nav_bar>
<#include "../parts/security.ftl">

<@c.page>

    <link href="/static/css/ContractDetails.css" rel="stylesheet" />

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

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
                        ${contract.getNote()!""}
                    </textarea>
                </div>

            </div>

            <div class="col-lg-2" style="background: #ffffff; border-radius: 15px; margin: 15px; width: 54%; height: 100%; align-content:center;">

                <img src="/imageCar/${contract.getCar().getImage()}" style="width: 100%; height:350px; border-radius: 15px" />
                <a class="AllCar" href="/car/details?id=${contract.getCar().getId()?c}">Автомобиль</a>
                <p style="font-size: 24px; color: black; width: 100%; text-align:left; margin: 0;">${contract.getCar().getBrand()} ${contract.getCar().getModel()}, ${contract.getCar().getYear()?c}</p>

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
                            <input type="hidden" name="_csrf" value="<#if _csrf?has_content>${_csrf.token}</#if>">
                            <input type="hidden" name="id" value="${contract.getId()?c}">

                            <button type="button" class="btn-canceled button" style="width: 100%"  data-toggle="modal" data-target="#reason_cancel">
                                Отменить
                            </button>

                            <!-- Modal -->
                            <div class="modal fade" id="reason_cancel" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                                <div class="modal-dialog modal-dialog-centered" role="document">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h3 class="modal-title" id="exampleModalLongTitle" style="text-align: center">Причина отмены заявки.</h3>
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>

                                        <div class="modal-body">
                                            <p style="text-align: center; font-size: 24px; font-weight: 600">Укажите причину отмены заявки:</p>
                                            <div class="modal-footer" style="width: 90%; text-align: inherit">
                                                <div class="form-check" onclick="otherReasonForClientHide()">
                                                    <input class="form-check-input" type="radio" name="reasonCancel" id="reasonCancelForClient1" value="Изменились планы" checked>
                                                    <label class="form-check-label" for="reasonCancelForClient1">
                                                        Изменились планы
                                                    </label>
                                                </div>
                                                <div class="form-check" onclick="otherReasonForClientHide()">
                                                    <input class="form-check-input" type="radio" name="reasonCancel" id="reasonCancelForClient2" value="Обнаружил несоответствия в информации об автомобиле или условиях аренды!">
                                                    <label class="form-check-label" for="reasonCancelForClient2">
                                                        Обнаружил несоответствия в информации об автомобиле или условиях аренды!
                                                    </label>
                                                </div>
                                                <div class="form-check" onclick="otherReasonForClientHide()">
                                                    <input class="form-check-input" type="radio" name="reasonCancel" id="reasonCancelForClient3" value="Возникли непредвиденные обстоятельства!">
                                                    <label class="form-check-label" for="reasonCancelForClient3">
                                                        Возникли непредвиденные обстоятельства!
                                                    </label>
                                                </div>
                                                <div class="form-check" onclick="otherReasonForClientShow()">
                                                    <input class="form-check-input" type="radio" name="reasonCancel" id="otherForClient" value="otherForClient">
                                                    <label class="form-check-label" for="otherForClient">
                                                        Другое
                                                    </label>
                                                </div>
                                            </div>

                                            <div id="otherReasonForClient" style="display: none;">
                                                <div class="form-group">
                                                    <label for="otherReasonForClientText">Укажите причину отмены:</label>
                                                    <input class="form-control" id="otherReasonForClientText" name="otherReasonCancel"/>
                                                </div>
                                            </div>

                                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Выйти</button>
                                            <button type="submit" class="btn btn-primary">Сохранить</button>
                                        </div>

                                        <script>
                                            function otherReasonForClientShow() {
                                                // При выборе радио-кнопки "Другое"
                                                $('#otherForClient').change(function() {
                                                    if ($(this).is(':checked')) {
                                                        $('#otherReasonForClient').show();
                                                    } else {
                                                        $('#otherReasonForClient').hide();
                                                    }
                                                });
                                            }
                                            function otherReasonForClientHide() {
                                                document.getElementById("otherReasonForClientText").value = null;
                                                $('#otherReasonForClient').hide();
                                            }
                                        </script>

                                    </div>
                                </div>
                            </div>

                        </form>
                    </#if>

                    <#if contract.getStatus() = "Действует">
                        <form action="finish" method="post">
                            <button style="font-size: 25px; background: #46F046; margin-bottom: 10px; width: 100%; display: block" class="btn-canceled button" onclick="NotFinish()">
                                <input type="hidden" name="_csrf" value="<#if _csrf?has_content>${_csrf.token}</#if>">
                                <input type="hidden" name="id" value="${contract.getId()?c}">
                                Завершить
                            </button>
                        </form>
                    </#if>
                </#if>

                <#if isAdmin || isManager>
                    <#if contract.getStatus() = "Не подтверждён">
                        <form action="confirm" method="post">
                            <input type="hidden" name="_csrf" value="<#if _csrf?has_content>${_csrf.token}</#if>">
                            <input type="hidden" name="id" value="${contract.getId()?c}">
                            <input type="submit" value="Подтвердить" class="btn-confirm button" style="width: 100%" />
                        </form>
                    </#if>

                    <#if contract.getStatus() = "Подтверждён">
                        <form action="start" method="post">
                            <input type="hidden" name="_csrf" value="<#if _csrf?has_content>${_csrf.token}</#if>">
                            <input type="hidden" name="id" value="${contract.getId()?c}">
                            <button style="font-size: 25px; background: #46F046; margin-bottom: 10px; width: 100%; display: block" class="btn-canceled button" onclick="NotFinish()">
                                Начать
                            </button>
                        </form>
                    </#if>

                    <#if contract.getStatus() = "Действует" || contract.getStatus() = "Ожидает оплаты штрафа">
                        <form action="finish" method="post">
                            <button style="font-size: 25px; background: #46F046; margin-bottom: 10px; width: 100%; display: block" class="btn-canceled button" onclick="NotFinish()">
                                <input type="hidden" name="_csrf" value="<#if _csrf?has_content>${_csrf.token}</#if>">
                                <input type="hidden" name="id" value="${contract.getId()?c}">
                                Завершить
                            </button>
                        </form>
                    </#if>

                    <#if contract.getStatus() = "Действует" || contract.getStatus() = "Завершён">
                        <form action="fine" method="post">
                            <button style="width: 100%;" class="btn-canceled button" onclick="NotFinish()">
                                <input type="hidden" name="_csrf" value="<#if _csrf?has_content>${_csrf.token}</#if>}">
                                <input type="hidden" name="id" value="${contract.getId()?c}">
                                Назначить штраф
                            </button>
                        </form>
                    </#if>

                    <#if contract.getStatus() != "Завершён" && contract.getStatus() != "Отменён"
                            && contract.getStatus() != "Ожидает оплаты штрафа" && contract.getStatus() != "Действует">
                        <form action="cancel" method="post">
                            <input type="hidden" name="_csrf" value="<#if _csrf?has_content>${_csrf.token}</#if>">
                            <input type="hidden" name="id" value="${contract.getId()?c}">

                            <button type="button" class="btn-canceled button" style="width: 100%"  data-toggle="modal" data-target="#reason_cancel">
                                Отменить
                            </button>

                            <!-- Modal -->
                            <div class="modal fade" id="reason_cancel" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                                <div class="modal-dialog modal-dialog-centered" role="document">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h3 class="modal-title" id="exampleModalLongTitle" style="text-align: center">Причина отмены заявки.</h3>
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>

                                        <div class="modal-body">
                                            <p style="text-align: center; font-size: 24px; font-weight: 600">Укажите причину отмены заявки:</p>
                                            <div class="modal-footer" style="width: 90%; text-align: inherit">
                                                <div class="form-check" onclick="otherReasonHide()">
                                                    <input class="form-check-input" type="radio" name="reasonCancel" id="exampleRadios1" value="Некорректные личные данные клиента!" checked>
                                                    <label class="form-check-label" for="exampleRadios1">
                                                        Некорректные личные данные клиента!
                                                    </label>
                                                </div>
                                                <div class="form-check" onclick="otherReasonHide()">
                                                    <input class="form-check-input" type="radio" name="reasonCancel" id="exampleRadios2" value="Невалидные данные доставки/получения автомобиля!">
                                                    <label class="form-check-label" for="exampleRadios2">
                                                        Невалидные данные доставки/получения автомобиля!
                                                    </label>
                                                </div>
                                                <div class="form-check" onclick="otherReasonHide()">
                                                    <input class="form-check-input" type="radio" name="reasonCancel" id="exampleRadios3" value="Ошибка со стороны компании!">
                                                    <label class="form-check-label" for="exampleRadios3">
                                                        Ошибка со стороны компании!
                                                    </label>
                                                </div>
                                                <div class="form-check" onclick="otherReasonShow()">
                                                    <input class="form-check-input" type="radio" name="reasonCancel" id="other" value="other">
                                                    <label class="form-check-label" for="other">
                                                        Другое
                                                    </label>
                                                </div>
                                            </div>

                                            <div id="otherReason" style="display: none;">
                                                <div class="form-group">
                                                    <label for="otherReasonText">Укажите причину отмены:</label>
                                                    <input class="form-control" id="otherReasonText" name="otherReasonCancel"></input>
                                                </div>
                                            </div>

                                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Выйти</button>
                                            <button type="submit" class="btn btn-primary">Сохранить</button>
                                        </div>

                                        <script>
                                            function otherReasonShow() {
                                                // При выборе радио-кнопки "Другое"
                                                $('#other').change(function() {
                                                    if ($(this).is(':checked')) {
                                                        $('#otherReason').show();
                                                    } else {
                                                        $('#otherReason').hide();
                                                    }
                                                });
                                            }
                                            function otherReasonHide() {
                                                document.getElementById("otherReasonText").value = null;
                                                $('#otherReason').hide();
                                            }
                                        </script>

                                    </div>
                                </div>
                            </div>

                        </form>
                    </#if>
                </#if>

            </div>
        </div>
        <!---->

        <br />

    </div>

</@c.page>