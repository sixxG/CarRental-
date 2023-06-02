<#import "../parts/common.ftl" as c>
<#import "../parts/nav-bar.ftl" as nav_bar>

<@c.page>

    <link href="/static/css/LogIN_OUT.css" rel="stylesheet" />
    <link href="/static/css/LogIN_OUT.css" rel="stylesheet">

<div class="container body-content" style="display: flex; flex-direction: column; min-height: 100%; width: 80%;">

    <div class="bloc-log">

        <div class="bloc-header">
            <p class="bloc-header-header">Вход</p>
            <p class="bloc-header-info">Введите свои учётные данные</p>
        </div>

        <hr style="color: #5394FD; margin: 5px" />
        <br />

        <h3 style="color: white; font-weight: 300; text-align: center">${message?if_exists}</h3>
        <h3 style="color: white; font-weight: 300; text-align: center">${errorMessage?if_exists}</h3>
        <form action="/login" class="form-horizontal" method="post">
            <input type="hidden" name="_csrf" value="<#if _csrf?has_content>${_csrf.token}</#if>">
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

            <br />
            <hr style="color: #5394FD; margin: 5px" />
            <br />

            <div class="form-group" style="text-align: center; width: 100%; margin: 0 auto">
                <input type="submit" value="ВОЙТИ" data-id="ВОЙТИ" class="log-btn" />
            </div>
            <br />
            <div style="display: flex;">
                <div style="padding: 0; display: inline-block; width: 60%;">
                    <a href="/registration">Регистрация нового пользователя</a>
                </div>

            </div>
        </form>

    </div>

    <br />

</div>


</@c.page>
