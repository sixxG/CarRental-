<#import "../parts/common.ftl" as c>
<#import "../parts/nav-bar.ftl" as nav_bar>

<@c.page>

<@nav_bar.nav_bar></@nav_bar.nav_bar>

<div class="container body-content" style="display: flex; flex-direction: column; min-height: 100%; width: 80%;">

    <div class="bloc-log">

        <div class="bloc-header">
            <p class="bloc-header-header">Вход</p>
            <p class="bloc-header-info">Введите свои учётные данные</p>
        </div>

        <hr style="color: #5394FD; margin: 5px" />
        <br />

        <form action="/login" class="form-horizontal" method="post">
            <input type="hidden" name="_csrf" value="${_csrf.token}">
            <div class="form-group" style="width: 100%; margin: 0 auto;">
                <label class="bloc-input">Имя пользователя</label>
                <br />
                <div class="bloc-input-info">
                    <input type="text" name="username" id="username" class="bloc-input-input">
                </div>
            </div>
            <div class="form-group" style="width: 100%; margin: 0 auto;">
                <label class="bloc-input">Пароль</label>
                <br />
                <div class="bloc-input-info">
                    <input type="password" name="password" id="password" class="bloc-input-input">
                </div>
            </div>
<!--            <div class="bloc-input-chek">-->

<!--                <div class="checkbox" style="width: 100%; text-align: left; color: white;">-->
<!--                    <input class="bloc-input-checkBox" data-val="true" data-val-required="Требуется поле Запомнить меня." id="RememberMe" name="RememberMe" type="checkbox" value="true" /><input name="RememberMe" type="hidden" value="false" />-->
<!--                    <label for="RememberMe">Запомнить меня</label>-->
<!--                </div>-->

<!--            </div>-->
            <br />
            <hr style="color: #5394FD; margin: 5px" />
            <br />
            <div class="form-group" style="text-align: center; width: 100%; margin: 0 auto">
                <input type="submit" value="ВОЙТИ" class="log-btn" />
            </div>
            <br />
            <div style="display: flex;">
                <div style="padding: 0; display: inline-block; width: 60%;">
                    <a href="/registration">Регистрация нового пользователя</a>
                </div>

<!--                <div style="padding: 0; display: inline-block; text-align: right; width: 40%;">-->

<!--                    <a href="/Account/ForgotPassword?class=OtherLogInFich">Забыли пароль?</a>-->
<!--                </div>-->
            </div>
        </form>

    </div>

    <br />

</div><!-- /End Section Container -->

</@c.page>
