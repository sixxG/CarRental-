<#import "../parts/common.ftl" as c>
<#import "../parts/nav-bar.ftl" as nav_bar>

<@c.page>

    <link rel="stylesheet" href="/static/css/Appeal.css">

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
                            <td>${user.id?c}</td>
                            <td>${user.username}</td>
                            <td>
                                <#list user.roles as role>
                                    <p>${role.name} </p>
                                </#list>
                            </td>
                            <td>
                                <a href="/user/${user.id?c}">Edit</a>
                            </td>
                            <!-- Button trigger modal -->
                            <td>
                                <button type="button" style="border: 0px; align-items: center; padding: 5px;"  data-toggle="modal" data-target="#exampleModalCenter_${user.getId()?c}">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi-trash" viewBox="0 0 16 16" style="display: flex">
                                        <path d="M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0V6z"/>
                                        <path fill-rule="evenodd" d="M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1v1zM4.118 4 4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4H4.118zM2.5 3V2h11v1h-11z"/>
                                    </svg>
                                </button>

                                <!-- Modal -->
                                <div class="modal fade" id="exampleModalCenter_${user.getId()?c}" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                                    <div class="modal-dialog modal-dialog-centered" role="document">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="exampleModalLongTitle">Подтверждение удаления пользователя.</h5>
                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                    <span aria-hidden="true">&times;</span>
                                                </button>
                                            </div>
                                            <div class="modal-body">
                                                Вы действительно хотите удалить данного пользователя?
                                            </div>
                                            <div class="modal-footer">

                                                <form action="/user/delete" method="post">

                                                    <input type="hidden" name="_csrf" value="<#if _csrf?has_content>${_csrf.token}</#if>">
                                                    <input type="hidden" name="id" value="${user.getId()?c}">

                                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">NO</button>
                                                    <button type="submit" class="btn btn-primary">YES</button>

                                                </form>

                                            </div>
                                        </div>
                                    </div>
                                </div>
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
                            <td data-id="${admin.id?c}">${admin.id}</td>
                            <td data-id="${admin.username}">${admin.username}</td>
                            <td>
                                <#list admin.roles as role>
                                    <p>${role.name} </p>
                                </#list>
                            </td>
                            <td>
                                <a href="/user/${admin.id?c}">Edit</a>
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
                                <a href="/user/${manager.id?c}">Edit</a>
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
