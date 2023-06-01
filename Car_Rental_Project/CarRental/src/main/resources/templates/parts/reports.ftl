<#macro parts>
    <link href="/static/css/Reports.css" rel="stylesheet"/>

    <div class="container" style="margin-top: 5%;">
        <ul class="nav nav-tabs" style="width: 75em">
            <li class="reportsHeader" id="/reports/cars">
                <a  href="/reports/cars" style="padding: 10px 5px 5px 5px;"><h4>Автомобили</h4></a>
            </li>
            <li class="reportsHeader" id="/reports/contracts">
                <a href="/reports/contracts" style="padding: 10px 5px 5px 5px;"><h4>Аренды</h4></a>
            </li>
            <li class="reportsHeader" id="/reports/clients">
                <a href="/reports/clients" style="padding: 10px 5px 5px 5px;"><h4>Пользователи</h4></a>
            </li>
        </ul>
    </div>

    <script>
        const urlParamsReportsPage = document.location.pathname;

        document.getElementById(urlParamsReportsPage).classList.add("active");
    </script>

    <div class="tab-content">
        <div class="tab-pane fade in active reportsBlocks">
            <div class="row">
                <#nested>
            </div>
        </div>
    </div>
</#macro>