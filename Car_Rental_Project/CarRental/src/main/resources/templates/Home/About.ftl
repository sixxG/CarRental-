<#import "../parts/common.ftl" as c>
<#import "../parts/nav-bar.ftl" as nav_bar>
<#import "../parts/foother.ftl" as futher>
<#import "../parts/car.ftl" as carParts>

<@c.page>

    <link href="/static/css/About.css" rel="stylesheet" />

    <div class="container body-content" style="display: flex; flex-direction: column; min-height: 100%; width: 80%;">

        <!-- section info -->
        <section class="section section-info" style="margin-top: 5%; width: 100%;">

            <h1 class="RentalIF">Условия аренды</h1>

            <div class="info">

                <div class="info-item" style="padding: 10px;">
                    <div class="info-content info-content-text">
                        <h3 class="info-title">Условия и порядок аренды</h3>
                        <img src="/static/img/about/if2.jpg" alt="" class="info-img" />
                        <br>
                        <div class="description">
                            <p class="contacts-text">
                                Требования к арендатору:
                            <ul>
                                <li>&nbsp;возраст от 22 лет;</li>
                                <li>&nbsp;стаж вождения от 3-х лет;</li>
                                <li>&nbsp;наличие прописки в России;</li>
                                <li>&nbsp;наличие оригинала паспорта и водительского удостоверения.</li>
                            </ul>
                            <div>
                                <p id="BaseID1" class="ShowDIV" onclick="Show('BaseID1','HideDIV1','ShowDIV1')">Как арендовать автомобиль?</p>

                                <p id="HideDIV1" class="HideDIV" style="display:none" onclick="DisplayNone('BaseID1','HideDIV1','ShowDIV1')">Скрыть</p>

                                <div id="ShowDIV1" style="display:none">
                                    Вы можете арендовать авто онлайн из дома. Для этого просто выберите нужный автомобиль из каталога
                                    , заполните форму составления аренды, и ожидайте подтверждения аренды от менеджера.
                                    После подтверждения Вам будет необходимо прийти в наш офис, чтобы оплатить аренду и забрать автомобиль.
                                    Вы уезжаете на арендованном авто уже через 10-15 минут!
                                    Вы также можете арендовать авто и оффлай, прийдя в наш офис.
                                    В случае возникновения каких либо вопросов обращайтесь по номеру:
                                    <nobr><a href="tel:+78005553535">+7 (800) 555-35-35</a></nobr>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>

                <div class="info-item" style="padding: 10px;">
                    <div class="info-content info-content-text">
                        <h3 class="info-title">Обязанности арендатора</h3>
                        <img src="/static/img/about/if1.jpg" alt="" class="info-img" />
                        <br>

                        <div class="description">
                            <p class="contacts-text">
                            <ul>
                                <li>&nbsp;зона проката авто - в пределах Владимирской области;</li>
                                <li>&nbsp;не оставлять машину открытой;</li>
                                <li>&nbsp;всегда перед уходом необходимо закрывать авто и включать сигнализацию;</li>
                                <li>&nbsp;нельзя оставлять в машине ключи и документы на автомобиль;</li>
                                <li>&nbsp;нельзя парковаться в запрещенных местах, а также неоплачивать парковку;</li>
                                <li>&nbsp;автомобиль необходимо возвращать чистым и с полным баком.</li>
                            </ul>
                            <div>
                                <p id="BaseID2" class="ShowDIV" onclick="Show('BaseID2','HideDIV2','ShowDIV2')">Дополнительная информация!</p>

                                <p id="HideDIV2" class="HideDIV" style="display:none" onclick="DisplayNone('BaseID2','HideDIV2','ShowDIV2')">Скрыть</p>

                                <div id="ShowDIV2" style="display:none">
                                <span style="font-weight: 900">
                                    Уважаемые клиенты, настоятельно рекомендуем Вам не нарушать ПДД, так как, несмотря на то,
                                    что автомобиль арендованный, Вы несете такую же административную и материальную ответственность в
                                    случае нарушения ПДД, как если бы это был Ваш собственный автомобиль!!!
                                </span>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>

                <div class="info-item" style="padding: 10px;">
                    <div class="info-content info-content-text">
                        <h3 class="info-title">Экстренные случай</h3>
                        <img src="/static/img/slider/slider5.jpg" alt="" class="info-img" />
                        <br>

                        <div class="description">
                            <p>
                                В случае, если Вы попали в ДТП, у Вас угнали машину или других экстренных ситуациях обязательно:
                            <ul>
                                <li>&nbsp;свяжитесь с нами по телефону <nobr><a href="tel:+78005553535">+7 (800) 555-35-35</a></nobr>;</li>
                                <li>&nbsp;позвоните по номеру <a href="tel:112">112</a> и вызовите необходимые службы (ДПС, полицию, скорую, если необходимо);</li>
                                <li>&nbsp;дождитесь представителей экстренных служб;</li>
                                <li>&nbsp;оформите все необходимые документы;</li>
                                <li>&nbsp;предоставьте все полученные документы нашим специалистам.</li>
                            </ul>
                            <div>
                                <p id="BaseID3" class="ShowDIV" onclick="Show('BaseID3','HideDIV3','ShowDIV3')">Дополнительная информация!</p>

                                <p id="HideDIV3" class="HideDIV" style="display:none" onclick="DisplayNone('BaseID3','HideDIV3','ShowDIV3')">Скрыть</p>

                                <div id="ShowDIV3" style="display:none">
                                    в случае какой-либо экстренной ситуации обязательно сохраняйте хладнокровие и рассудительность,
                                    обратитесь к нашим специалистам по телефону и мы поможем Вам в любой ситуации.
                                </div>

                            </div>
                        </div>
                    </div>
                </div>

            </div>

        </section>
        <!-- section info -->

        <!--About US-->

        <section class="section section-info" style="margin-top: 5%; width: 100%;">

            <h1 class="RentalIF" style="margin-top: 0;">О нас</h1>

            <div class="info">

                <div class="info-item" style="padding: 10px;">
                    <div class="info-content info-content-text">
                        <h3 class="info-title">Аренда</h3>
                        <img src="/static/img/slider/slider1.jpg" alt="" class="info-img" />
                        <br>
                        <div class="description">
                            <p class="contacts-text">
                                Наша компания предоставляет максимально прозрачные и понятные условия аренды автомобилей.
                                Оформление всех необходимых документов занимает не более 10 минут!
                                При повторной аренде автомобиля, Вы сможете арендовать машину по телефону или через наш сайт!
                                Более полную информацию Вы найдете в разделе "Условия аренды".
                            </p>
                        </div>
                    </div>
                </div>

                <div class="info-item" style="padding: 10px;">
                    <div class="info-content info-content-text">
                        <h3 class="info-title">Наши преимущества</h3>

                        <img src="/static/img/slider/slider3.jpeg" alt="" class="info-img" />

                        <div class="description">
                            <p class="contacts-text">
                            <div>
                                <p id="BaseID4" class="ShowDIV" onclick="Show('BaseID4','HideDIV4','ShowDIV4')">НИЗКИЕ ЦЕНЫ!</p>

                                <p id="HideDIV4" class="HideDIV" style="display:none" onclick="DisplayNone('BaseID4','HideDIV4','ShowDIV4')">НИЗКИЕ ЦЕНЫ!</p>

                                <div id="ShowDIV4" style="display:none">
                                    Мы гарантируем одни из самых низких цен на аренду автомобилей!
                                    Так, самый доступный автомобиль для аренды всего от 1 000 рублей/сутки!!!
                                    Скидки и бонусы постоянным клиентам!
                                </div>

                                <p id="BaseID5" class="ShowDIV" onclick="Show('BaseID5','HideDIV5','ShowDIV5')">ТЕХНИЧЕСКОЕ СОСТОЯНИЕ</p>

                                <p id="HideDIV5" class="HideDIV" style="display:none" onclick="DisplayNone('BaseID5','HideDIV5','ShowDIV5')">ТЕХНИЧЕСКОЕ СОСТОЯНИЕ</p>

                                <div id="ShowDIV5" style="display:none">
                                    Машины регулярно проходят ТО и мы гарантируем отличное техническое состояние арендованного Вами автомобиля!
                                </div>

                                <p id="BaseID6" class="ShowDIV" onclick="Show('BaseID6','HideDIV6','ShowDIV6')">КЛИЕНТООРИЕНТИРОВАННОСТЬ</p>

                                <p id="HideDIV6" class="HideDIV" style="display:none" onclick="DisplayNone('BaseID6','HideDIV6','ShowDIV6')">КЛИЕНТООРИЕНТИРОВАННОСТЬ</p>

                                <div id="ShowDIV6" style="display:none">
                                    Наша компания ценит своих клиентов, поэтому мы предалгаем простые и понятные правила при аренде автомобиля!
                                </div>

                            </div>
                        </div>
                    </div>
                </div>

                <div class="info-item" style="padding: 10px;">
                    <div class="info-content info-content-text">
                        <h3 class="info-title">Аксесcуары</h3>
                        <img src="/static/img/about/why3.jpg" alt="" class="info-img" />
                        <br>

                        <div class="description">
                            <p>
                                В нашей компании Вы также можете взять в аренду навигатор (100 рублей/сутки),
                                детское кресло (150 рублей/сутки) для комфорта и бехопасности тех, кто вам дорог,
                                а также автобокс, чтобы наверняка поместилось всё, что вы приготовили с собой в поездку!
                            </p>
                        </div>
                    </div>
                </div>

            </div>

        </section>

        <!--About US-->


        <script>

            function Show(BaseID, HideDIV, ShowDIV) {
                document.getElementById(HideDIV).setAttribute("style", "opacity:1; transition: 1s; height: 100%;");
                document.getElementById(BaseID).setAttribute("style", "display: none");
                document.getElementById(ShowDIV).setAttribute("style", "display: block");
            }
            function DisplayNone(BaseID, HideDIV, ShowDIV) {
                document.getElementById(HideDIV).setAttribute("style", "display: none");
                document.getElementById(ShowDIV).setAttribute("style", "display: none");
                document.getElementById(BaseID).setAttribute("style", "display: block");
            }

        </script>


        <br />

    </div>

    <@futher.foother></@futher.foother>

</@c.page>