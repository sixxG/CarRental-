<#import "../parts/common.ftl" as c>
<#import "../parts/nav-bar.ftl" as nav_bar>
<#import "../parts/foother.ftl" as futher>
<#import "../parts/car.ftl" as carParts>

<@c.page>
    <link href="/static/css/Contact_CSS.css" rel="stylesheet" />
    <link href="/static/css/Button.css" rel="stylesheet" />
    <link href="/static/css/About.css" rel="stylesheet" />

    <div class="container body-content" style="display: flex; flex-direction: column; min-height: 100%; width: 80%;">
        <br/>
        <!--Slider-->
        <div id="myCarousel" class="carousel slide" data-ride="carousel" style="margin-top: 4%;">
            <!-- Indicators -->
            <ol class="carousel-indicators">
                <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
                <li data-target="#myCarousel" data-slide-to="1"></li>
                <li data-target="#myCarousel" data-slide-to="2"></li>
            </ol>

            <!-- Wrapper for slides -->
            <div class="carousel-inner">
                <div class="item active" style="height: 500px;">
                    <img src="/static/img/slider/slider1.jpg" alt="Chania" style="height: 500px; width: 100%"/>
                    <div class="carousel-caption" style="background: rgba(40, 40, 40, 0.5)">
                        <h3>Аренда</h3>
                        <p>Прозрачные условия аренды для всех!</p>
                    </div>
                </div>

                <div class="item">
                    <img src="/static/img/slider/slider6.jpg" alt="Chicago" style="height: 500px; width: 100%"/>
                    <div class="carousel-caption" style="background: rgba(40, 40, 40, 0.5)">
                        <h3>Автопарк</h3>
                        <p>У нас огромный автопарк, где вы можете выбрать авто под любые нужды!</p>
                    </div>
                </div>

                <div class="item">
                    <img src="/static/img/slider/slider3.jpeg" alt="New York" style="height: 500px; width: 100%;"/>
                    <div class="carousel-caption" style="background: rgba(40, 40, 40, 0.5)">
                        <h3>Почему мы?</h3>
                        <p>Почему стоит выбрать именно нас? Потому что!</p>
                    </div>
                </div>
            </div>

            <!-- Left and right controls -->
            <a class="left carousel-control" href="#myCarousel" data-slide="prev">
                <span class="sr-only">Previous</span>
            </a>
            <a class="right carousel-control" href="#myCarousel" data-slide="next">
                <span class="sr-only">Next</span>
            </a>
        </div>
        <!--Slider-->

        <p class="headerSelect">Выберите авто для себя</p>

        <@carParts.search></@carParts.search>

        <@carParts.classes></@carParts.classes>
        <br />
        <br />

        <!--Popular cars-->

        <a href="/car" class="carHeader" style="text-align: left">Популярные авто →</a>

        <div style="width: 100%" id="popular_cars">
            <#list cars as car>
                <@carParts.carCardForMainPage car=car></@carParts.carCardForMainPage>
            </#list>
        </div>

        <!--Popular cars-->

        <!--Why us-->

        <h1 class="whyUsHeader">Почему стоит выбрать нас?</h1>

        <br />

        <div class="WHYUs_container">

            <div class="WHY_Us_block_notAtive">
                <img src="/static/img/slider/slider4.jpg" class="WHY_US_img"/>
                <div class="WHY_US_Text">
                    Наша компания ещё не вышла на рынок, но уже имеет огромную известность среди автолюбителей!
                </div>
            </div>

            <div class="WHY_Us_block_notAtive">
                <img src="/static/img/slider/slider5.jpg" class="WHY_US_img" />
                <div class="WHY_US_Text">
                    Все наши автомобили имеют страховку КАСКО и ОСАГО. Так что, вы с лёгкостью можете повторять все безумные трюки из GTA!
                </div>
            </div>

            <div class="WHY_Us_block_notAtive">
                <img src="/static/img/slider/slider6.jpg" class="WHY_US_img" />
                <div class="WHY_US_Text">
                    Нашему автопарку позавидуют даже шейхи из АОЭ! У них точно нет ГАЗ 21 волга в таком же состоянии как у нас!
                </div>
            </div>

        </div>

        <!--Why us-->
        <br />

    </div>

    <marquee direction="right">
        <h1 style="color: #404040">Some text!   Some text!  Some text!</h1>
    </marquee>

    <@futher.foother></@futher.foother>

</@c.page>