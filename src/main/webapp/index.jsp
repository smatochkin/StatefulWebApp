<%@ page session="true" import="java.util.*" import="java.io.*" import="java.net.*" %>
<html>
  <style>
    .two {background: #2B65EC;}
    .one {background: lightgreen;}
    .vip {background: salmon;}
  </style>
<head>
  <title>Simple Web App</title>
</head>
<body>
  <center>
  <h1>Stateful Web App</h1>
  This is a simple <b>stateful</b> application.<p/>
  <table>
  <tr><td>Current time</td><td><%= new java.util.Date() %></td></tr>
  <%
          String tdClass = "";
          if (request.getLocalAddr().matches(".*123.*")) {
            tdClass = " class=\"one\"";
          } else if (request.getLocalAddr().matches(".*122.*")) {
            tdClass = " class=\"two\"";
          } else {
            tdClass = " class=\"vip\"";
          }
  %>
  <tr><td>Front-end server</td><td><%= request.getLocalAddr() %></td></tr>
  <%
    Enumeration<NetworkInterface> nets = NetworkInterface.getNetworkInterfaces();
    for (NetworkInterface netint : Collections.list(nets)) {
      if (netint.getName().equals("lo"))
        continue;
      Enumeration<InetAddress> inetAddresses = netint.getInetAddresses();
      for (InetAddress inetAddress : Collections.list(inetAddresses)) {
          if (inetAddress.toString().matches(".*123.*")) {
            tdClass = " class=\"one\"";
            out.println("  <tr><td>Back-end server IP</td><td" + tdClass +">" + inetAddress + "</td></tr>");
          } else if (inetAddress.toString().matches(".*122.*")) {
            tdClass = " class=\"two\"";
            out.println("  <tr><td>Back-end server IP</td><td" + tdClass +">" + inetAddress + "</td></tr>");
          } else {
            tdClass = " class=\"vip\"";
          }
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
