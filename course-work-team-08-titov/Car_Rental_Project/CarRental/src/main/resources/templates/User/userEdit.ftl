<#import "../parts/common.ftl" as c>
<#import "../parts/nav-bar.ftl" as nav_bar>

<@c.page>

<div class="container body-content" style="display: flex; flex-direction: column; min-height: 100%; width: 50%; margin-top: 5%;">

    <h1 style="margin-top: 5%;">UserEditor</h1>

    <form action="/user" method="POST">

        <input type="hidden" value="${user.id?c}" name="userId"/>
        <input type="hidden" value="<#if _csrf?has_content>${_csrf.token}</#if>" name="_csrf"/>

        <div class="form-group row">
            <label for="inputEmail3" class="col-sm-2 col-form-label">User name</label>
            <div class="col-sm-10">
                <input type="text" name="userName" class="form-control" id="inputEmail3" value="${user.username}"/>
            </div>
        </div>

        <a data-toggle="collapse" href="#personalData">
            <h3 class="reportsBlocksHeader">Личные данные</h3>
        </a>
        <div class="collapse requestBody" id="personalData">
            <div class="form-group row">
                <label for="inputFIO" class="col-sm-2 col-form-label">ФИО</label>
                <div class="col-sm-4">
                    <input type="text" class="form-control" id="inputFIO" value="${user.fio}" disabled="disabled"/>
                </div>

                <label for="inputBirthDate" class="col-sm-2 col-form-label">Дата рождения</label>
                <div class="col-sm-4">
                    <input type="text" class="form-control" id="inputFIO" value="${user.birthDate}" disabled="disabled"/>
                </div>
            </div>

            <div class="form-group row">
                <label for="inputAddress" class="col-sm-2 col-form-label">Адрес</label>
                <div class="col-sm-7">
                    <textarea class="form-control" id="inputAddress" rows="3" style="resize: vertical" disabled="disabled">
                        ${user.address}
                    </textarea>
                </div>
            </div>

            <div class="form-group row">
                <label for="inputPhone" class="col-sm-2 col-form-label">Телефон</label>
                <div class="col-sm-4">
                    <input type="text" class="form-control" id="inputPhone" value="${user.phone}" disabled="disabled"/>
                </div>

                <label for="inputDriverLicence" class="col-sm-2 col-form-label">Номер ВУ</label>
                <div class="col-sm-4">
                    <input type="text" class="form-control" id="inputDriverLicence" value="${user.driverLicense}" disabled="disabled"/>
                </div>
            </div>
        </div>

        <h1>Roles</h1>
        <!--List roles-->
        <#list roles as role>
            <div class="form-group row">
                <label for="${role.name}" class="col-sm-2 col-form-label">${role.name}</label>
                <input type="checkbox" name="${role.name}" class="form-control" style="width: 50%" id="${role.name}"
                        ${user.roles?seq_contains(role)?string('checked="checked"',
                        "")}/>
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
