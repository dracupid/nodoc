<% if(moduleName){ %>
### <%= moduleName %>

<% if(moduleDesc){ %>
<%= moduleDesc %>
<% } %>

<% } %>

<% comments.forEach(function(item){ %>
- #### <a href="<%= srcPath %>?source#L<%= item.lineNum %>" target="_blank"><b><%= item.name.replace('_', '\\_') %></b></a>
  <%= item.description.replace(/\n/g, '\n  ') %>

  <% item.tags.forEach(function(tag){ %>
  - **<u><%= tag.tagName %></u>**: <% if(tag.name){ %>`<%= tag.name %>` <% } %><% if(tag.type){ %>{ _<%= tag.type %>_ }<% } %>

    <%= tag.description.replace(/\t/g, '    ').replace(/\n/g, '\n    ') %>
  <% }) %>

<% }); %>
