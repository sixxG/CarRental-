<#macro nav_bar>
    <div class="navbar navbar-inverse navbar-fixed-top">
        <div class="container">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <img src="" alt="" style="width: 40px; height: 40px; margin: 5px;">

                <a class="navbar-brand navBar-item" href="/">Car FY</a>
            </div>
            <div class="navbar-collapse collapse">
                <ul class="nav navbar-nav">
                    <li class="navBar-item"><a href="/Home/About">Информация</a></li>
                    <li class="navBar-item"><a href="/Home/Contact">Контакты</a></li>
                    <li class="navBar-item"><a href="/Car">Автопарк</a></li>

                </ul>
                <ul class="nav navbar-nav navbar-right">
                    <li><a style="color: #46F046; text-decoration: none; font-size: 18px; display: block; font-weight: 600" href="tel:+78005553535">+7 (800) 555-35-35</a></li>
                    <li><a href="/Account/Register" id="registerLink">Регистрация</a></li>
                    <li><a href="/Account/Login" id="loginLink">Выполнить вход</a></li>
                </ul>

            </div>
        </div>
    </div>
</#macro>