<#import "../parts/common.ftl" as c>
<#import "../parts/nav-bar.ftl" as nav_bar>

<@c.page>

    <@nav_bar.nav_bar></@nav_bar.nav_bar>

    UserEditor
    <form action="/user" method="POST">
        <input type="hidden" value="${user.id}" name="userId">
        <input type="hidden" value="${_csrf.token}" name="_csrf">

        <input type="text" name="userName" value="${user.username}">
        <!--List roles-->
        <#list roles as role>
            <div>
                <label>
                    <input type="checkbox" name="${role.name}"
                            ${user.roles?seq_contains(role)?string("checked",
                            "")}>
                    ${role.name}
                </label>
            </div>
        </#list>
        <!--List roles-->

        <button type="submit">Save</button>

    </form>

</@c.page>
