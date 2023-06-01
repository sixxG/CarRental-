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
              <a href="/car/details?id=${bestCar[0].id?c}">
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
              <a href="/car/details?id=${leastCar[0].id?c}">
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
        <div id="containerСountByCarLevel" style="width: 100%; height: 400px; margin: 0 auto;"></div>

<#--        <table class="table table-striped table-bordered">-->
<#--          <thead>-->
<#--          <tr>-->
<#--            <th>Класс</th>-->
<#--            <th>Количество автомобилей</th>-->
<#--          </tr>-->
<#--          </thead>-->
<#--          <tbody>-->
<#--          <#list carCounts as count>-->
<#--            <tr>-->
<#--              <td data-id="${count[0]}">-->
<#--                <a class="carLink" href="/carbyclass?carClass=${count[0]}&amp;">${count[0]}</a>-->
<#--              </td>-->
<#--              <td data-id="${count[1]}">${count[1]}</td>-->
<#--            </tr>-->
<#--          </#list>-->
<#--          </tbody>-->
<#--        </table>-->
      </div>

      <a data-toggle="collapse" href="#collapseByTransmition"><h3 class="reportsBlocksHeader">По типу КП:</h3></a>
      <div class="collapse requestBody" id="collapseByTransmition">
        <div id="containerСountByCarTransmission" style="width: 100%; height: 400px; margin: 0 auto;"></div>

<#--        <table class="table table-striped table-bordered">-->
<#--          <thead>-->
<#--          <tr>-->
<#--            <th>Класс</th>-->
<#--            <th>Количество автомобилей</th>-->
<#--          </tr>-->
<#--          </thead>-->
<#--          <tbody>-->
<#--          <#list countByCarTransmission as count>-->
<#--            <tr>-->
<#--              <td data-id="${count[0]}">-->
<#--                <a class="carLink" href="/findCar?ListTypeTransmition=${count[0]}&amp;">${count[0]}</a>-->
<#--                &lt;#&ndash;&PriceOT=&PriceDO=&ListBrand=&power=&year=&mileage=&ndash;&gt;-->
<#--              </td>-->
<#--              <td data-id="${count[1]}">${count[1]}</td>-->
<#--            </tr>-->
<#--          </#list>-->
<#--          </tbody>-->
<#--        </table>-->
      </div>

      <a data-toggle="collapse" href="#collapseByDrive"><h3 class="reportsBlocksHeader">По приводу:</h3></a>
      <div class="collapse requestBody" id="collapseByDrive">
        <div id="containerCountByCarDrive" style="width: 100%; height: 400px; margin: 0 auto;"></div>
<#--        <table class="table table-striped table-bordered">-->
<#--          <thead>-->
<#--          <tr>-->
<#--            <th>Класс</th>-->
<#--            <th>Количество автомобилей</th>-->
<#--          </tr>-->
<#--          </thead>-->
<#--          <tbody>-->
<#--          <#list countByCarDrive as count>-->
<#--            <tr>-->
<#--              <td data-id="${count[0]}">-->
<#--                <a class="carLink" href="/findCar?typeDrive=${count[0]}&amp;">${count[0]}</a>-->
<#--                <!--&PriceOT=&PriceDO=&ListBrand=&ListTypeTransmition=&power=&year=&mileage=&ndash;&gt;-->
<#--              </td>-->
<#--              <td data-id="${count[1]}">${count[1]}</td>-->
<#--            </tr>-->
<#--          </#list>-->
<#--          </tbody>-->
<#--        </table>-->
      </div>

      <a data-toggle="collapse" href="#collapseByBody"><h3 class="reportsBlocksHeader">По кузову:</h3></a>
      <div class="collapse requestBody" id="collapseByBody">
        <div id="containerСountByCarBody" style="width: 100%; height: 400px; margin: 0 auto;"></div>
