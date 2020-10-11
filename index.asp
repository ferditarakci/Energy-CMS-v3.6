<!--#include file="include/inc.asp"-->
<%
Select Case GlobalConfig("request_option")
	Case GlobalConfig("General_Server")
		Response.Clear()

		%><!--#include file="files/server.asp"--><%

		Response.Flush()
		Call CloseDatabase(data)
		Response.End()
End Select

%>
<!--#include file="themes/index.asp"-->
<%
Call CloseDatabase(data)
Set Lang = Nothing
Set GlobalConfig = Nothing
%>

