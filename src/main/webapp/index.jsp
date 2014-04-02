<%@ page session="true" import="java.util.*" import="java.io.*" import="java.net.*" %>
<%
  String[] ipa = request.getLocalAddr().toString().split("\\.");
%>
<html>
  <style>
    .ip  {
      background-color: rgb(<%= ipa[1] %>, <%= ipa[2] %>, <%= ipa[3] %>);
      color: rgb(<%= 255 - Integer.parseInt(ipa[1]) %>, <%= 255 - Integer.parseInt(ipa[2]) %>, <%= 255 - Integer.parseInt(ipa[3]) %>);
    }
  </style>
<head>
  <title>Simple Web App</title>
</head>
<body>
  <center>
  <h1>Stateful Web App</h1>
  This is a simple <b>stateful</b> application.<p/>
  <table>
  <tr><td class="ip">Current time</td><td><%= new java.util.Date() %></td></tr>
  <tr><td>Front-end server</td><td><%= request.getLocalAddr() %></td></tr>
  <%
    Enumeration<NetworkInterface> nets = NetworkInterface.getNetworkInterfaces();
    for (NetworkInterface netint : Collections.list(nets)) {
      if (netint.getName().equals("lo"))
        continue;
      Enumeration<InetAddress> inetAddresses = netint.getInetAddresses();
      for (InetAddress inetAddress : Collections.list(inetAddresses)) {
        // out.println("  <tr><td>Back-end server IP</td><td>" + inetAddress + "</td></tr>");
        %><tr><td>Back-end server IP</td><td><%= inetAddress %></td></tr><%
      }
    }
  %>
  <%
    if (session.getAttribute("counter") == null) {
      session.setAttribute("counter", 1);
    } else {
      session.setAttribute("counter", (Integer)session.getAttribute("counter") + 1);
    }
  %>
  <tr><td>Session id</td><td><%= session.getId() %></td></tr>
  <tr><td>Session creation time</td><td><%= session.getAttribute("time") == null ? "Now" : session.getAttribute("time") %></td></tr>
  <tr><td>Request count</td><td><%= session.getAttribute("counter") %></td></tr>
  </table>
  <%
    if (session.getAttribute("time") == null) {
      session.setAttribute("time", (new java.util.Date()).toString());
    }
  %>
</body>
</html>
