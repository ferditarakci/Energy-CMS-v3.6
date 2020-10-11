<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
                xmlns:html="http://www.w3.org/TR/REC-html40"
                xmlns:sitemap="http://www.sitemaps.org/schemas/sitemap/0.9"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" version="1.0" encoding="UTF-8" indent="yes" />
	<xsl:template match="/">
		<html xmlns="http://www.w3.org/1999/xhtml">
			<head>
				<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
				<meta http-equiv="Cache-Control" content="private" />
				<meta http-equiv="pragma" content="no-cache" />
				<meta name="robots" content="noindex, follow, noarchive, noimageindex" />
				<meta name="author" content="Ferdi Tarakcı" />
				<meta name="reply-to" content="bilgi@webtasarimx.net" />
				<title>webtasarimx.net - Site Haritası</title>
				<style type="text/css">
					*{
						margin:0;
						padding:0;
					}
					a {
						/*display:block;*/
						padding-bottom:3px;
						font-family:"Comic Sans MS";
						font-size:11px;
						font-weight:normal;
						font-style:normal;
						color:#222;
						text-decoration:none;
						border-bottom:1px transparent dotted;
					}
					a:hover {
						color:#666;
						border-bottom-color:#666;
					}
					body {
						font-family:"Comic Sans MS";
						font-size:13px;
						margin:0 auto;
						padding:0 2px;
					}
					#logo {
						overflow:hidden;
						margin:0px 5px;
						padding-top:10px;
					}
					img {border:none}
					h1 {
						float:right;
						margin-top:10px;
						margin-right:10px;
					}
					h2 {
						float:left;
						margin-top:10px;
						margin-left:10px;
					}
					h1 a {
						display:block;
						padding-bottom:3px;
						font-family:"Comic Sans MS";
						font-size:14px;
						font-weight:bold;
						font-style:italic;
						color:#222;
						text-decoration:none;
						border-bottom:1px transparent dotted;
					}
					h1 a:hover {
						color:#666;
						border-bottom-color:#666;
					}
					#intro {
						background-color:#CFEBF7;
						border:1px #2580B2 solid;
						padding:5px 13px 5px 13px;
						margin:10px;
					}
					#intro p {
						line-height: 16.8667px;
					}
					#intro strong {
						font-weight:normal;
					}
					tr.row:hover {background-color:#b2ebfe}
					td {
						padding:7px 2px;
						font-family:"Comic Sans MS";
						font-size:11px;
						font-weight:normal;
					}
					th {
						padding:7px 2px;
						font-size:13px;
						font-weight:normal;
						text-align:left;
						border-bottom:1px #aaa solid;
					}
					tr.high {
						background-color:whitesmoke;
					}
					#footer {
						padding:2px;
						margin:30px auto 10px;
						text-align:center;
						font-size:8pt;
						color:#111;
					}
					#footer a {
						color:#111;
						text-decoration:none;
					}
					#footer a:hover {
						text-decoration:underline;
					}
					#content{clear: both; display: block; widht: 100%;}
				</style>
			</head>
			<body>
				<div id="logo">
					<hgroup>
						<h1>
							<a href="../" title="Web Tasarım">webtasarimx.net - Site Haritası</a>
						</h1>
						<h2>
							<a href="http://www.webtasarimx.net/" title="Web Tasarım"><img src="../images/web-tasarim-logo.png" alt="Web Tasarım" /></a>
						</h2>
					</hgroup>
					<br style="clear:both;" />
				</div>
				<xsl:apply-templates></xsl:apply-templates>
				<div id="footer">
					Copyright 2010 - 2012 webtasarimx.net <a href="http://www.webtasarimx.net/" title="Energy XML Sitemap Generator Plugins">XML Sitemap Generator Plugins</a>
				</div>
			</body>
		</html>
	</xsl:template>
	
	
	<xsl:template match="sitemap:urlset">
		<div id="content">
			<table style="clear: both;" width="100%" cellpadding="5">
				<tr>
					<th>URL</th>
					<th>Priority</th>
					<th>Change frequency</th>
					<th>Last modified (GMT +2)</th>
				</tr>
				<xsl:variable name="lower" select="'abcçdefgğhıijklmnoöpqrsştuüvwxyz'"/>
				<xsl:variable name="upper" select="'ABCÇDEFGĞHIİJKLMNOÖPQRSŞTUÜVWXYZ'"/>
				<xsl:for-each select="./sitemap:url">
					<tr class="row">
						<xsl:if test="position() mod 2 != 0">
							<xsl:attribute name="class">row high</xsl:attribute>
						</xsl:if>
						<td>
							<xsl:variable name="itemURL">
								<xsl:value-of select="sitemap:loc"/>
							</xsl:variable>
							<xsl:value-of select="position()"/> : <a href="{$itemURL}" title="Adrese Git" target="_blank">
								<xsl:value-of select="sitemap:loc"/>
							</a>
						</td>
						<td>
							<xsl:value-of select="concat(sitemap:priority * 100, '%')"/>
						</td>
						<td>
							<xsl:value-of select="concat(translate(substring(sitemap:changefreq, 1, 1),concat($lower, $upper),concat($upper, $lower)),substring(sitemap:changefreq, 2))"/>
						</td>
						<td>
							<xsl:value-of select="concat(substring(sitemap:lastmod,0,11),concat(' ', substring(sitemap:lastmod,12,5)))"/>
						</td>
					</tr>
				</xsl:for-each>
			</table>
		</div>
	</xsl:template>

	<xsl:template match="sitemap:sitemapindex">
		<div id="content">
			<table cellpadding="5">
				<tr style="border-bottom:1px black solid;">
					<th>URL</th>
					<th>Last modified (GMT)</th>
				</tr>
				<xsl:for-each select="./sitemap:sitemap">
					<tr>
						<xsl:if test="position() mod 2 != 1">
							<xsl:attribute  name="class">row high</xsl:attribute>
						</xsl:if>
						<td>
							<xsl:variable name="itemURL">
								<xsl:value-of select="sitemap:loc"/>
							</xsl:variable>
							<xsl:value-of select="position()"/> : <a href="{$itemURL}" title="Adrese Git" target="_blank">
								<xsl:value-of select="sitemap:loc"/>
							</a>
						</td>
						<td>
							<xsl:value-of select="concat(substring(sitemap:lastmod, 0, 11),concat(' ', substring(sitemap:lastmod,12,5)))"/>
						</td>
					</tr>
				</xsl:for-each>
			</table>
		</div>
	</xsl:template>
</xsl:stylesheet>