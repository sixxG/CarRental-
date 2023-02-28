<#import "../parts/common.ftl" as c>
<#import "../parts/nav-bar.ftl" as nav_bar>

<@c.page>

<@nav_bar.nav_bar></@nav_bar.nav_bar>
List of users

    <table>
        <thead>
        <tr>
            <th>Name</th>
            <th>Role</th>
        </tr>
        </thead>
        <tbody>
        <#list users as user>
        <tr>
            <td>${user.username}</td>
            <td><#list user.roles as role>${role.name}<#sep>, </#list></td>
            <td>
                <a href="/user/${user.id}">Edit</a>
            </td>
        </tr>
        </#list>
        </tbody>
    </table>

</@c.page>