<#--        <table class="table table-striped table-bordered">-->
<#--          <thead>-->
<#--          <tr>-->
<#--            <th>Класс</th>-->
<#--            <th>Количество автомобилей</th>-->
<#--          </tr>-->
<#--          </thead>-->
<#--          <tbody>-->
<#--          <#list countByCarBody as count>-->
<#--            <tr>-->
<#--              <td data-id="${count[0]}">-->
<#--                <a class="carLink" href="/findCar?typeBody=${count[0]}&amp;">${count[0]}</a>-->
<#--                <!--&PriceOT=&PriceDO=&ListBrand=&ListTypeTransmition=&power=&year=&mileage=&ndash;&gt;-->
<#--              </td>-->
<#--              <td data-id="${count[1]}">${count[1]}</td>-->
<#--            </tr>-->
<#--          </#list>-->
<#--          </tbody>-->
<#--        </table>-->
      </div>

    </div>

    <div class="col-xs-6 col-sm-4">
      <h3 class="reportsBlocksHeader">Максимальная цена аренды за день</h3>
      <a href="/car/details?id=${maxPriceCarId?c}">
        <h4 data-id="maxPrice_${maxPrice}">${maxPrice}</h4>
      </a>

      <h3 class="reportsBlocksHeader">Минимальная цена аренды за день</h3>
      <a href="/car/details?id=${minPriceCarId?c}">
        <h4 data-id="minPrice_${minPrice}">${minPrice}</h4>
      </a>

      <h3 class="reportsBlocksHeader">Средняя цена аренды за 1 день</h3>
      <h4 data-id="averagePrice_${averagePrice}">${averagePrice} рублей</h4>

      <hr style="background: #00ff00; height: 1px;"/>

      <h3 class="reportsBlocksHeader">Максимальный возраст авто</h3>
      <a href="/car/details?id=${oldestCarId?c}">
        <h4 data-id="maxYearCar_${maxYearCar}">${maxYearCar}</h4>
      </a>

      <h3 class="reportsBlocksHeader">Минимальный возраст авто</h3>
      <a href="/car/details?id=${youngestCarId?c}">
        <h4 data-id="minYearCar_${minYearCar}">${minYearCar}</h4>
      </a>

      <h3 class="reportsBlocksHeader">Средний возраст авто</h3>
      <h4 data-id="averageYear_${averageYear}">${averageYear} лет</h4>

      <hr style="background: #00ff00; height: 1px;"/>

      <h3 class="reportsBlocksHeader">Максимальный пробег авто</h3>
      <a href="/car/details?id=${maxMileageCarId?c}">
        <h4 data-id="maxMileage_${maxMileage}">${maxMileage}</h4>
      </a>

      <h3 class="reportsBlocksHeader">Минимальный пробег авто</h3>
      <a href="/car/details?id=${minMileageCarId?c}">
        <h4 data-id="minMileage_${minMileage}">${minMileage}</h4>
      </a>

      <h3 class="reportsBlocksHeader">Средний пробег</h3>
      <h4 data-id="averageMileage_${averageMileage}">${averageMileage} км</h4>
    </div>
  </@>

  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>

  <script src="https://code.highcharts.com/highcharts.js"></script>
  <script src="https://code.highcharts.com/modules/exporting.js"></script>
  <script>
    const carCount = ${countCars};

    const countByCarBodyKeySet = [<#list countByCarBodyKeySet as key>'${key}', </#list>];
    const countByCarDriveKeySetKeySet = [<#list countByCarDriveKeySet as key>'${key}', </#list>];
    const countByCarLevelValues = [<#list countByCarLevelValues as value>${value}, </#list>];
    console.log(countByCarLevelValues);
    const countByCarTransmissionKeySet = [<#list countByCarTransmissionKeySet as key>'${key}', </#list>];

    //countByCarBodyKeySet
    $(function(){
      Highcharts.chart('containerСountByCarBody', {
        chart: {
          type: 'column'
        },

        legend: {
          itemStyle: {
            fontSize: "15px"
          }
        },

        title: {
          text: 'CarFY',
          style: {
            fontSize:'16px'
          }
        },
        subtitle: {
          text: 'Автомобили по кузову',
          style: {
            fontSize:'25px'
          }
        },

        xAxis: {
          categories: countByCarBodyKeySet,
          crosshair: true,
          labels: {
            style: {
              color: 'red',
              fontSize:'16px'
            }
          }
        },
        yAxis: {
          min: 0,
          max: carCount,
          title: {
            text: 'Количество',
            style: {
              fontSize:'20px'
            }
          },
          labels: {
            style: {
              fontSize:'16px'
            }
          }
        },
        tooltip: {
          headerFormat: '<span style="font-size:20px">{point.key}</span><table>',
          pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                  '<td style="padding:0"><b>{point.y:.1f} K</b></td></tr>',
          footerFormat: '</table>',
          shared: true,
          useHTML: true
        },
        plotOptions: {
          column: {
            pointPadding: 0,
            borderWidth: 0
          }
        },
        series: [{
          name: 'Кузов',
          style: {
            fontSize:'16px'
          },
          data: [
            <#list countByCarBodyValues as value>
              <#if value_has_next>
                ${value},
                <#else>
                ${value}
              </#if>
            </#list>
          ]
        }],
      });
    });
    //countByCarDriveKeySetKeySet
    $(function(){
      Highcharts.chart('containerCountByCarDrive', {
        chart: {
          type: 'column'
        },

        legend: {
          itemStyle: {
            fontSize: "15px"
          }
        },

        title: {
          text: 'CarFY',
          style: {
            fontSize:'16px'
          }
        },
        subtitle: {
          text: 'Автомобили по приводу',
          style: {
            fontSize:'25px'
          }
        },

        xAxis: {
          categories: countByCarDriveKeySetKeySet,
          crosshair: true,
          labels: {
            style: {
              color: 'red',
              fontSize:'16px'
            }
          }
        },
        yAxis: {
          min: 0,
          max: carCount,
          title: {
            text: 'Количество',
            style: {
              fontSize:'20px'
            }
          },
          labels: {
            style: {
              fontSize:'16px'
            }
          }
        },
        tooltip: {
          headerFormat: '<span style="font-size:20px">{point.key}</span><table>',
          pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                  '<td style="padding:0"><b>{point.y:.1f} K</b></td></tr>',
          footerFormat: '</table>',
          shared: true,
          useHTML: true
        },
        plotOptions: {
          column: {
            pointPadding: 0,
            borderWidth: 0
          }
        },
        series: [{
          name: 'Привод',
          style: {
            fontSize:'16px'
          },
          data: [
            <#list countByCarDriveValues as value>
              <#if value_has_next>
              ${value},
              <#else>
              ${value}
              </#if>
            </#list>
          ]
        }],
      });
    });
    //countByCarLevelKeySet
    $(function(){
      Highcharts.chart('containerСountByCarTransmission', {
        chart: {
          type: 'column'
        },

        legend: {
          itemStyle: {
            fontSize: "15px"
          }
        },

        title: {
          text: 'CarFY',
          style: {
            fontSize:'16px'
          }
        },
        subtitle: {
          text: 'Автомобили по трансмиссии',
          style: {
            fontSize:'25px'
          }
        },

        xAxis: {
          categories: countByCarTransmissionKeySet,
          crosshair: true,
          labels: {
            style: {
              color: 'red',
              fontSize:'16px'
            }
          }
        },
        yAxis: {
          min: 0,
          max: carCount,
          title: {
            text: 'Количество',
            style: {
              fontSize:'20px'
            }
          },
          labels: {
            style: {
              fontSize:'16px'
            }
          }
        },
        tooltip: {
          headerFormat: '<span style="font-size:20px">{point.key}</span><table>',
          pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                  '<td style="padding:0"><b>{point.y:.1f} K</b></td></tr>',
          footerFormat: '</table>',
          shared: true,
          useHTML: true
        },
        plotOptions: {
          column: {
            pointPadding: 0,
            borderWidth: 0
          }
        },
        series: [{
          name: 'Трансмиссия',
          style: {
            fontSize:'16px'
          },
          data: [
            <#list countByCarTransmissionValues as value>
            <#if value_has_next>
            ${value},
            <#else>
            ${value}
            </#if>
            </#list>
          ]
        }],
      });
    });
    //countByCarTransmissionKeySet
    $(function() {
      Highcharts.chart('containerСountByCarLevel', {
        chart: {
          type: 'pie'
        },

        legend: {
          itemStyle: {
            fontSize: "15px"
          }
        },

        title: {
          text: 'CarFY',
          style: {
            fontSize:'16px'
          },
          align: 'left'
        },
        subtitle: {
          text: 'Количество авто по классам',
          style: {
            fontSize:'16px'
          },
          align: 'left'
        },

        accessibility: {
          announceNewData: {
            enabled: true
          }
        },

        plotOptions: {
          series: {
            borderRadius: 3,
            dataLabels: {
              enabled: true,
              format: '{point.name}: {point.y}',
              style: {
                fontSize:'14px'
              },
            }
          }
        },

        tooltip: {
          headerFormat: '<span style="font-size:11px">{series.name}</span><br>',
          pointFormat: '<span style="color:{point.color}">{point.name}</span>: <b>{point.y}</b> шт<br/>',
          style: {
            fontSize:'16px'
          }
        },

        series: [
          {
            name: 'Автопарк',
            colorByPoint: true,
            data: [
              {
                name: 'Эконом',
                y: countByCarLevelValues.at(0)
              },
              {
                name: 'Комфорт',
                y: countByCarLevelValues.at(1)
              },
              {
                name: 'Бизнес',
                y: countByCarLevelValues.at(2)
              },
              {
                name: 'Premium',
                y: countByCarLevelValues.at(3)
              },
              {
                name: 'Внедорожники',
                y: countByCarLevelValues.at(4)
              },
              {
                name: 'Минивэны',
                y: countByCarLevelValues.at(5)
              },
              {
                name: 'Уникальные авто',
                y: countByCarLevelValues.at(6)
              }
            ]
          }
        ]
      });
    });

  </script>
</@c.page>
