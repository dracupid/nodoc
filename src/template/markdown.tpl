<%
    function maybe (val, tpl) {
        if (val) {
            val = val.replace('_', '\\_')
        }
        return val ? tpl.replace('%s', val) : ''
    }
%>
<% if(moduleName){ %>
### <%= moduleName %>

<% if(moduleDesc){ %>
<%= moduleDesc %>
<% } %>

<% } %>

<% comments.forEach(function(item){ %>
- #### <a href="<%= srcPath %>?source#L<%= item.lineNum %>" target="_blank"><b><%= item.name.replace('_', '\\_') %> <%= maybe(item.sign, '%s') %><%= maybe(item.alias, '  <small>(alias: %s)</small> ') %></b></a>
    <p style = 'margin-bottom: -12px'></p>
    <%= item.description.replace(/\n/g, '\n  ') %>

  <% item.tags.forEach(function(tag){ %>
  - **<%= tag.tagName %>**: <%= maybe(tag.name, '`%s`') %> <%= maybe(tag.type, '{ _%s_ }') %><br/>
    <p style = 'margin-bottom: -12px'></p>
    <%= tag.description.replace(/\t/g, '    ').replace(/\n/g, '\n    ') %>
  <% }) %>

<% }); %>
