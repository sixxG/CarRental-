<#import "../parts/common.ftl" as c>
<#include "../parts/security.ftl">

<@c.page>

    <link rel="stylesheet" href="/static/css/Appeal.css">
    <!--Отзывы-->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css">
    <#--Delete icon-->
<#--    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">-->
    <#--Delete icon-->

    <script src="/static/js/Appeal.js"></script>

    <div style="width: 90%; display: block; margin: 0 auto">
        <h2 style="margin-top: 5%;">Личные данные.</h2>

        <p class="text-success"></p>
        <div>
            <div class="col-lg-8">

                <div class="container body-content" style="display: flex; flex-direction: column; min-height: 100%; width: 80%;">

                    <!--"Edit", "Customer", FormMethod.Post, new { enctype = "multipart/form-data", data_restUrl = Url.Action("Edit", "Customer", new { id = Model.Id }) })-->
                    <form action="/account" method="post">

                        <input type="hidden" value="<#if _csrf?has_content>${_csrf.token}</#if>" name="_csrf"/>
                        <input type="hidden" value="${client.getId()}" name="userId"/>

                        <div class="form-horizontal">
                            <h4>Ваши данные</h4>
                            <hr />

                            <div class="form-group">
                                <label class="control-label col-md-2" for="fio">ФИО</label>
                                <div class="col-md-10">
                                    <input class="form-control text-box single-line" name="fio" type="text" value="${client.fio!""}" required/></div>
                            </div>

                            <div class="form-group">
                                <label class="control-label col-md-2" for="birthDate">Дата рождения</label>
                                <div class="col-md-10">
                                    <input class="form-control text-box single-line" name="birthDate" type="date" value="${client.birthDate!""}" required/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="control-label col-md-2" for="email">Email</label>
                                <div class="col-md-10">
                                    <input class="form-control text-box single-line" name="email" type="text" value="${client.email!""}" required/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="control-label col-md-2" for="address">Адресс</label>
                                <div class="col-md-10">
                                    <input class="form-control text-box single-line" name="address" type="text" value="${client.address!""}" required/>
                                </div>
                            </div>



                            <div class="form-group">
                                <label class="control-label col-md-2" for="phone">Телефон</label>
                                <div class="col-md-10">
                                    <input class="form-control text-box single-line" name="phone" type="text" value="${client.phone!""}" required/>
                                </div>
                            </div>

                            <#if isUser>
                                <div class="form-group">
                                    <label class="control-label col-md-2" for="fio">Водительское удостоверение</label>
                                    <div class="col-md-10">
                                        <input class="form-control text-box single-line" name="driverLicense" type="text" value="${client.driverLicense!""}" required/></div>
                                </div>
                            </#if>

                            <div class="form-group">
                                <div class="col-md-offset-2 col-md-10">
                                    <input type="submit" value="Save" class="btn btn-default" />
                                </div>
                            </div>
                        </div>
                    </form>

                    <br />

                </div><!-- /End Section Container -->

            </div>

            <div class="col-lg-4">
                <h4>Изменение параметров учетной записи</h4>
                <hr />
                <dl class="dl-horizontal">
                    <dt>Пароль:</dt>
                    <dd>
                        [
                        <a href="/account/change_password">Смена пароля</a>                ]
                    </dd>

                </dl>
            </div>

            <div class="col-lg-4">
                <h4>Мой отзыв</h4>
                <hr />
                <dl class="dl-horizontal">
                    <#if usersFeedback??>
                        <div class="vemotau-vokusipol" style="max-width: 100%;">
                            <div class="testimonial" style="text-align: center">
                                <img src="https://w7.pngwing.com/pngs/450/483/png-transparent-customer-service-customer-relationship-management-consumer-customer-face-service-people.png" alt="">
                                <div class="gecedanam">${usersFeedback.author}</div>
                                <div class="apogered-gselected">
                                    <#assign x=usersFeedback.score>

                                    <#if x==0>
                                        <#list 1..5 as i>
                                            <i class="far fa-star"></i>
                                        </#list>
                                    <#else >
                                        <#list 1..x as i>
                                            <i class="fas fa-star"></i>
                                        </#list>
                                        <#assign y = 5-usersFeedback.score>
                                        <#if y!=0>
                                            <#list 1..y as i>
                                                <i class="far fa-star"></i>
                                            </#list>
                                        </#if>
                                    </#if>

                                </div>
                                <p>${usersFeedback.body}</p>
                                <p>${usersFeedback.date?string("dd MMMM yyyy")}</p>

                                <div style="display: flex; width: 100%; justify-content: center">
                                    <form action="/appeal/delete?id=${usersFeedback.id}" method="post">

                                        <input type="hidden" name="_csrf" value="<#if _csrf?has_content>${_csrf.token}</#if>">

                                        <button type="submit" style="border: 0px; align-items: center; padding: 5px;">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi bi-trash" viewBox="0 0 16 16">
                                                <path d="M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0V6z"/>
                                                <path fill-rule="evenodd" d="M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1v1zM4.118 4 4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4H4.118zM2.5 3V2h11v1h-11z"/>
                                            </svg>
                                        </button>

                                    </form>

                                    <div style="padding: 0 0 0 15px;">
                                        <input type="hidden" name="_csrf" value="<#if _csrf?has_content>${_csrf.token}</#if>">

                                        <!-- Button trigger modal -->

                                        <span style="color: red">${message!''}</span>

                                        <button type="button" data-toggle="modal" data-target="#exampleModalCenter" style="border: 0px; align-items: center; padding: 5px; height: 40px" class="bi-edit">
                                            <i class="fas fa-edit" style="font-size: 24px"></i>
                                        </button>

                                        <#--Edit popup-->
                                        <div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                                            <div class="modal-dialog modal-dialog-centered" role="document">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h3 class="modal-title" id="exampleModalLongTitle">Изменить отзыв</h3>
                                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                            <span aria-hidden="true">&times;</span>
                                                        </button>
                                                    </div>
                                                    <div class="modal-body">
                                                        <form action="/feedback/edit?id=${usersFeedback.getId()}" method="post" style="padding: 10px;">

                                                            <input type="hidden" name="_csrf" value="<#if _csrf?has_content>${_csrf.token}</#if>">

                                                            <div class="mb-3 row">
                                                                <label for="staticEmail" class="col-form-label" style="text-align: center; width: 100%;">Выберите количество звезд:</label>
                                                                <div class="col-sm-10 stars" id="staticEmail" style="width: 100%; display: flex; margin: 0 auto; justify-content: center">
                                                                    <span class="star" data-value="1">&#9733;</span>
                                                                    <span class="star" data-value="2">&#9733;</span>
                                                                    <span class="star" data-value="3">&#9733;</span>
                                                                    <span class="star" data-value="4">&#9733;</span>
                                                                    <span class="star" data-value="5">&#9733;</span>
                                                                </div>
                                                                <input type="hidden" id="stars-value" name="score" value="0">
                                                            </div>

                                                            <script>
                                                                //выбор звёзд
                                                                const stars = document.querySelectorAll('.star');

                                                                stars.forEach(star => {
                                                                    star.addEventListener('click', () => {
                                                                        const value = star.getAttribute('data-value');
                                                                        const starsValue = document.getElementById('stars-value');
                                                                        starsValue.value = value;

                                                                        // Выделяем выбранные звезды
                                                                        stars.forEach(s => {
                                                                            if (s.getAttribute('data-value') <= value) {
                                                                                s.classList.add('selected');
                                                                            } else {
                                                                                s.classList.remove('selected');
                                                                            }
                                                                        });
                                                                    });
                                                                });
                                                            </script>

                                                            <div class="mb-3 row">
                                                                <label for="AppealBody" class="col-form-label" style="width: 100%; text-align: center">Оставьте свой отзыв:</label>
                                                                <div class="col-sm-10"  style="width: 100%;">
                                                                    <textarea name="AppealBody" class="form-control"  id="AppealBody" style="width: 100%; resize: vertical; text-align: center">${usersFeedback.getBody()}</textarea>
                                                                </div>
                                                            </div>

                                                            <div class="mb-3 row" style="width: 100%; text-align: center">
                                                                <label for="anonymous" class="col-form-label">Анонимный отзыв:</label>
                                                                <input type="checkbox" id="anonymous" name="anonymous" onclick="validate()">
                                                                <input type="hidden" id="chekAnonymous" name="chekAnonymous" value="">
                                                            </div>

                                                            <div class="modal-footer">
                                                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Закрыть</button>
                                                                <button type="submit" class="btn btn-primary" onclick="validate()">Сохранить</button>
                                                            </div>
                                                        </form>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <#--Edit popup-->

                                    </div>
                                </div>

                            </div>
                        </div>
                        <#else >
                            <dd>Вы пока не оставили отзыв о нашей компании!</dd>
                    </#if>

                </dl>
            </div>
        </div>
    </div>

</@c.page>
