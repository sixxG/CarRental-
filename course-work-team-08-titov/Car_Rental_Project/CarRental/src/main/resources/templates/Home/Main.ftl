<#import "../parts/common.ftl" as c>

<@c.page>
<div>
    <form action="/logout" method="post">
        <input type="submit" value="Sign Out">
        <input type="hidden" name="_csrf" value="${_csrf.token}">
    </form>
</div>

<h1>Main page</h1>

    <h1>Hello, ${name}</h1>
</@c.page>