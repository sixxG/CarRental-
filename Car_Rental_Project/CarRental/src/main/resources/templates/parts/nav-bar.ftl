<#include "security.ftl">

<#macro nav_bar>

    <link href="/static/css/Site.css" rel="stylesheet"/>

    <div class="navbar navbar-inverse navbar-fixed-top" style="border: 0;">
        <div class="container">
            <div class="navbar-header">
                <#--Error-->
                <img src="/static/img/logo.png" alt="logo" style="width: 40px; height: 40px; margin: 5px;"/>

                <a class="navbar-brand navBar-item" href="/" id="/">Car FY</a>
            </div>
            <div class="navbar-collapse collapse">
                <ul class="nav navbar-nav">
                    <#if isAdmin || isManager>
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">О компании
                                <span class="caret"></span></a>
                            <ul class="dropdown-menu">
                                <li class="navBar-item"><a id="/about" href="/about">Информация</a></li>
                                <li class="navBar-item"><a id="/contacts" href="/contacts">Контакты</a></li>
                            </ul>
                        </li>

                        <#else >
                            <li class="navBar-item"><a id="/about" href="/about">Информация</a></li>
                            <li class="navBar-item"><a id="/contacts" href="/contacts">Контакты</a></li>
                    </#if>
                    <li class="navBar-item"><a id="/car" href="/car">Автопарк</a></li>
                    <li class="navBar-item"><a id="/appeal" href="/appeal?numberPage=0">Вопросы</a></li>

                    <#if user?? && !isAdmin && !isManager>
                        <li class="navBar-item"><a id="/contract" href="/contract?page=1">Мои аренды</a></li>
                    </#if>

                    <#if isAdmin || isManager>
                        <li class="navBar-item"><a id="/contract" href="/contract/list/all?page=1">Аренды</a></li>
                    </#if>

                    <#if isAdmin>
                        <li class="navBar-item"><a id="/user" href="/user">Пользователи</a></li>
                        <li class="navBar-item"><a id="/reports" href="/reports/cars">Отчёты</a></li>
                    </#if>
                </ul>

                <ul>
                    <form action="/logout" class="navbar-right" method="post" id="logoutForm" style="margin-bottom: 0">
                        <input type="hidden" name="_csrf" value="<#if _csrf?has_content>${_csrf.token}</#if>"/>
                        <ul class="nav navbar-nav navbar-right">
                            <li>
                                <a style="color: #46F046; text-decoration: none; font-size: 18px; display: block; font-weight: 600" href="tel:+78005553535">+7 (800) 555-35-35</a>
                            </li>
                            <#if user??>
                                <li>
                                    <a id="/account" href="/account?name=${name}" title="Manage">Здравствуйте ${name}!</a>
                                </li>
                                <li>
                                    <button type="submit" class="singOut">
                                        Выйти
                                    </button>
                                </li>
                                <#else>
                                    <li>
                                        <a href="/login?logout">Войти</a>
                                    </li>
                                    <li>
                                        <a href="/registration">Регистрация</a>
                                   </li>
                            </#if>
                        </ul>
                    </form>
                </ul>

            </div>
        </div>
    </div>

    <script>
        const urlParams = document.location.pathname;
        console.log(urlParams.toString());
        const page = urlParams.split("/");
        const activePage = "/" + page.at(1);
        console.log(page);
        console.log(activePage);

        document.getElementById(activePage).style.color = '#fff';
        document.getElementById(activePage).style.backgroundColor = '#a1a1a1';

    </script>
</#macro>