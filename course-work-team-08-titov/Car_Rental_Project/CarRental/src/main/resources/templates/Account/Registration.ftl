<#import "../parts/common.ftl" as c>
<#import "../parts/nav-bar.ftl" as nav_bar>

<@c.page>

    <link href="/static/css/LogIN_OUT.css" rel="stylesheet" />
    <link href="/static/css/LogIN_OUT.css" rel="stylesheet">

<div class="container body-content" style="display: flex; flex-direction: column; min-height: 100%; width: 80%;">

    <!--Form for registration-->
    <form action="/registration" class="form-horizontal" method="post">
        <div class="bloc-log">

            <input type="hidden" name="_csrf" value="${_csrf.token}">

            <div class="bloc-header">
                <p class="bloc-header-header">Регистрация</p>
                <p class="bloc-header-info">Заполните регистрационную форму</p>
            </div>

            <!--            <hr style="color: #5394FD; margin: 5px" />-->

            <!--            <div class="validation-summary-valid text-danger" data-valmsg-summary="true">-->
            <!--                <ul>-->
            <!--                    <li style="display:none"></li>-->
            <!--                </ul>-->
            <!--            </div>-->
            <span style="color: red; font-weight: 600; font-size: 14px; text-align: center; width: 100%;">${message?if_exists}</span>

            <div class="form-group" style="width: 100%; margin: 0 auto;">
                <label class="bloc-input">Имя пользователя</label>
                <div class="bloc-input-info">
                    <input type="text" name="username" class="bloc-input-input">
                </div>
            </div>
            <div class="form-group" style="width: 100%; margin: 0 auto;">
                <label class="bloc-input">Email</label>
                <div class="bloc-input-info">
                    <input type="email" name="email" class="bloc-input-input">
                </div>
            </div>
            <div class="form-group" style="width: 100%; margin: 0 auto;">
                <label class="bloc-input">Password</label>
                <div class="bloc-input-info">
                    <input type="password" name="password" class="bloc-input-input">
                </div>
            </div>

            <br />
            <hr style="color: #5394FD; margin: 5px" />
            <br />

            <div class="form-group" style="text-align: center; width: 100%; margin: 0 auto">
                <input type="submit" value="ЗАРЕГИСТРИРОВАТЬСЯ" class="log-btn" style="font-size:26px"/>
            </div>

            <br />

            <div style="padding: 0; display: inline-block; width: 100%; text-align: center;">
                <a href="/login">Войти</a>
            </div>

        </div>
    </form>
    <!--Form for registration-->

    <br />

</div><!-- /End Section Container -->

</@c.page>
