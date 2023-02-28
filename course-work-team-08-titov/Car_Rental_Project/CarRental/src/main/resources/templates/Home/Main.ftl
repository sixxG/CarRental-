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

    <form method="post" enctype="multipart/form-data">
        <input type="file" name="file">
        <input type="hidden" name="_csrf" value="${_csrf.token}">
        <button type="submit">Save</button>
    </form>
    <div>

    </div>

    <span>
        <a href="/user">User list</a>
    </span>
    <br>
    <span>
        <a href="/car">Car list</a>
    </span>
</@c.page>