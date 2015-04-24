<cfsetting showdebugoutput="no">
<cfheader name="Content-Type" value="application/json">

<cfif structKeyExists(url,'state')>
	<cfoutput>
		<cfquery name="myQuery" datasource="crimeDataset">  
			select Year,SUM(total) As SUM from d3js.crimedataset where STATE_UT = <cfqueryparam value="#url.state#"
			cfsqltype="cf_sql_varhcar"> group by Year;
		</cfquery>
	</cfoutput>
</cfif>

<cfoutput>
#SerializeJSON(myQuery,true)#
</cfoutput>