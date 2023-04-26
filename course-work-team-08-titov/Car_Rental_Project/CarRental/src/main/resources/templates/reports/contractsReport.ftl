<#import "../parts/common.ftl" as c>
<#import "../parts/nav-bar.ftl" as nav_bar>
<#import "../parts/reports.ftl" as rep>

<@c.page>
  <@rep.parts>
    <div class="col-xs-6 col-sm-4">
        <h3 class="reportsBlocksHeader">Популярные места получения</h3>
        <table class="table table-striped table-bordered">
            <thead>
            <tr>
                <th>Статус</th>
                <th>Количество аренд</th>
            </tr>
            </thead>
            <tbody>
            <#list countByTypeReceipt as count>
                <tr>
                    <td data-id="${count[0]}">
                        <a class="carLink" href="/contract/list/all?page=1">${count[0]}</a>
                    </td>
                    <td data-id="${count[0]}_${count[1]}">${count[1]}</td>
                </tr>
            </#list>
            </tbody>
        </table>

        <h3 class="reportsBlocksHeader">Популярные места возврата</h3>
        <table class="table table-striped table-bordered">
            <thead>
            <tr>
                <th>Статус</th>
                <th>Количество аренд</th>
            </tr>
            </thead>
            <tbody>
            <#list countByTypeReturn as count>
                <tr>
                    <td data-id="${count[0]}">
                        <a class="carLink" href="/contract/list/all?page=1">${count[0]}</a>
                    </td>
                    <td data-id="${count[0]}_${count[1]}">${count[1]}</td>
                </tr>
            </#list>
            </tbody>
        </table>

        <a data-toggle="collapse" href="#additionalOptions">
            <h3 class="reportsBlocksHeader">Популярные доп.опции</h3>
        </a>
        <div class="collapse requestBody" id="additionalOptions">
            <table class="table table-striped table-bordered">
                <thead>
                <tr>
                    <th>Опции</th>
                    <th>Частота</th>
                    <th>%</th>
                </tr>
                </thead>
                <tbody>
                <#list countByAdditionalOptions as count>
                    <tr>
                        <td>${count[0]}</td>
                        <td>${count[1]}</td>
                        <td>
                            <#if count[0] == "Видеорегистратор">
                                ${percentVideoReg}%
                            </#if>
                            <#if count[0] == "Авто бокс">
                                ${percentAutoBox}%
                            </#if>
                            <#if count[0] == "Детское кресло">
                                ${percentKidsChair}%
                            </#if>
                        </td>
                    </tr>
                </#list>
                <tr>
                    <td>Всего: </td>
                    <td>${countOptional}</td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>

    <div class="col-xs-6 col-sm-4">
        <h3 class="reportsBlocksHeader">Кол-во аренд</h3>
        <h4 data-id="countContracts_${countContracts}">${countContracts}</h4>
        <h3 class="reportsBlocksHeader">Кол-во аренд за этот месяц</h3>
        <h4 data-id="countRentalForActualMonth_${countRentalForActualMonth}">${countRentalForActualMonth}</h4>

        <h3 class="reportsBlocksHeader">Кол-во аренд со штрафом</h3>
        <h4 data-id="countRentalsWithFine_${countRentalsWithFine}">${countRentalsWithFine}</h4>

        <h3 class="reportsBlocksHeader">Кол-во аренд за период</h3>
        <form class="form-inline" action="/reports/contracts" method="get">
            <div class="form-group mx-sm-3 mb-2">
                <input type="date" class="form-control" name="inputStart" id="inputStart" value="${(firstDayActualMonth).format('yyyy-MM-dd')}"/>
            </div>
            <div class="form-group mx-sm-3 mb-2">
                <input type="date" class="form-control" name="inputEnd" id="inputEnd" value="${(nowDayActualMonth).format('yyyy-MM-dd')}"/>
            </div>
            <button type="submit" class="btn btn-primary mb-2">Выбрать</button>
            <a type="button" href="/reports/contracts" class="btn btn-danger mb-2">reset</a>
        </form>

        <#if contractsForPeriod?has_content>
            <table class="table table-striped table-bordered" data-id="contractsForPeriod">
                <thead>
                <tr>
                    <th style="width: 0%">#</th>
                    <th>Начало</th>
                    <th>Завершение</th>
                    <th>Цена</th>
                </tr>
                </thead>
                <tbody>
                <#assign i = 1>
                <#list contractsForPeriod as count>
                    <tr>
                        <td data-id="${count.getId()}">
                            <a class="carLink" href="/contract/details?id=${count.getId()}">${i}</a>
                        </td>
                        <td>${(count.dateStart).format('yyyy-MM-dd HH:mm:ss')}</td>
                        <td>${(count.dateEnd).format('yyyy-MM-dd HH:mm:ss')}</td>
                        <td>${count.getPrice()}</td>
                    </tr>
                    <#assign i++>
                </#list>
                <tr>
                    <td>Итоговая сумма: </td>
                    <td data-id="resultPrice_${resultPrice}">${resultPrice}</td>
                </tr>
                </tbody>
            </table>
        </#if>

        <a data-toggle="collapse" href="#contractsByStatus">
            <h3 class="reportsBlocksHeader">По статусу:</h3>
        </a>
        <div class="collapse requestBody" id="contractsByStatus">
            <table class="table table-striped table-bordered">
                <thead>
                <tr>
                    <th>Статус</th>
                    <th>Количество аренд</th>
                </tr>
                </thead>
                <tbody>
                <#list countContractsByStatus as count>
                    <tr>
                        <td data-id="status_${count[0]}">
                            <a class="carLink" href="/contract/list/all?status=${count[0]}">${count[0]}</a>
                        </td>
                        <td data-id="${count[0]}_${count[1]}">${count[1]}</td>
                    </tr>
                </#list>
                </tbody>
            </table>
        </div>

    </div>

    <div class="col-xs-6 col-sm-4">
        <h3 class="reportsBlocksHeader">Максимальная цена аренды</h3>
        <a href="/contract/details?id=${idMaxPriceRental}">
            <h4 data-id="maxPriceRental_${maxPriceRental}">${maxPriceRental} рублей</h4>
        </a>
        <h3 class="reportsBlocksHeader">Минимальная цена аренды</h3>
        <a href="/contract/details?id=${idMinPriceRental}">
            <h4 data-id="minPriceRental_${minPriceRental}">${minPriceRental} рублей</h4>
        </a>
        <h3 class="reportsBlocksHeader">Средняя цена аренды</h3>
        <h4 data-id="avgPriceRental_${avgPriceRental}">${avgPriceRental} рублей</h4>
        <a data-toggle="collapse" href="#contractsByManager">
            <h3 class="reportsBlocksHeader">Контракты менеджеров за период:</h3>
        </a>
        <div class="collapse requestBody" id="contractsByManager" >
            <form class="form-inline" action="/reports/contracts" method="get">
                <div class="form-group mx-sm-3 mb-2">
                    <input type="date" class="form-control" name="startPeriod" id="startPeriod" value="${(firstDayActualMonth).format('yyyy-MM-dd')}"/>
                </div>
                <div class="form-group mx-sm-3 mb-2">
                    <input type="date" class="form-control" name="endPeriod" id="endPeriod" value="${(nowDayActualMonth).format('yyyy-MM-dd')}"/>
                </div>
                <button type="submit" class="btn btn-primary mb-2">Выбрать</button>
                <a type="button" href="/reports/contracts" class="btn btn-danger mb-2">reset</a>
            </form>
            <table class="table table-striped table-bordered">
                <thead>
                <tr>
                    <th>Менеджер</th>
                    <th>Количество аренд</th>
                    <th>Общая сумма</th>
                </tr>
                </thead>
                <tbody>
                <#list countContractsByFioManager as count>
                    <tr data-id="countContractsByFioManager">
                        <td data-id="${count[0]}">
                            <a class="carLink" href="/contract/list/all?page=1">${count[0]}</a>
                        </td>
                        <td data-id="${count[0]}_${count[1]}">${count[1]}</td>
                        <td data-id="${count[0]}_${count[2]}">${count[2]}</td>
                    </tr>
                </#list>
                </tbody>
            </table>
        </div>
    </div>
  </@rep.parts>
    <script src="../../static/js/contractsReport.js"></script>
</@c.page>