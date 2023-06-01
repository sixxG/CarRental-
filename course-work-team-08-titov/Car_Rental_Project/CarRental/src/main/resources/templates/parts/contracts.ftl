<#macro byStatus contracts contractStatus>

    <#if !contracts?has_content>
        <h1 style="font-weight: 600; text-align: center">Таких аренд не найдено!</h1>

        <#else >
            <table class="table">
                <tr>
                    <th>
                        Клиент
                    </th>
                    <th>
                        ФИО Менеджера
                    </th>
                    <th>
                        Авто
                    </th>
                    <th>
                        Доп. опции
                    </th>
                    <th>
                        Дата начала аренды
                    </th>
                    <th>
                        Дата окончания аренды
                    </th>
                    <th>
                        Цена
                    </th>
                    <th>
                        Состояние
                    </th>
                    <th>
                        Примечания
                    </th>
                </tr>

                <#list contracts?sort_by("dateStart")?reverse as contract>

                    <tr>
                        <td>
                            <a href="/user">${contract.getUser().getFio()!"error"}</a>
                        </td>
                        <td>
                            ${contract.getFioManager()!""}
                        </td>
                        <td>
                            <a href="/car/details?id=${contract.getCar().getId()?c}">
                                ${contract.getCar().getBrand()!"error"} ${contract.getCar().getModel()!"error"}
                            </a>
                        </td>
                        <td>
                            ${contract.getAdditionalOptions()!"error"}
                        </td>
                        <td>
                            ${contract.getDateStart()!"error"}
                        </td>
                        <td>
                            ${contract.getDateEnd()!"error"}
                        </td>
                        <td>
                            ${contract.getPrice()?c!"error"}
                        </td>
                        <td>
                            ${contract.getStatus()!"error"}
                        </td>
                        <td>
                            ${contract.getNote()!"error"}
                        </td>
                        <td>
                            <div style="display: flex;">
                                <a href="/contract/details?id=${contract.getId()?c}" style="color: black">
                                    <button type="button" class="bi bi-info">
                                        <i class="fas fa-info" style="font-size: 20px"></i>
                                    </button>
                                </a>
                                <a href="/contract/edit?id=${contract.getId()?c}" style="color: black">
                                    <button type="button" class="bi bi-edit">
                                        <i class="fas fa-edit" style="font-size: 20px"></i>
                                    </button>
                                </a>

                                <!-- Button trigger modal -->
                                <#if contract.getStatus() == "Отменён" || contract.getStatus() == "Завершён">
                                    <button type="button" style="border: 0px; align-items: center; padding: 5px;"  data-toggle="modal" data-target="#exampleModalCenter_${contract.getId()?c}">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi-trash" viewBox="0 0 16 16" style="display: flex">
                                            <path d="M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0V6z"/>
                                            <path fill-rule="evenodd" d="M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1v1zM4.118 4 4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4H4.118zM2.5 3V2h11v1h-11z"/>
                                        </svg>
                                    </button>

                                    <!-- Modal -->
                                    <div class="modal fade" id="exampleModalCenter_${contract.getId()?c}" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                                        <div class="modal-dialog modal-dialog-centered" role="document">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title" id="exampleModalLongTitle">Подтверждение удаления аренды.</h5>
                                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                        <span aria-hidden="true">&times;</span>
                                                    </button>
                                                </div>
                                                <div class="modal-body">
                                                    Вы действительно хотите удалить данную аренду?
                                                </div>
                                                <div class="modal-footer">

                                                    <form action="/contract/delete" method="post">

                                                        <input type="hidden" name="_csrf" value="<#if _csrf?has_content>${_csrf.token}</#if>">
                                                        <input type="hidden" name="id" value="${contract.getId()?c}">

                                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">NO</button>
                                                        <button type="submit" class="btn btn-primary">YES</button>

                                                    </form>

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </#if>
                            </div>

                        </td>

                    </tr>

                </#list>

            </table>
    </#if>

</#macro>