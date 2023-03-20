<#import "../parts/common.ftl" as c>
<#import "../parts/nav-bar.ftl" as nav_bar>

<@c.page>

<div class="container body-content" style="display: flex; flex-direction: column; min-height: 100%; width: 50%; margin-top: 5%;">

    <h1 style="margin-top: 5%;">UserEditor</h1>

    <form action="/user" method="POST">

        <input type="hidden" value="${user.id}" name="userId">
        <input type="hidden" value="${_csrf.token}" name="_csrf">

        <div class="form-group row">
            <label for="inputEmail3" class="col-sm-2 col-form-label">User name</label>
            <div class="col-sm-10">
                <input type="text" name="userName" class="form-control" id="inputEmail3" value="${user.username}">
            </div>
        </div>

        <h1>Roles</h1>
        <!--List roles-->
        <#list roles as role>
            <div class="form-group row">
                <label for="${role.name}" class="col-sm-2 col-form-label">${role.name}</label>
                <input type="checkbox" name="${role.name}" class="form-control" style="width: 50%" id="${role.name}"
                        ${user.roles?seq_contains(role)?string("checked",
                        "")}>
            </div>
        </#list>
        <!--List roles-->

        <div class="form-group row">
            <div class="col-sm-10">
                <button type="submit" class="btn btn-primary">Save</button>
            </div>
        </div>
    </form>

</div>

</@c.page>
