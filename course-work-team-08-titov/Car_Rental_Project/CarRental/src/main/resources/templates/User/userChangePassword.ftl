<#import "../parts/common.ftl" as c>
<#include "../parts/security.ftl">

<@c.page>

    <div class="container" style="margin-top: 6%; width: 70%; justify-content: center;">
        <form action="change_password" method="post" id="password-form">

            <input type="hidden" value="<#if _csrf?has_content>${_csrf.token}</#if>" name="_csrf"/>

            <#if error??>
                <p style="color: red; font-weight: 600">
                    ${error}
                </p>
            </#if>

            <#if successPassword??>
                <p style="color: green; font-weight: 600">
                    ${successPassword}
                </p>
            </#if>

            <div class="form-group">
                <label for="oldPassword">Старый пароль</label>
                <input type="password" name="oldPassword" class="form-control" id="oldPassword" placeholder="введите старый пароль" required="required"/>
            </div>
            <div class="form-group">
                <label for="newPassword">Новый пароль</label>
                <input type="text" name="newPassword" class="form-control" id="newPassword" placeholder="введите новый пароль" required="required"/>
            </div>
            <div class="form-group">
                <label for="confirmPassword">Повторите пароль</label>
                <input type="password" name="confirmPassword" class="form-control" id="confirmPassword" placeholder="повторите новый пароль" required="required"/>
            </div>

            <p style="color: red; font-weight: 600" id="passwordError"></p>

            <button type="submit" class="btn btn-info">Изменить</button>
        </form>
    </div>

    <script>
        const form = document.querySelector('#password-form');
        const password = document.querySelector('#newPassword');
        const confirmPassword = document.querySelector('#confirmPassword');
        const error = document.getElementById('passwordError');

        form.addEventListener('submit', (event) => {
            event.preventDefault();

            if (password.value !== confirmPassword.value) {
                error.innerText = "Подтверждение пароля не совпадает с новым паролем!";
            } else {
                form.submit();
            }
        });
    </script>
</@c.page>
