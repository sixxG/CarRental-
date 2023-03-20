<#import "../parts/common.ftl" as c>
<#import "../parts/nav-bar.ftl" as nav_bar>
<#import "../parts/foother.ftl" as futher>
<#import "../parts/car.ftl" as carParts>

<@c.page>

    <link href="/static/css/About.css" rel="stylesheet" />

    <div class="container body-content" style="display: flex; flex-direction: column; min-height: 100%; width: 80%;">

        <h1 class="RentalIF" style="margin-top: 5%;">Контакты</h1>

        <img src="/static/img/contacts/key.png" alt="map" style="position: absolute; z-index: -1; width: 45%; height: 80%; left: 55%; top: 15%; opacity: 0.8;"/>

        <div style="display: flex; width: 100%;">
            <div style="display: flex; width: 60%; border-radius: 15px;">
                <script type="text/javascript"
                        charset="utf-8" async
                        src="https://api-maps.yandex.ru/services/constructor/1.0/js/?um=constructor%3A132120a355fa3a00db687aecb43156d2251e5957ae6ef0cb31ff458a636a7e6d&amp;width=700&amp;height=600&amp;lang=ru_RU&amp;scroll=true">
                </script>
            </div>

            <div>

                <div style="color: black; padding: 10px; margin-top: 75%;">

                    <div>
                        <h3 style="font-size: 32px; font-weight: 600;">Адресс</h3>
                        <p style="font-size: 16px;">Владимир, Проспект Строителей 7Б, стр. 14,</p>
                    </div>
                    <div class="contacts-item">
                        <h3 style="font-size: 32px; font-weight: 600;">Телефон</h3>
                        <p class="contacts-text">
                            <a style="text-decoration: none; color: #00ff00; font-weight: 900; font-size: 20px;" href="tel:+78005553535">+7 (800) 555-35-35</a>
                        </p>
                    </div>
                    <div class="contacts-item">
                        <h3 style="font-size: 32px; font-weight: 600;">Социальные сети</h3>

                        <div class="social vk">
                            <a href="#" target="_blank"><i class="fa fa-vk fa-2x"></i></a>
                        </div>

                        <div class="social youtube">
                            <a href="#" target="_blank"><i class="fa fa-youtube fa-2x"></i></a>
                        </div>

                        <div class="social telegram">
                            <a href="#" target="_blank"><i class="fa fa-paper-plane fa-2x"></i></a>
                        </div>

                    </div>
                </div>
            </div>
        </div>

        <br />

    </div>

    <@futher.foother></@futher.foother>

</@c.page>