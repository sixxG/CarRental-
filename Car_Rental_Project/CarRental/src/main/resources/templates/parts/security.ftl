<#assign
    known = Session.SPRING_SECURITY_CONTEXT??
>

<#if known>
    <#assign
        user = Session.SPRING_SECURITY_CONTEXT.authentication.principal

        name = user.getUsername()
        isAdmin = user.getAuthorities()?seq_contains('ADMIN')
        isManager = user.getAuthorities()?seq_contains('MANAGER')
        isUser = user.getAuthorities()?seq_contains('USER')
    >
<#else>
    <#assign
        name = ""
        isAdmin = false
        isManager = false
        isUser = false
    >
</#if>