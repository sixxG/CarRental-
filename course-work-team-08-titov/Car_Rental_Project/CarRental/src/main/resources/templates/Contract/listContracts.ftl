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

        <!-- Start search -->
        <form action="search" method="post">
            <input type="hidden" name="_csrf" value="${_csrf.token}">
            <div style="display: flex; width: 100%;">

                <div style="padding: 0; display: inline-block; text-align: left; width: 50%;">
                    <label>
                        <input type="date" style="width: 49%;" class="inputPrice" placeholder="Дата начала" name="DateStart" />
                        <input type="date" style="width: 49%;" class="inputPrice" placeholder="Дата завершения" name="DateEnd" />
                    </label>
                </div>

                <div style="padding: 0; display: inline-block; text-align: center; width: 90%;">

                    <input class="inputCar" id="ListClients" name="Client" list="listClients" placeholder="ФИО клиента"/>
                    <datalist id="listClients">
                        <#list users as user>
                            <option>${user}</option>
                        </#list>
                    </datalist>

                    <input class="inputCar" id="ListBrand" name="CarBrand" list="listCarsBrand" placeholder="Брэнд авто"/>
                    <datalist id="listCarsBrand">
                        <#list cars as car>
                            <option>${car}</option>
                        </#list>
                    </datalist>

                </div>

                <div style="padding: 0; display: inline-block; text-align: center; width: 20%;">
                    <input type="submit" class="icon" value="" style="font-size: 50px; background: url('/image/search.png') no-repeat center; background-size: 50px; width: 70%; height: 55%; border-radius: 15px; border: 1px" />
                </div>

            </div>
        </form>
        <!-- End search -->

        <br />
        <ul class="nav nav-tabs">
            <li class="active">
                <a data-toggle="tab" href="#ALL" style=" padding: 10px 5px 5px 5px;"><h4>Все</h4></a>
            </li>
            <li>
                <a data-toggle="tab" href="#NotConfirm" style=" padding: 10px 5px 5px 5px;"><h4>Ожидают подтверждения</h4></a>
            </li>
            <li>
                <a data-toggle="tab" href="#Confirm" style=" padding: 10px 5px 5px 5px;"><h4>Подтверждённые</h4></a>
            </li>
            <li>
                <a data-toggle="tab" href="#Work" style=" padding: 10px 5px 5px 5px;"><h4>Действуют</h4></a>
            </li>
            <li>
                <a data-toggle="tab" href="#PaymentFine" style=" padding: 10px 5px 5px 5px;"><h4>Ожидают оплаты штрафа</h4></a>
            </li>
            <li>
                <a data-toggle="tab" href="#Completed" style=" padding: 10px 5px 5px 5px;"><h4>Завершённые</h4></a>
            </li>
            <li>
                <a data-toggle="tab" href="#Сancelled" style=" padding: 10px 5px 5px 5px;"><h4>Отменённые</h4></a>
            </li>
        </ul>

        <!--Block-->
        <div class="tab-content">
            <div id="ALL" class="tab-pane fade in active">
                <@paspartsContract.byStatus contracts=contracts contractStatus="All">
                </@paspartsContract.byStatus>
            </div>
            <div id="NotConfirm" class="tab-pane fade in">
                <@paspartsContract.byStatus contracts=contracts contractStatus="Не подтверждён">
                </@paspartsContract.byStatus>
            </div>
            <div id="Confirm" class="tab-pane fade in">
                <@paspartsContract.byStatus contracts=contracts contractStatus="Подтверждён">
                </@paspartsContract.byStatus>
            </div>
            <div id="Work" class="tab-pane fade in">
                <@paspartsContract.byStatus contracts=contracts contractStatus="Действует">
                </@paspartsContract.byStatus>
            </div>
            <div id="PaymentFine" class="tab-pane fade in">
                <@paspartsContract.byStatus contracts=contracts contractStatus="Ожидает оплаты штрафа">
                </@paspartsContract.byStatus>
            </div>
            <div id="Completed" class="tab-pane fade in">
                <@paspartsContract.byStatus contracts=contracts contractStatus="Завершён">
                </@paspartsContract.byStatus>
            </div>
            <div id="Сancelled" class="tab-pane fade in">
                <@paspartsContract.byStatus contracts=contracts contractStatus="Отменён">
                </@paspartsContract.byStatus>
            </div>
        </div>
        <!--Block-->

        <br />

    </div>

</@c.page>