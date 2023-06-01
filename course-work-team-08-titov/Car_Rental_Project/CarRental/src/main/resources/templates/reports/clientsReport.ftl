<#import "../parts/common.ftl" as c>
<#import "../parts/nav-bar.ftl" as nav_bar>
<#import "../parts/reports.ftl" as rep>

<@c.page>
    <@rep.parts>
        <div class="col-xs-6 col-sm-4">
            <h3 class="reportsBlocksHeader">Количество аренд со штрафом</h3>
            <h4>От 20 до 35: ${countRentWithFineFirstGroup}</h4>
            <h4>От 35 до 50: ${countRentWithFineSecondGroup}</h4>
            <h4>От 50 до 80: ${countRentWithFineThirdGroup}</h4>
        </div>

        <div class="col-xs-6 col-sm-4">
            <h3 class="reportsBlocksHeader">Кол-во пользователей системы</h3>
            <h4 data-id="countUsersSystem_${countUsers}">${countUsers}</h4>
            <h3 class="reportsBlocksHeader">Кол-во клиентов:</h3>
            <h4 data-id="countClients_${countClients}">${countClients}</h4>
            <h3 class="reportsBlocksHeader">Кол-во менеджеров:</h3>
            <h4 data-id="countManagers_${countManagers}">${countManagers}</h4>
            <h3 class="reportsBlocksHeader">Кол-во администраторов:</h3>
            <h4 data-id="countAdmins_${countAdmins}">${countAdmins}</h4>
        </div>

        <div class="col-xs-6 col-sm-4">
            <h3 class="reportsBlocksHeader">Максимальный возраст клиента</h3>
            <a href="/user/${oldestUser?c}">
                <h4 data-id="maxAgeClients_${maxAgeClients}">${maxAgeClients} лет</h4>
            </a>

            <h3 class="reportsBlocksHeader">Минимальный возраст клиента</h3>
            <a href="/user/${youngestUser?c}">
                <h4 data-id="minAgeClients_${minAgeClients}">${minAgeClients} лет</h4>
            </a>

            <h3 class="reportsBlocksHeader">Средний возраст клиентов</h3>
            <h4 data-id="averageAge_${averageAge}">${averageAge} лет</h4>
        </div>
    </@rep.parts>
</@c.page>