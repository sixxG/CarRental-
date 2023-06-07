<#import "../parts/common.ftl" as c>
<#include "../parts/security.ftl">

<@c.page>

    <div class="container" style="margin-top: 6%; width: 70%; justify-content: center;">
        <form action="change_email" method="post" id="email-form">

            <input type="hidden" value="<#if _csrf?has_content>${_csrf.token}</#if>" name="_csrf"/>
            <input type="hidden" value="${usersID}" name="usersID"/>
            <input type="hidden" value="${userEmail}" name="oldEmail"/>

            <#if error??>
                <p style="color: red; font-weight: 600">
                    ${error}
                </p>
            </#if>

            <#if successEmail??>
                <p style="color: green; font-weight: 600">
                    ${successEmail}
                </p>
            </#if>

            <div class="form-group">
                <label for="oldEmail">Старая почта:</label>
                <input type="email" name="oldEmail" class="form-control" id="oldEmail" value="${userEmail}" disabled="disabled" required="required"/>
            </div>
            <div class="form-group">
                <label for="newEmail">Новая почта</label>
                <input type="email" name="newEmail" class="form-control" id="newEmail" placeholder="введите новую почту" required="required"/>
            </div>

            <p style="color: red; font-weight: 600" id="emailError"></p>

            <button type="submit" class="btn btn-info">Изменить</button>
        </form>
    </div>

    <script>
        const form = document.querySelector('#email-form');
        const email = document.querySelector('#newEmail');
        const oldEmail = document.querySelector('#oldEmail');
        const error = document.getElementById('emailError');

        form.addEventListener('submit', (event) => {
            event.preventDefault();

            if (email.value === oldEmail.value) {
                error.innerText = "Бессмысленно менять почту на такую же!)";
            } else {
                form.submit();
            }
        });
    </script>
</@c.page>
