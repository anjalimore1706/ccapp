<%@ page import="java.net.*" %>
<%@ page import="java.io.*" %>
<%@ page import="org.json.*" %>

<html>

<head>

<title>
Live CC App by Riddhi
</title>

<style>

* {
    font-size: 50px;
    text-align: center;
}

body {
    background-color: azure;
}

</style>

<script>

function check()
{
    let aid = document.getElementById("id_aid");
    let msg = document.getElementById("id_msg");

    if (aid.value === "")
    {
        alert("please enter amt");
        aid.focus();
        msg.textContent = "";
        return false;
    }

    return true;
}

</script>

</head>

<body>

<h1>Live CC App</h1>

<form onsubmit="return check()">

<input type="number"
       step="0.01"
       name="aid"
       id="id_aid"
       placeholder="Enter Amount in $"
/>

<br/><br/>

<input type="submit"
       value="Convert to &#8377"
       name="btn"
/>

</form>

<%

if ((request.getParameter("btn") != null) &&
    (!request.getParameter("aid").equals("")))
{
    try
    {
        double aid =
        Double.parseDouble(request.getParameter("aid"));

        // api ka url
        String apiUrl =
        "https://api.exchangerate-api.com/v4/latest/USD";

        // connect karo
        URI uri = URI.create(apiUrl);
        URL url = uri.toURL();

        HttpURLConnection con =
        (HttpURLConnection)url.openConnection();

        con.setRequestMethod("GET");

        // download karo
        InputStreamReader isr =
        new InputStreamReader(con.getInputStream());

        BufferedReader br =
        new BufferedReader(isr);

        String jsonData = "";
        String line = br.readLine();

        while (line != null)
        {
            jsonData = jsonData + line;
            line = br.readLine();
        }

        // process karo
        JSONObject jo = new JSONObject(jsonData);

        JSONObject rates =
        jo.getJSONObject("rates");

        double DOLLAR =
        rates.getDouble("INR");

        double air =
        aid * DOLLAR;

        String msg =
        "&#8377 " + String.format("%.2f", air);

%>

<h2 id="id_msg"><%=msg %></h2>

<%

    }

    catch(NumberFormatException e)
    {
        out.println("please enter numbers only");
    }

    catch(Exception e)
    {
        out.println("issue " + e);
    }
}

%>

</body>

</html>