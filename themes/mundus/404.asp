<!--#include file="header.asp"-->

	<div id="mainfull" class="ewy_content">
		<%
			'With Response
			'	'.Write("<div class=""ewy_sys_msg warning tn""><div class=""ewy_messages""><span>" & Lang("err_not_found") & "</span></div></div>")
			'	.Status = "404 Not Found"
			'	.AddHeader "status", "404 Not Found"
			'	.AddHeader "X-Robots-Tag", "noindex, nofollow, noarchive, noimageindex"
			'End With
		%>
		<div class="error404">
			<h1><%

			Response.Write( Replace(Lang("err_not_found"), "404 - ", "<span>404</span><br /><br /> ") )

			%></h1>
		</div>
	</div> <!-- #main End -->

<!--#include file="footer.asp"-->

