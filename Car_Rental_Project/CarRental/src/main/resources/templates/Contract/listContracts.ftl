<#import "../parts/common.ftl" as c>
<#import "../parts/nav-bar.ftl" as nav_bar>
<#import "../parts/contracts.ftl" as paspartsContract>

<#include "../parts/security.ftl">

<@c.page>

    <link href="/static/css/Contact_CSS.css" rel="stylesheet" />

    <link rel="stylesheet" href="/static/css/Appeal.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css">

    <div class="container body-content" style="display: flex; flex-direction: column; min-height: 100%; width: 80%;">

        <br />
        <h2 style="margin-top: 5%;">Аренды</h2>

        <#if emptyFIO??>
            <p style="color: red; font-weight: 600">Заполните поле ФИО на странице аккаунта!</p>
        </#if>

        <!-- Start search -->
        <form action="/contract/search" method="post">
            <input type="hidden" name="_csrf" value="<#if _csrf?has_content>${_csrf.token}</#if>">
            <div style="display: flex; width: 100%;">

                <div style="padding: 0; display: inline-block; text-align: left; width: 50%;">
                    <label>
                        <input type="date" style="width: 49%;" class="inputPrice" placeholder="Дата начала" name="DateStart"
                                <#if dateStart?has_content> value="${dateStart}" </#if>/>
                        <input type="date" style="width: 49%;" class="inputPrice" placeholder="Дата завершения" name="DateEnd"
                                <#if dateEnd?has_content> value="${dateEnd}" </#if>/>
                    </label>
                </div>

                <div style="padding: 0; display: inline-block; text-align: center; width: 90%;">

                    <input class="inputCar" id="ListClients" name="Client" list="listClients" placeholder="ФИО клиента"
                            <#if client?has_content> value="${client}" </#if>/>
                    <datalist id="listClients">
                        <#list users as user>
                            <option>${user}</option>
                        </#list>
                    </datalist>

                    <input class="inputCar" id="ListBrand" name="CarBrand" list="listCarsBrand" placeholder="Брэнд авто"
                            <#if brand?has_content> value="${brand}" </#if>/>
                    <datalist id="listCarsBrand">
                        <#list cars as car>
                            <option>${car}</option>
                        </#list>
                    </datalist>

                </div>

                <div style="padding: 0; display: inline-block; text-align: center; width: 20%;">
                    <input type="submit" class="icon" value="" style="font-size: 50px; background: url('/image/search.png') no-repeat center; background-size: 50px; width: 70%; height: 55%; border-radius: 15px; border: 1px" />
                </div>

                <div style="padding: 0; display: inline-block; text-align: center; width: 5%;">
                    <a href="/contract/list/all?page=1" class="btn btn-danger" style="margin-top: 13px">Сбросить</a>
                </div>

            </div>
        </form>
        <!-- End search -->

        <script>
            // Получаем значение параметра "page" из URL
            const urlParamsContractsList = new URLSearchParams(window.location.search);
            let contractListStatus = urlParamsContractsList.get('status');
            const contractListPage = "page_item_" + urlParamsContractsList.get('page');

            console.log(contractListPage);
            let activeLinkWithStatus;

            if (contractListStatus !== null && contractListStatus.includes(" ")) {
                contractListStatus = contractListStatus.replaceAll(" ", "_");
                console.log("status: " + contractListStatus);
            }
        </script>

        <br />
        <ul class="nav nav-tabs">
            <li id="all">
                <a  href="/contract/list/all?page=1" style=" padding: 10px 5px 5px 5px;"><h4>Все</h4></a>
            </li>
            <li id="Не_подтверждён">
                <a href="/contract/list/all?page=1&status=Не подтверждён" style=" padding: 10px 5px 5px 5px;"><h4>Ожидают подтверждения</h4></a>
            </li>
            <li id="Подтверждён">
                <a href="/contract/list/all?page=1&status=Подтверждён" style=" padding: 10px 5px 5px 5px;"><h4>Подтверждённые</h4></a>
            </li>
            <li id="Действует">
                <a href="/contract/list/all?page=1&status=Действует" style=" padding: 10px 5px 5px 5px;"><h4>Действуют</h4></a>
            </li>
            <li id="Ожидает_оплаты_штрафа">
                <a href="/contract/list/all?page=1&status=Ожидает оплаты штрафа" style=" padding: 10px 5px 5px 5px;"><h4>С штрафом</h4></a>
            </li>
            <li id="Завершён">
                <a href="/contract/list/all?page=1&status=Завершён" style=" padding: 10px 5px 5px 5px;"><h4>Завершённые</h4></a>
            </li>
            <li id="Отменён">
                <a href="/contract/list/all?page=1&status=Отменён" style=" padding: 10px 5px 5px 5px;"><h4>Отменённые</h4></a>
            </li>
        </ul>

        <script>
            function changeHref(id) {
                const previouslyHref = document.getElementById(id).getAttribute("href");
                let currentPath = "/";
                let whichStatus;
                if (contractListStatus !== null) {
                    if (contractListStatus.includes("_")) {
                        whichStatus = contractListStatus.replaceAll("_", "%20");
                    } else {
                        whichStatus = contractListStatus;
                    }
                    currentPath = previouslyHref + "&" + "status=" + whichStatus;
                    document.getElementById(id).setAttribute("href", currentPath);
                } else {
                    currentPath = previouslyHref;
                    document.getElementById(id).setAttribute("href", currentPath);
                }
            }
        </script>

        <div class="tab-content">
            <div id="ALL" class="tab-pane fade in active">
                <#if countPage?has_content && countPage != 0>
                    <nav aria-label="...">
                        <ul class="pagination">
                            <li class="page-item">
                                <a class="page-link" href="/contract/list/all?page=1" id="startLink">Start</a>
                            </li>
                            <#list 1..countPage as page>
                                <li class="page-item" id="page_item_${page?c}">
                                    <a class="page-link" id="button_${page?c}" href="/contract/list/all?page=${page?c}">${page?c}</a>
                                </li>
                                <script>
                                    changeHref("button_${page?c}");
                                </script>
                            </#list>
                            <li class="page-item">
                                <a class="page-link" href="/contract/list/all?page=${countPage?c}" id="endLink">End</a>
                            </li>
                            <script>
                                changeHref("startLink");
                                changeHref("endLink");
                            </script>
                        </ul>
                    </nav>
                </#if>
                <@paspartsContract.byStatus contracts=contracts contractStatus="All">
                </@paspartsContract.byStatus>
            </div>

            <script>
                if (contractListStatus !== null && contractListStatus.includes(" ")) {
                    contractListStatus = contractListStatus.replaceAll(" ", "_");
                    console.log("status: " + contractListStatus);
                    activeLinkWithStatus = document.getElementById(contractListStatus);
                } else if (contractListStatus == null) {
                    activeLinkWithStatus = document.getElementById("all");
                }
                else {
                    console.log("status: " + contractListStatus);
                    activeLinkWithStatus = document.getElementById(contractListStatus);
                }

                // Находим кнопку с id, соответствующим значению page
                const activeButtonPage = document.getElementById(contractListPage);

                // Если такая кнопка найдена, то эмулируем ее нажатие
                if (activeButtonPage) {
                    activeButtonPage.classList.add("active");
                }

                if (activeLinkWithStatus) {
                    activeLinkWithStatus.classList.add("active");
                }
            </script>
        </div>
        <!--Block-->

        <br />

    </div>

</@c.page>