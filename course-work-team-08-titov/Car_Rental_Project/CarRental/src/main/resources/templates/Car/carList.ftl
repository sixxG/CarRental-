<#import "../parts/common.ftl" as c>
<#import "../parts/nav-bar.ftl" as nav_bar>

<@c.page>

    <@nav_bar.nav_bar></@nav_bar.nav_bar>
    List of cars
    <br>

    <span><a href="/addCar">Add Car</a></span>
    <table>
        <thead>
        <tr>
            <th>WIN</th>
            <th>brand</th>
            <th>model</th>
            <th>body</th>
            <th>Class</th>
            <th>year</th>
            <th>mileage</th>
            <th>color</th>
            <th>transmission</th>
            <th>drive</th>
            <th>power</th>
            <th>price</th>
            <th>condition</th>
            <th>image</th>
            <th>description</th>
        </tr>
        </thead>
        <tbody>
        <#list cars as car>
            <tr>
                <td>${car.WIN_Number}</td>
                <td>${car.brand}</td>
                <td>${car.model}</td>
                <td>${car.body}</td>
                <td>${car.level}</td>
                <td>${car.year}</td>
                <td>${car.mileage}</td>
                <td>${car.color}</td>
                <td>${car.transmission}</td>
                <td>${car.drive}</td>
                <td>${car.power}</td>
                <td>${car.price}</td>
                <td>${car.status}</td>
                <td>${car.image}</td>
                <td>${car.description}</td>
            </tr>
            <#else>
            Not elements
        </#list>
        </tbody>
    </table>

</@c.page>
