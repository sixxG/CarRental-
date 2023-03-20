<#import "../parts/common.ftl" as c>
<#import "../parts/nav-bar.ftl" as nav_bar>
<#import "../parts/car.ftl" as carParts>
<#include "../parts/security.ftl">


<@c.page>

    <div style="margin-top: 5%">
        <div class="container body-content" style="display: flex; flex-direction: column; min-height: 100%; width: 100%;">

            <form action="/car/edit" enctype="multipart/form-data" method="post">
                <@carParts.createForm></@carParts.createForm>
            </form>

            <br />

        </div>
    </div>

</@c.page>
