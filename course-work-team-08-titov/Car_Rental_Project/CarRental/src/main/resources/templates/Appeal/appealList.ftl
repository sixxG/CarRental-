<#import "../parts/common.ftl" as c>
<#import "../parts/nav-bar.ftl" as nav_bar>
<#import "../parts/foother.ftl" as futher>
<#include "../parts/security.ftl">

<@c.page>

    <link rel="stylesheet" href="/static/css/Appeal.css">
    <!--Отзывы-->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css">
    <#--Delete icon-->
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <#--Delete icon-->
    <script src="/static/js/Appeal.js"></script>

    <div class="container body-content">

        <br />
        <ul class="nav nav-tabs" style="margin-top: 5%; margin-bottom: 2%;">
            <li style="width: 50%;">
                <a data-toggle="tab" href="#questions" style=" padding: 10px 5px 5px 5px;">
                    <p style="font-size: 24px; font-weight: 600; text-align: center;">Вопросы</p>
                </a>
            </li>
            <li  class="active" style="width: 50%;">
                <a data-toggle="tab" href="#appeals" style=" padding: 10px 5px 5px 5px;">
                    <p style="text-align: center;font-size: 24px; font-weight: 600;">Отзывы</p>
                </a>
            </li>
        </ul>

        <!--Block-->
        <div class="tab-content">
            <div id="questions" class="tab-pane fade in">

                <br/>
                <h2 style="text-align: center; font-weight: 600">Популярные вопросы</h2>
                <br/>

                <div class="questionBloc">
                    <div>
                        <p>
                            <a class="question" data-toggle="collapse" href="#collapseExample">
                                Каковы требования к возрасту водителя для аренды автомобиля?
                            </a>
                        </p>
                        <div class="collapse requestBody" id="collapseExample">
                            <div class="card card-body">
                                Ответ: Для аренды автомобиля водитель должен быть старше 21 года и иметь водительский стаж не менее двух лет.                            </div>
                        </div>
                    </div>
                    <div>
                        <p>
                            <a class="question" data-toggle="collapse" href="#collapseExample2">
                                Какова политика компании по топливу при аренде автомобиля?
                            </a>
                        </p>
                        <div class="collapse requestBody" id="collapseExample2">
                            <div class="card card-body">
                                Ответ: При аренде автомобиля, клиент должен вернуть его с тем же количеством топлива, что и при получении.
                                В противном случае, компания может взимать дополнительную плату за заправку.
                            </div>
                        </div>
                    </div>
                    <div>
                        <p>
                            <a class="question" data-toggle="collapse" href="#collapseExample3">
                                Могу ли я арендовать автомобиль на несколько дней или недель?
                            </a>
                        </p>
                        <div class="collapse requestBody" id="collapseExample3">
                            <div class="card card-body">
                                Ответ: Да, вы можете арендовать автомобиль на любой срок, начиная от одного дня до нескольких месяцев.                            </div>
                        </div>
                    </div>
                    <div>
                        <p>
                            <a class="question" data-toggle="collapse" href="#collapseExample4">
                                Какие дополнительные услуги доступны при аренде автомобиля?
                            </a>
                        </p>
                        <div class="collapse requestBody" id="collapseExample4">
                            <div class="card card-body">
                                Ответ: Дополнительные услуги включают в себя детское кресло,
                                GPS-навигацию и автобокс.
                            </div>
                        </div>
                    </div>
                    <div>
                        <p>
                            <a class="question" data-toggle="collapse" href="#collapseExample5">
                                Как я могу забронировать автомобиль?
                            </a>
                        </p>
                        <div class="collapse requestBody" id="collapseExample5">
                            <div class="card card-body">
                                Ответ: Вы можете забронировать автомобиль онлайн на сайте компании или позвонить в службу бронирования.                            </div>
                        </div>
                    </div>
                    <div>
                        <p>
                            <a class="question" data-toggle="collapse" href="#collapseExample6">
                                Какова политика отмены бронирования?
                            </a>
                        </p>
                        <div class="collapse requestBody" id="collapseExample6">
                            <div class="card card-body">
                                Ответ: Политика отмены бронирования зависит от компании,
                                но обычно существуют штрафы за отмену бронирования в зависимости от времени отмены.
                            </div>
                        </div>
                    </div>
                    <div>
                        <p>
                            <a class="question" data-toggle="collapse" href="#collapseExample7">
                                Как я могу получить дополнительное оборудование для автомобиля?
                            </a>
                        </p>
                        <div class="collapse requestBody" id="collapseExample7">
                            <div class="card card-body">
                                Ответ: Вы можете выбрать дополнительное оборудование при бронировании автомобиля.
                                Если вы уже забронировали автомобиль и хотите добавить дополнительное оборудование,
                                пожалуйста, свяжитесь с нашим отделом обслуживания клиентов.
                            </div>
                        </div>
                    </div>
                    <div>
                        <p>
                            <a class="question" data-toggle="collapse" href="#collapseExample8">
                                Как я могу вернуть автомобиль после окончания аренды?
                            </a>
                        </p>
                        <div class="collapse requestBody" id="collapseExample8">
                            <div class="card card-body">
                                Ответ: Вы можете вернуть автомобиль в любом из наших офисов.
                                Пожалуйста, убедитесь, что автомобиль возвращается в том же состоянии,
                                что и при получении, и что все документы и ключи возвращаются вместе с автомобилем.                            </div>
                        </div>
                    </div>
                    <div>
                        <p>
                            <a class="question" data-toggle="collapse" href="#collapseExample9">
                                Что происходит, если я опоздаю на получение автомобиля?
                            </a>
                        </p>
                        <div class="collapse requestBody" id="collapseExample9">
                            <div class="card card-body">
                                Ответ: Пожалуйста, уведомите наш отдел обслуживания клиентов, если вы опаздываете на получение автомобиля.
                                Мы постараемся удовлетворить ваши потребности и предоставить вам автомобиль в соответствии с новым
                                временем получения. Однако, если вы не уведомите нас о задержке, мы можем отменить вашу бронь.                            </div>
                        </div>
                    </div>
                    <div>
                        <p>
                            <a class="question" data-toggle="collapse" href="#collapseExample10">
                                Какие документы мне нужно предоставить при аренде автомобиля?
                            </a>
                        </p>
                        <div class="collapse requestBody" id="collapseExample10">
                            <div class="card card-body">
                                Ответ: Для аренды автомобиля вам понадобятся водительские права, паспорт и кредитная карта, на которой
                                будет заблокирована определенная сумма в качестве залога.
                            </div>
                        </div>
                    </div>
                </div>
                <br />

            </div>
            <div id="appeals" class="tab-pane fade in active">
                <!-- Appeal form -->
                <#if user?? && isFeedbackExist>
                    <div>
                        <p>
                            <a class="question" style="text-align: center; text-decoration: none" data-toggle="collapse" href="#makeFeddback">
                                Оставить отзыв
                            </a>
                        </p>
                        <div class="collapse" id="makeFeddback">
                            <div>
                                <div class="questionBloc" style="width: 30%; display: flex; margin: 0 auto">
                                    <form action="/feedback" method="post" style="padding: 10px;">

                                        <input type="hidden" name="_csrf" value="<#if _csrf?has_content>${_csrf.token}</#if>"/>

                                        <div class="mb-3 row">
                                            <label for="staticEmail" class="col-form-label" style="text-align: center; width: 100%;">Выберите количество звезд:</label>
                                            <div class="col-sm-10 stars" id="staticEmail" style="width: 100%; display: flex; margin: 0 auto; justify-content: center">
                                                <span class="star" data-value="1">&#9733;</span>
                                                <span class="star" data-value="2">&#9733;</span>
                                                <span class="star" data-value="3">&#9733;</span>
                                                <span class="star" data-value="4">&#9733;</span>
                                                <span class="star" data-value="5">&#9733;</span>
                                            </div>
                                            <input type="hidden" id="stars-value" name="score" value="0" required="required"/>
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
                                                <textarea name="AppealBody" class="form-control"  id="AppealBody" style="width: 100%; resize: vertical" required="required"></textarea>
                                            </div>
                                        </div>

                                        <div class="mb-3 row" style="width: 100%; text-align: center">
                                            <label for="anonymous" class="col-form-label">Анонимный отзыв:</label>
                                            <input type="checkbox" id="anonymous" name="anonymous" onchange="validate()"/>
                                            <input type="hidden" id="chekAnonymous" name="chekAnonymous" value=""/>
                                        </div>
                                        <input type="submit" value="Отправить" onclick="validate()" style="width: 100%;font-size: 20px; background: #46F046; padding: 5px; border-radius: 15px; border: 2px solid #46F046"/>

                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                    <br/>
                </#if>

                <!-- Appeal form -->

                <div class="koguvcavis-varazdel">
                    <div class="sestim-donials">
                        <h1>Отзывы</h1>

                        <#if isAdmin || isManager>
                            <h4 style="display: inline-block;">Кол-во отзывов: ${countFeedbacks}</h4>
                            <h4 style="display: inline-block; margin-left: 10px; color: green">Процент положительных: ${percentPositive}%</h4>
                            <h4 style="display: inline-block; margin-left: 10px; color: red">Процент отрицательных: ${percentNegative}%</h4>
                        </#if>

                        <div class="sectionesag"></div>
                        <div style="display: block; width: 100%; text-align: center; padding: 15px;">
                            <a href="/appeal?numberPage=0" id="allFeedback" class="appealSortedBy">Все отзывы</a>
                            <a href="/appeal/bydate?numberPage=0" id="byDate" class="appealSortedBy">Сортировать по дате публикации</a>
                            <a href="/appeal/byscore?numberPage=0&revert=no" id="revertNO" class="appealSortedBy">Сортировать по оценке по возрастанию</a>
                            <a href="/appeal/byscore?numberPage=0&revert=yes" id="revertYES"  class="appealSortedBy">Сортировать по оценке по убыванию</a>
                        </div>

                        <script>
                            //активный тип сортировки
                            const isrevertURL = new URLSearchParams(window.location.search);
                            const urlParamsAppeal = document.location.pathname;

                            const isRevert = isrevertURL.get('revert');
                            const isSorted = isrevertURL.get('numberPage');
                            const isByDate = urlParamsAppeal.search('/bydate') !== -1;

                            if (isByDate) {
                                document.getElementById("revertYES").classList.remove("appealSortedByActive");
                                document.getElementById("revertNO").classList.remove("appealSortedByActive");
                                document.getElementById("byDate").classList.add("appealSortedByActive");
                            } else if (isSorted !== null && isRevert === null) {
                                document.getElementById("revertYES").classList.remove("appealSortedByActive");
                                document.getElementById("revertNO").classList.remove("appealSortedByActive");
                                document.getElementById("byDate").classList.remove("appealSortedByActive");
                                document.getElementById("allFeedback").classList.add("appealSortedByActive");
                            }
                            else if(isRevert === "yes") {
                                document.getElementById("revertNO").classList.remove("appealSortedByActive");
                                document.getElementById("revertYES").classList.add("appealSortedByActive");
                            } else if(isRevert === "no") {
                                document.getElementById("revertYES").classList.remove("appealSortedByActive");
                                document.getElementById("revertNO").classList.add("appealSortedByActive");
                            }
                        </script>

                        <div class="sagestim-lonials">

                            <#list feedbacks as feedback>
                                <div class="vemotau-vokusipol" data-id="feedback_${feedback.id}">
                                    <div class="testimonial">
                                        <#if feedback.author = "Анонимный пользователь">
                                            <img src="https://avatars.mds.yandex.net/i?id=e2a359ae13e92835fdc492a249a50c30683f7429-8485986-images-thumbs&n=13" alt="">
                                            <#else >
                                                <img src="https://w7.pngwing.com/pngs/450/483/png-transparent-customer-service-customer-relationship-management-consumer-customer-face-service-people.png" alt="">
                                        </#if>
                                        <div class="gecedanam">${feedback.author}</div>
                                        <div class="apogered-gselected">
                                            <#assign x=feedback.score>

                                            <#if x==0>
                                                <#list 1..5 as i>
                                                    <i class="far fa-star"></i>
                                                </#list>
                                                <#else >
                                                    <#list 1..x as i>
                                                        <i class="fas fa-star"></i>
                                                    </#list>
                                                    <#assign y = 5-feedback.score>
                                                    <#if y!=0>
                                                        <#list 1..y as i>
                                                            <i class="far fa-star"></i>
                                                        </#list>
                                                    </#if>
                                            </#if>

                                        </div>
                                        <p>${feedback.body}</p>
                                        <p>${feedback.date?string("dd MMMM yyyy")}</p>

                                        <#if isAdmin>
                                            <form action="/appeal/delete?id=${feedback.id}" method="post">

                                                <input type="hidden" name="_csrf" value="<#if _csrf?has_content>${_csrf.token}</#if>"/>

                                                <button type="submit" style="border: 0px; align-items: center; padding: 5px;">
                                                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi bi-trash" viewBox="0 0 16 16">
                                                        <path d="M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0V6z"/>
                                                        <path fill-rule="evenodd" d="M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1v1zM4.118 4 4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4H4.118zM2.5 3V2h11v1h-11z"/>
                                                    </svg>
                                                </button>

                                            </form>
                                        </#if>
                                    </div>
                                </div>

                                <#else >
                                <h1 style="display: block; width: 100%; text-align: center">
                                    Отзывов пока нет!<br/>
                                    Будьте первым, кто оценит услуги нашей компании!
                                </h1>

                            </#list>

                        </div>

                    </div>
                </div>


                <#-- Number pages -->
                <script>
                    const path = urlParamsAppeal.toString();
                    const appealParams = window.location.search;
                    console.log("path: " + path);
                    console.log("params: " + appealParams);
                    let firstParam = appealParams.split("&");
                    console.log(firstParam);
                    if (firstParam.length > 1) {
                        firstParam = firstParam.at(1);
                        //firstParam = firstParam.slice(1, firstParam.length);
                    } else {
                        firstParam = firstParam.at(0);
                        firstParam = firstParam.slice(1, firstParam.length);
                    }
                    console.log("firstParam: " + firstParam);

                    function changeHref(id) {
                        const previouslyHref = document.getElementById(id).getAttribute("href");
                        let currentPath = "/";
                        if (firstParam != null && !firstParam.includes("numberPage")) {
                            currentPath = path + previouslyHref + "&" + firstParam;
                        } else {
                            currentPath = path + previouslyHref;
                        }
                        document.getElementById(id).setAttribute("href", currentPath)
                        console.log("result path: " + currentPath);
                    }
                </script>
                <#if (countPage > 0)>
                    <div style="width: 100%; align-items: center;">

                        <ul class="pagination" style="position: absolute; left: 45%">
                            <#list 1..countPage as page>
                                <li  id="page_${page-1}">
                                <a href="?numberPage=${page-1}" id="a_${page}">${page}</a>
                                    <script>
                                        changeHref("a_${page}");
                                    </script>
                            </li>
                            </#list>
                        </ul>

                        <br />
                        <br />
                        <br />
                    </div>
                </#if>
                <#-- Number pages -->

                <script>
                    //активная страница с отзывами
                    const urlParam = new URLSearchParams(window.location.search);

                    console.log(urlParam);

                    const numberPage = urlParam.get('numberPage');
                    document.getElementById("page_" + numberPage).classList.add("active");
                </script>
                <!--Block-->

            </div>
        </div>
        <!-- /End Section Container -->
    </div>

    <@futher.foother></@futher.foother>


</@c.page>