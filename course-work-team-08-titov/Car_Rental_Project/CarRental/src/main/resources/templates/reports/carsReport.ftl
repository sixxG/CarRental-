<#import "../parts/common.ftl" as c>
<#import "../parts/nav-bar.ftl" as nav_bar>
<#import "../parts/reports.ftl" as rep>

<@c.page>

  <@rep.parts>
    <div class="col-xs-6 col-sm-4">
      <h3 class="reportsBlocksHeader">Популярные автомобили</h3>
      <table class="table table-striped table-bordered">
        <thead>
        <tr>
          <th>Авто</th>
          <th>Количество аренд</th>
        </tr>
        </thead>
        <tbody>
        <#list bestCars as bestCar>
          <tr>
            <td>
              <a href="/car/details?id=${bestCar[0].id}">
                <h5>${bestCar[0].brand} ${bestCar[0].model} ${bestCar[0].year?c}</h5>
              </a>
            </td>
            <td>${bestCar[1]}</td>
          </tr>
        </#list>
        </tbody>
      </table>

      <h3 class="reportsBlocksHeader">Не популярные автомобили</h3>
      <table class="table table-striped table-bordered">
        <thead>
        <tr>
          <th>Авто</th>
          <th>Количество аренд</th>
        </tr>
        </thead>
        <tbody>
        <#list leastCars as leastCar>
          <tr>
            <td>
              <a href="/car/details?id=${leastCar[0].id}">
                <h5>${leastCar[0].brand} ${leastCar[0].model} ${leastCar[0].year?c}</h5>
              </a>
            </td>
            <td>${leastCar[1]!'0'}</td>
          </tr>
        </#list>
        </tbody>
      </table>

      <h3 class="reportsBlocksHeader">По мощности</h3>
      <table class="table table-striped table-bordered">
        <thead>
        <tr>
          <th>Группа</th>
          <th>Количество аренд</th>
        </tr>
        </thead>
        <tbody>
        <#list countRentCarByPower as count>
          <tr>
            <td>${count[0]!'0'}</td>
            <td>${count[1]!'0'}</td>
          </tr>
        </#list>
        </tbody>
      </table>
    </div>

    <div class="col-xs-6 col-sm-4" id="carsCountReport">
      <h3 class="reportsBlocksHeader">Кол-во автомобилей</h3>
      <p data-id="countCars_${countCars}">${countCars}</p>
      <h3 class="reportsBlocksHeader">Свободных</h3>
      <p data-id="countFreeCars_${countFreeCars}">${countFreeCars}</p>
      <h3 class="reportsBlocksHeader">Забронированных</h3>
      <p data-id="countBusyCars_${countBusyCars}">${countBusyCars}</p>

      <a data-toggle="collapse" href="#collapseByClass"><h3 class="reportsBlocksHeader">По классам:</h3></a>
      <div class="collapse requestBody" id="collapseByClass">
        <table class="table table-striped table-bordered">
          <thead>
          <tr>
            <th>Класс</th>
            <th>Количество автомобилей</th>
          </tr>
          </thead>
          <tbody>
          <#list carCounts as count>
            <tr>
              <td data-id="${count[0]}">
                <a class="carLink" href="/carbyclass?carClass=${count[0]}&amp;">${count[0]}</a>
              </td>
              <td data-id="${count[1]}">${count[1]}</td>
            </tr>
          </#list>
          </tbody>
        </table>
      </div>

      <a data-toggle="collapse" href="#collapseByTransmition"><h3 class="reportsBlocksHeader">По типу КП:</h3></a>
      <div class="collapse requestBody" id="collapseByTransmition">
        <table class="table table-striped table-bordered">
          <thead>
          <tr>
            <th>Класс</th>
            <th>Количество автомобилей</th>
          </tr>
          </thead>
          <tbody>
          <#list countByCarTransmission as count>
            <tr>
              <td data-id="${count[0]}">
                <a class="carLink" href="/findCar?ListTypeTransmition=${count[0]}&amp;">${count[0]}</a>
                <#--&PriceOT=&PriceDO=&ListBrand=&power=&year=&mileage=-->
              </td>
              <td data-id="${count[1]}">${count[1]}</td>
            </tr>
          </#list>
          </tbody>
        </table>
      </div>

      <a data-toggle="collapse" href="#collapseByDrive"><h3 class="reportsBlocksHeader">По приводу:</h3></a>
      <div class="collapse requestBody" id="collapseByDrive">
        <table class="table table-striped table-bordered">
          <thead>
          <tr>
            <th>Класс</th>
            <th>Количество автомобилей</th>
          </tr>
          </thead>
          <tbody>
          <#list countByCarDrive as count>
            <tr>
              <td data-id="${count[0]}">
                <a class="carLink" href="/findCar?typeDrive=${count[0]}&amp;">${count[0]}</a>
                <!--&PriceOT=&PriceDO=&ListBrand=&ListTypeTransmition=&power=&year=&mileage=-->
              </td>
              <td data-id="${count[1]}">${count[1]}</td>
            </tr>
          </#list>
          </tbody>
        </table>
      </div>

      <a data-toggle="collapse" href="#collapseByBody"><h3 class="reportsBlocksHeader">По кузову:</h3></a>
      <div class="collapse requestBody" id="collapseByBody">
        <table class="table table-striped table-bordered">
          <thead>
          <tr>
            <th>Класс</th>
            <th>Количество автомобилей</th>
          </tr>
          </thead>
          <tbody>
          <#list countByCarBody as count>
            <tr>
              <td data-id="${count[0]}">
                <a class="carLink" href="/findCar?typeBody=${count[0]}&amp;">${count[0]}</a>
                <!--&PriceOT=&PriceDO=&ListBrand=&ListTypeTransmition=&power=&year=&mileage=-->
              </td>
              <td data-id="${count[1]}">${count[1]}</td>
            </tr>
          </#list>
          </tbody>
        </table>
      </div>

    </div>

    <div class="col-xs-6 col-sm-4">
      <h3 class="reportsBlocksHeader">Максимальная цена аренды за день</h3>
      <a href="/car/details?id=${maxPriceCarId}">
        <h4 data-id="maxPrice_${maxPrice}">${maxPrice}</h4>
      </a>

      <h3 class="reportsBlocksHeader">Минимальная цена аренды за день</h3>
      <a href="/car/details?id=${minPriceCarId}">
        <h4 data-id="minPrice_${minPrice}">${minPrice}</h4>
      </a>

      <h3 class="reportsBlocksHeader">Средняя цена аренды за 1 день</h3>
      <h4 data-id="averagePrice_${averagePrice}">${averagePrice} рублей</h4>

      <hr style="background: #00ff00; height: 1px;"/>

      <h3 class="reportsBlocksHeader">Максимальный возраст авто</h3>
      <a href="/car/details?id=${oldestCarId}">
        <h4 data-id="maxYearCar_${maxYearCar}">${maxYearCar}</h4>
      </a>

      <h3 class="reportsBlocksHeader">Минимальный возраст авто</h3>
      <a href="/car/details?id=${youngestCarId}">
        <h4 data-id="minYearCar_${minYearCar}">${minYearCar}</h4>
      </a>

      <h3 class="reportsBlocksHeader">Средний возраст авто</h3>
      <h4 data-id="averageYear_${averageYear}">${averageYear} лет</h4>

      <hr style="background: #00ff00; height: 1px;"/>

      <h3 class="reportsBlocksHeader">Максимальный пробег авто</h3>
      <a href="/car/details?id=${maxMileageCarId}">
        <h4 data-id="maxMileage_${maxMileage}">${maxMileage}</h4>
      </a>

      <h3 class="reportsBlocksHeader">Минимальный пробег авто</h3>
      <a href="/car/details?id=${minMileageCarId}">
        <h4 data-id="minMileage_${minMileage}">${minMileage}</h4>
      </a>

      <h3 class="reportsBlocksHeader">Средний пробег</h3>
      <h4 data-id="averageMileage_${averageMileage}">${averageMileage} км</h4>
    </div>
  </@>

</@c.page>
