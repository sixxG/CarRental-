<#import "../parts/common.ftl" as c>
<#import "../parts/nav-bar.ftl" as nav_bar>

<@c.page>

    <div style="display: block; width: 50%; margin: 0 auto">

        <ul class="nav nav-tabs" style="margin-top: 10%; ">
            <li class="active">
                <a data-toggle="tab" href="#users" style=" padding: 10px 5px 5px 5px;"><h4>Пользователи</h4></a>
            </li>
            <li>
                <a data-toggle="tab" href="#admins" style=" padding: 10px 5px 5px 5px;"><h4>Администраторы</h4></a>
            </li>
            <li>
                <a data-toggle="tab" href="#managers" style=" padding: 10px 5px 5px 5px;"><h4>Менеджеры</h4></a>
            </li>
        </ul>

        <div class="tab-content">
            <div id="users" class="tab-pane fade in active">
                <table class="table" style="width: 100%;">
                    <thead>
                    <tr>
                        <th scope="col">#</th>
                        <th scope="col">Name</th>
                        <th scope="col">Role</th>
                        <th scope="col"></th>
                    </tr>
                    </thead>
                    <tbody>
                    <#list users as user>
                        <tr>
                            <td>${user.id}</td>
                            <td>${user.username}</td>
                            <td>
                                <#list user.roles as role>
                                    <p>${role.name} </p>
                                </#list>
                            </td>
                            <td>
                                <a href="/user/${user.id}">Edit</a>
                            </td>
                        </tr>
                        <#else >
                        <h1>Пользователей с такой ролью не существует!</h1>
                    </#list>
                    </tbody>
                </table>
            </div>

            <div id="admins" class="tab-pane fade in">
                <table class="table" style="width: 100%;">
                    <thead>
                    <tr>
                        <th scope="col">#</th>
                        <th scope="col">Name</th>
                        <th scope="col">Role</th>
                        <th scope="col"></th>
                    </tr>
                    </thead>
                    <tbody>
                    <#list admins as admin>
                        <tr>
                            <td data-id="${admin.id}">${admin.id}</td>
                            <td data-id="${admin.username}">${admin.username}</td>
                            <td>
                                <#list admin.roles as role>
                                    <p>${role.name} </p>
                                </#list>
                            </td>
                            <td>
                                <a href="/user/${admin.id}">Edit</a>
                            </td>
                        </tr>
                        <#else >
                            <h1>Пользователей с такой ролью не существует!</h1>
                    </#list>
                    </tbody>
                </table>
            </div>

            <div id="managers" class="tab-pane fade in">
                <table class="table" style="width: 100%;">
                    <thead>
                    <tr>
                        <th scope="col">#</th>
                        <th scope="col">Name</th>
                        <th scope="col">Role</th>
                        <th scope="col"></th>
                    </tr>
                    </thead>
                    <tbody>
                    <#list managers as manager>
                        <tr>
                            <td>${manager.id}</td>
                            <td>${manager.username}</td>
                            <td>
                                <#list manager.roles as role>
                                    <p>${role.name} </p>
                                </#list>
                            </td>
                            <td>
                                <a href="/user/${manager.id}">Edit</a>
                            </td>
                        </tr>
                        <#else >
                            <h1>Пользователей с такой ролью не существует!</h1>
                    </#list>
                    </tbody>
                </table>
            </div>

        </div>

    </div>

</@c.page>
